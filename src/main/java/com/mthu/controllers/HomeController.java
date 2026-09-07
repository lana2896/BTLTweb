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

@WebServlet(urlPatterns = { "/home" })
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    IProductService productService = new ProductService();   // 👈 khai báo & khởi tạo instance ở đây

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> latest = productService.getLatest(Constant.HOME_LATEST_PRODUCT_COUNT);  // 👈 gọi qua instance
        req.setAttribute("latestProducts", latest);
        req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
    }
}