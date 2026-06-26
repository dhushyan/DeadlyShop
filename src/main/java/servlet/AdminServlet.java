package servlet;

import dao.*;
import model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private final ProductDAO  productDAO  = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final OrderDAO    orderDAO    = new OrderDAO();
    private final UserDAO     userDAO     = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/dashboard";

        switch (path) {
            case "/dashboard":
                showDashboard(req, res); break;
            case "/products":
                listProducts(req, res); break;
            case "/products/add":
                showAddProduct(req, res); break;
            case "/products/edit":
                showEditProduct(req, res); break;
            case "/products/delete":
                deleteProduct(req, res); break;
            case "/orders":
                listOrders(req, res); break;
            case "/orders/update":
                updateOrderStatus(req, res); break;
            case "/users":
                listUsers(req, res); break;
            case "/users/delete":
                deleteUser(req, res); break;
            default:
                res.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getPathInfo();
        if (path == null) path = "";

        switch (path) {
            case "/products/add":
                saveNewProduct(req, res); break;
            case "/products/edit":
                saveEditProduct(req, res); break;
            case "/orders/update":
                updateOrderStatus(req, res); break;
            default:
                res.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }

    // ─────────────── DASHBOARD ───────────────
    private void showDashboard(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("productCount", productDAO.countProducts());
        req.setAttribute("orderCount",   orderDAO.countOrders());
        req.setAttribute("userCount",    userDAO.getAllUsers().size());
        req.setAttribute("revenue",      orderDAO.getTotalRevenue());
        req.setAttribute("recentOrders", orderDAO.getAllOrders().stream()
                .limit(5).toList());
        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, res);
    }

    // ─────────────── PRODUCTS ───────────────
    private void listProducts(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("products",   productDAO.getAllProducts());
        req.setAttribute("categories", categoryDAO.getAllCategories());
        req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req, res);
    }

    private void showAddProduct(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("categories", categoryDAO.getAllCategories());
        req.getRequestDispatcher("/WEB-INF/views/admin/product_form.jsp").forward(req, res);
    }

    private void saveNewProduct(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Product p = buildProductFromRequest(req);
        boolean ok = productDAO.addProduct(p);
        res.sendRedirect(req.getContextPath() + "/admin/products?msg=" + (ok ? "added" : "error"));
    }

    private void showEditProduct(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        req.setAttribute("product",    productDAO.getById(id));
        req.setAttribute("categories", categoryDAO.getAllCategories());
        req.getRequestDispatcher("/WEB-INF/views/admin/product_form.jsp").forward(req, res);
    }

    private void saveEditProduct(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Product p = buildProductFromRequest(req);
        p.setId(Integer.parseInt(req.getParameter("id")));
        boolean ok = productDAO.updateProduct(p);
        res.sendRedirect(req.getContextPath() + "/admin/products?msg=" + (ok ? "updated" : "error"));
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        productDAO.deleteProduct(id);
        res.sendRedirect(req.getContextPath() + "/admin/products?msg=deleted");
    }

    private Product buildProductFromRequest(HttpServletRequest req) {
        Product p = new Product();
        p.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
        p.setName(req.getParameter("name"));
        p.setDescription(req.getParameter("description"));
        p.setPrice(new BigDecimal(req.getParameter("price")));
        p.setStock(Integer.parseInt(req.getParameter("stock")));
        p.setImageUrl(req.getParameter("imageUrl"));
        p.setBrand(req.getParameter("brand"));
        p.setRating(Double.parseDouble(req.getParameter("rating")));
        return p;
    }

    // ─────────────── ORDERS ───────────────
    private void listOrders(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        List<Order> orders = orderDAO.getAllOrders();
        // Attach items
        for (Order o : orders) o.setItems(orderDAO.getOrderById(o.getId()).getItems());
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(req, res);
    }

    private void updateOrderStatus(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String status = req.getParameter("status");
        orderDAO.updateStatus(orderId, status);
        res.sendRedirect(req.getContextPath() + "/admin/orders?msg=updated");
    }

    // ─────────────── USERS ───────────────
    private void listUsers(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("users", userDAO.getAllUsers());
        req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, res);
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        userDAO.deleteUser(id);
        res.sendRedirect(req.getContextPath() + "/admin/users?msg=deleted");
    }
}
