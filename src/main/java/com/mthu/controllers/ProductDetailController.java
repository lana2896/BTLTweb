package com.mthu.controllers;

import java.io.IOException;

import com.mthu.entity.Product;
import com.mthu.services.IProductService;
import com.mthu.services.impl.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/product/detail" })
public class ProductDetailController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    IProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Product product = productService.get(id);
            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/product");
                return;
            }
            req.setAttribute("product", product);
            req.getRequestDispatcher("/views/product-detail.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/product");
        }
    }
}