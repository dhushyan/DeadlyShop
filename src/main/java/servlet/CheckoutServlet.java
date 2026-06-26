package servlet;

import dao.CartDAO;
import dao.CategoryDAO;
import dao.OrderDAO;
import model.CartItem;
import model.Category;
import model.Order;
import model.OrderItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartDAO     cartDAO     = new CartDAO();
    private final OrderDAO    orderDAO    = new OrderDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login?redirect=/checkout");
            return;
        }
        int userId = (int) session.getAttribute("userId");
        List<CartItem> items = cartDAO.getCartItems(userId);
        if (items.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/cart");
            return;
        }
        BigDecimal subtotal  = items.stream().map(CartItem::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal shipping  = subtotal.compareTo(new BigDecimal("999")) >= 0
                ? BigDecimal.ZERO : new BigDecimal("99");
        BigDecimal grandTotal = subtotal.add(shipping);

        List<Category> categories = categoryDAO.getAllCategories();
        req.setAttribute("cartItems",   items);
        req.setAttribute("subtotal",    subtotal);
        req.setAttribute("shipping",    shipping);
        req.setAttribute("grandTotal",  grandTotal);
        req.setAttribute("categories",  categories);
        req.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int userId = (int) session.getAttribute("userId");

        String shippingName    = req.getParameter("shippingName");
        String shippingPhone   = req.getParameter("shippingPhone");
        String shippingAddress = req.getParameter("shippingAddress");
        String shippingCity    = req.getParameter("shippingCity");
        String shippingState   = req.getParameter("shippingState");
        String shippingPincode = req.getParameter("shippingPincode");
        String paymentMethod   = req.getParameter("paymentMethod");

        List<CartItem> items = cartDAO.getCartItems(userId);
        if (items.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        BigDecimal subtotal  = items.stream().map(CartItem::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal shipping  = subtotal.compareTo(new BigDecimal("999")) >= 0
                ? BigDecimal.ZERO : new BigDecimal("99");
        BigDecimal grandTotal = subtotal.add(shipping);

        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem ci : items) {
            OrderItem oi = new OrderItem();
            oi.setProductId(ci.getProductId());
            oi.setQuantity(ci.getQuantity());
            oi.setUnitPrice(ci.getUnitPrice());
            orderItems.add(oi);
        }

        Order order = new Order();
        order.setUserId(userId);
        order.setTotalAmount(grandTotal);
        order.setShippingName(shippingName);
        order.setShippingPhone(shippingPhone);
        order.setShippingAddress(shippingAddress);
        order.setShippingCity(shippingCity);
        order.setShippingState(shippingState);
        order.setShippingPincode(shippingPincode);
        order.setPaymentMethod(paymentMethod);
        order.setItems(orderItems);

        int orderId = orderDAO.placeOrder(order);
        if (orderId > 0) {
            cartDAO.clearCart(userId);
            res.sendRedirect(req.getContextPath() + "/orders?success=" + orderId);
        } else {
            req.setAttribute("error", "Failed to place order. Please try again.");
            doGet(req, res);
        }
    }
}
