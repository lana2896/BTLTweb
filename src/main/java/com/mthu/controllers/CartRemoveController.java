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

@WebServlet("/cart/remove")
public class CartRemoveController extends HttpServlet {
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
            cartService.removeItem(account.getId(), Integer.parseInt(req.getParameter("itemId")));
            req.getSession().setAttribute("cartMessage", "Đã xóa sản phẩm khỏi giỏ hàng.");
        } catch (RuntimeException e) {
            req.getSession().setAttribute("cartMessage", e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}