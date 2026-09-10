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
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ICartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User account = getAccount(req.getSession(false));
        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.setAttribute("cart", cartService.getCart(account.getId()));
        HttpSession session = req.getSession(false);
        if (session != null) {
            req.setAttribute("cartMessage", session.getAttribute("cartMessage"));
            session.removeAttribute("cartMessage");
        }
        req.getRequestDispatcher("/views/cart.jsp").forward(req, resp);
    }

    static User getAccount(HttpSession session) {
        return session == null ? null : (User) session.getAttribute("account");
    }
}