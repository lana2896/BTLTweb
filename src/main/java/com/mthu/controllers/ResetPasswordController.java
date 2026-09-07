package com.mthu.controllers;

import java.io.IOException;

import com.mthu.services.IUserService;
import com.mthu.services.impl.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    IUserService service = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String otp = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            req.setAttribute("alert", "Mật khẩu xác nhận không khớp");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
            return;
        }

        boolean ok = service.resetPassword(email, otp, newPassword);

        if (ok) {
            req.setAttribute("alert", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("alert", "Mã OTP không đúng hoặc đã hết hạn.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
        }
    }
}
