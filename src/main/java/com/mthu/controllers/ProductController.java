package com.mthu.controllers;

import java.io.IOException;
import java.util.List;

import com.mthu.entity.Product;
import com.mthu.services.IProductService;
import com.mthu.services.impl.ProductService;
import com.mthu.utils.Constant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/product" })
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    IProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        if (page < 1) {
            page = 1;
        }

        int pageSize = Constant.PRODUCT_PAGE_SIZE;
        int totalPages = productService.getTotalPages(pageSize);
        if (totalPages < 1) {
            totalPages = 1;
        }
        if (page > totalPages) {
            page = totalPages;
        }

        List<Product> products = productService.getPaged(page, pageSize);

        req.setAttribute("products", products);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/views/product-list.jsp").forward(req, resp);
    }
}