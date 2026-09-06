package com.mthu.controllers.admin.product;

import java.io.IOException;
import java.util.List;

import com.mthu.entity.Product;
import com.mthu.services.IProductService;
import com.mthu.services.impl.ProductService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/admin/product/list" })
public class ProductListController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> productList = productService.getAll();
        req.setAttribute("productList", productList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/product-list.jsp");
        dispatcher.forward(req, resp);
    }
}