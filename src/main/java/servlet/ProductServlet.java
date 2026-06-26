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

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private final ProductDAO  productDAO  = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        List<Category> categories = categoryDAO.getAllCategories();
        req.setAttribute("categories", categories);

        String search     = req.getParameter("search");
        String categoryId = req.getParameter("category");

        List<Product> products;

        if (search != null && !search.trim().isEmpty()) {
            products = productDAO.search(search.trim());
            req.setAttribute("searchQuery", search.trim());
        } else if (categoryId != null && !categoryId.isEmpty()) {
            try {
                int catId = Integer.parseInt(categoryId);
                products = productDAO.getByCategory(catId);
                Category selected = categoryDAO.getById(catId);
                req.setAttribute("selectedCategory", selected);
            } catch (NumberFormatException e) {
                products = productDAO.getAllProducts();
            }
        } else {
            products = productDAO.getAllProducts();
        }

        req.setAttribute("products", products);
        req.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(req, res);
    }
}
