package com.mthu.controllers;

import java.io.IOException;

import com.mthu.entity.User;
import com.mthu.services.ICartService;
import com.mthu.services.impl.CartService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/cart/add")
public class CartAddController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ICartService cartService = new CartService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User account = CartController.getAccount(req.getSession(false));
        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            cartService.addItem(account.getId(), productId, quantity);
            req.getSession().setAttribute("cartMessage", "Đã thêm sản phẩm vào giỏ hàng.");
        } catch (RuntimeException e) {
            req.getSession().setAttribute("cartMessage", e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}