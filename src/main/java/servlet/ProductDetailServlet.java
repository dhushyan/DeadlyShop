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

@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {

    private final ProductDAO  productDAO  = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null) {
            res.sendRedirect(req.getContextPath() + "/products");
            return;
        }
        try {
            int id = Integer.parseInt(idParam);
            Product product = productDAO.getById(id);
            if (product == null) {
                res.sendRedirect(req.getContextPath() + "/products");
                return;
            }
            List<Category> categories = categoryDAO.getAllCategories();
            List<Product> related = productDAO.getByCategory(product.getCategoryId());
            related.removeIf(p -> p.getId() == product.getId());
            if (related.size() > 4) related = related.subList(0, 4);

            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.setAttribute("relatedProducts", related);
            req.getRequestDispatcher("/WEB-INF/views/product_detail.jsp").forward(req, res);
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/products");
        }
    }
}
