package servlet;

import dao.CartDAO;
import dao.CategoryDAO;
import model.CartItem;
import model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartDAO     cartDAO     = new CartDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    /** Display cart page. */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login?redirect=/cart");
            return;
        }
        int userId = (int) session.getAttribute("userId");
        List<CartItem> items = cartDAO.getCartItems(userId);
        BigDecimal total = items.stream()
                .map(CartItem::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        List<Category> categories = categoryDAO.getAllCategories();
        req.setAttribute("cartItems",  items);
        req.setAttribute("cartTotal",  total);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req, res);
    }

    /**
     * AJAX / form POST handler.
     * action = add | update | remove | count
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            sendJson(res, 401, "{\"error\":\"Not authenticated\"}");
            return;
        }
        int userId = (int) session.getAttribute("userId");
        String action = req.getParameter("action");
        if (action == null) action = "add";

        String accept = req.getHeader("Accept");
        boolean wantsJson = accept != null && accept.contains("application/json");

        switch (action) {
            case "add": {
                int productId = parseInt(req.getParameter("productId"), 0);
                int qty       = parseInt(req.getParameter("qty"), 1);
                boolean ok    = cartDAO.addOrUpdate(userId, productId, qty);
                if (wantsJson) {
                    int count = cartDAO.countItems(userId);
                    sendJson(res, ok ? 200 : 500,
                        "{\"success\":" + ok + ",\"cartCount\":" + count + "}");
                } else {
                    res.sendRedirect(req.getContextPath() + "/cart");
                }
                break;
            }
            case "update": {
                int productId = parseInt(req.getParameter("productId"), 0);
                int qty       = parseInt(req.getParameter("qty"), 1);
                cartDAO.updateQuantity(userId, productId, qty);
                if (wantsJson) {
                    List<CartItem> items = cartDAO.getCartItems(userId);
                    BigDecimal total = items.stream().map(CartItem::getSubtotal)
                            .reduce(BigDecimal.ZERO, BigDecimal::add);
                    sendJson(res, 200,
                        "{\"success\":true,\"cartTotal\":\"" + total.toPlainString() + "\"}");
                } else {
                    res.sendRedirect(req.getContextPath() + "/cart");
                }
                break;
            }
            case "remove": {
                int productId = parseInt(req.getParameter("productId"), 0);
                cartDAO.removeItem(userId, productId);
                if (wantsJson) {
                    int count = cartDAO.countItems(userId);
                    sendJson(res, 200, "{\"success\":true,\"cartCount\":" + count + "}");
                } else {
                    res.sendRedirect(req.getContextPath() + "/cart");
                }
                break;
            }
            case "count": {
                int count = cartDAO.countItems(userId);
                sendJson(res, 200, "{\"cartCount\":" + count + "}");
                break;
            }
            default:
                res.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void sendJson(HttpServletResponse res, int status, String json)
            throws IOException {
        res.setStatus(status);
        res.setContentType("application/json;charset=UTF-8");
        PrintWriter out = res.getWriter();
        out.print(json);
        out.flush();
    }

    private int parseInt(String s, int def) {
        try { return Integer.parseInt(s); }
        catch (Exception e) { return def; }
    }
}
