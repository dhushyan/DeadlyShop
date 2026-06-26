package servlet;

import dao.CategoryDAO;
import dao.OrderDAO;
import model.Category;
import model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    private final OrderDAO    orderDAO    = new OrderDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login?redirect=/orders");
            return;
        }
        int userId = (int) session.getAttribute("userId");
        List<Order>    orders     = orderDAO.getOrdersByUser(userId);
        List<Category> categories = categoryDAO.getAllCategories();

        // Check if we just placed an order
        String successId = req.getParameter("success");
        if (successId != null) {
            req.setAttribute("newOrderId", successId);
        }

        // Load items for each order for the detail view
        for (Order o : orders) {
            o.setItems(orderDAO.getOrderById(o.getId()).getItems());
        }

        req.setAttribute("orders",     orders);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/WEB-INF/views/orders.jsp").forward(req, res);
    }
}
