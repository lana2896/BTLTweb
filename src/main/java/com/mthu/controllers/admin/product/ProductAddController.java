package com.mthu.controllers.admin.product;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.Date;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import com.mthu.entity.Category;
import com.mthu.entity.Product;
import com.mthu.services.ICategoryService;
import com.mthu.services.IProductService;
import com.mthu.services.impl.CategoryService;
import com.mthu.services.impl.ProductService;
import com.mthu.utils.Constant;

@WebServlet(urlPatterns = { "/admin/product/add" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ProductAddController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductService();
    private ICategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> cateList = categoryService.getAll();
        req.setAttribute("cateList", cateList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/product-add.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            resp.setCharacterEncoding("UTF-8");

            Product product = new Product();
            product.setName(req.getParameter("name"));
            product.setPrice(Double.parseDouble(req.getParameter("price")));
            product.setQuantity(Integer.parseInt(req.getParameter("quantity")));
            product.setDescription(req.getParameter("description"));
            product.setCreatedAt(new Date());

            int cateId = Integer.parseInt(req.getParameter("cateid"));
            Category category = categoryService.get(cateId);
            product.setCategory(category);

            Part filePart = req.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String originalFileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();
                int index = originalFileName.lastIndexOf(".");
                String ext = originalFileName.substring(index + 1);
                String fileName = System.currentTimeMillis() + "." + ext;

                File uploadDir = new File(Constant.DIR + "/product/");
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                File file = new File(uploadDir, fileName);
                filePart.write(file.getAbsolutePath());
                product.setImage("product/" + fileName);
            }

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}