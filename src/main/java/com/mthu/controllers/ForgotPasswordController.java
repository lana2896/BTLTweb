package com.mthu.controllers;

import java.io.IOException;

import com.mthu.services.IUserService;
import com.mthu.services.impl.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    IUserService service = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập email");
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
            return;
        }

        if (!service.checkExistEmail(email)) {
            req.setAttribute("alert", "Email không tồn tại trong hệ thống");
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
            return;
        }

        try {
            service.sendForgotPasswordOtp(email);
            req.setAttribute("alert", "Mã OTP đã được gửi tới email của bạn.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("alert", "Không gửi được email, vui lòng thử lại sau.");
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
        }
    }
}