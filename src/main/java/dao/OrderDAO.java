package dao;

import model.Order;
import model.OrderItem;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    /** Place order. Returns generated order ID, or -1 on failure. */
    public int placeOrder(Order order) {
        String orderSql =
            "INSERT INTO orders (user_id, total_amount, status, " +
            "  shipping_name, shipping_phone, shipping_address, " +
            "  shipping_city, shipping_state, shipping_pincode, payment_method) " +
            "VALUES (?,?,?,?,?,?,?,?,?,?)";
        String itemSql =
            "INSERT INTO order_items (order_id, product_id, quantity, unit_price) " +
            "VALUES (?,?,?,?)";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            // Insert order
            PreparedStatement ps = conn.prepareStatement(
                orderSql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getUserId());
            ps.setBigDecimal(2, order.getTotalAmount());
            ps.setString(3, "pending");
            ps.setString(4, order.getShippingName());
            ps.setString(5, order.getShippingPhone());
            ps.setString(6, order.getShippingAddress());
            ps.setString(7, order.getShippingCity());
            ps.setString(8, order.getShippingState());
            ps.setString(9, order.getShippingPincode());
            ps.setString(10, order.getPaymentMethod());
            ps.executeUpdate();

            ResultSet keys = ps.getGeneratedKeys();
            int orderId = -1;
            if (keys.next()) orderId = keys.getInt(1);
            ps.close();

            // Insert items
            PreparedStatement itemPs = conn.prepareStatement(itemSql);
            for (OrderItem item : order.getItems()) {
                itemPs.setInt(1, orderId);
                itemPs.setInt(2, item.getProductId());
                itemPs.setInt(3, item.getQuantity());
                itemPs.setBigDecimal(4, item.getUnitPrice());
                itemPs.addBatch();
            }
            itemPs.executeBatch();
            itemPs.close();

            conn.commit();
            return orderId;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            return -1;
        } finally {
            DBUtil.closeConnection(conn);
        }
    }

    /** Orders for a specific user, newest first. */
    public List<Order> getOrdersByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY placed_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapOrder(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** All orders (admin view), newest first. */
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql =
            "SELECT o.*, u.name AS user_name " +
            "FROM orders o JOIN users u ON o.user_id = u.id " +
            "ORDER BY o.placed_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order o = mapOrder(rs);
                o.setUserName(rs.getString("user_name"));
                list.add(o);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Single order with items. */
    public Order getOrderById(int orderId) {
        String sql = "SELECT o.*, u.name AS user_name " +
                     "FROM orders o JOIN users u ON o.user_id = u.id WHERE o.id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order order = mapOrder(rs);
                order.setUserName(rs.getString("user_name"));
                order.setItems(getItemsByOrder(orderId));
                return order;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /** Update order status (admin). */
    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    /** Count all orders (dashboard). */
    public int countOrders() {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM orders");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    /** Sum of all confirmed revenue (dashboard). */
    public double getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_amount),0) FROM orders WHERE status != 'cancelled'";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private List<OrderItem> getItemsByOrder(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql =
            "SELECT oi.*, p.name AS product_name, p.image_url " +
            "FROM order_items oi JOIN products p ON oi.product_id = p.id " +
            "WHERE oi.order_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setImageUrl(rs.getString("image_url"));
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getBigDecimal("unit_price"));
                items.add(item);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return items;
    }

    private Order mapOrder(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setId(rs.getInt("id"));
        o.setUserId(rs.getInt("user_id"));
        o.setTotalAmount(rs.getBigDecimal("total_amount"));
        o.setStatus(rs.getString("status"));
        o.setShippingName(rs.getString("shipping_name"));
        o.setShippingPhone(rs.getString("shipping_phone"));
        o.setShippingAddress(rs.getString("shipping_address"));
        o.setShippingCity(rs.getString("shipping_city"));
        o.setShippingState(rs.getString("shipping_state"));
        o.setShippingPincode(rs.getString("shipping_pincode"));
        o.setPaymentMethod(rs.getString("payment_method"));
        o.setPlacedAt(rs.getTimestamp("placed_at"));
        return o;
    }
}
