package servlet;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String email    = req.getParameter("email")    == null ? "" : req.getParameter("email").trim();
        String password = req.getParameter("password") == null ? "" : req.getParameter("password").trim();

        if (email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "Email and password are required.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
            return;
        }

        User user = userDAO.authenticate(email, password);

        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("userId",   user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail",user.getEmail());
            session.setAttribute("userRole", user.getRole());
            session.setMaxInactiveInterval(60 * 60); // 1 hour

            // Redirect admin to admin panel
            if (user.isAdmin()) {
                res.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                String redirect = req.getParameter("redirect");
                if (redirect != null && !redirect.isEmpty()) {
                    res.sendRedirect(redirect);
                } else {
                    res.sendRedirect(req.getContextPath() + "/products");
                }
            }
        } else {
            req.setAttribute("error", "Invalid email or password.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
        }
    }
}
