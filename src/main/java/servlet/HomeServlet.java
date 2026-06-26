package servlet;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Category;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"", "/home", "/index"})
public class HomeServlet extends HttpServlet {

    private final ProductDAO  productDAO  = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        List<Product>  featured   = productDAO.getAllProducts();
        if (featured.size() > 8) featured = featured.subList(0, 8);

        req.setAttribute("categories",       categories);
        req.setAttribute("featuredProducts", featured);
        req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req, res);
    }
}
