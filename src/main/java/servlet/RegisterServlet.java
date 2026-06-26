package servlet;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String name     = req.getParameter("name")    == null ? "" : req.getParameter("name").trim();
        String email    = req.getParameter("email")   == null ? "" : req.getParameter("email").trim();
        String mobile   = req.getParameter("mobile")  == null ? "" : req.getParameter("mobile").trim();
        String password = req.getParameter("password")== null ? "" : req.getParameter("password").trim();

        if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, res);
            return;
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setMobile(mobile);
        user.setPassword(password);

        boolean success = userDAO.register(user);
        if (success) {
            res.sendRedirect(req.getContextPath() + "/login?registered=1");
        } else {
            req.setAttribute("error", "Email already registered. Please login.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, res);
        }
    }
}
