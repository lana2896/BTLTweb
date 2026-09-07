package com.mthu.controllers;

import java.io.IOException;

import com.mthu.services.IUserService;
import com.mthu.services.impl.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/resend-otp")
public class ResendOtpController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    IUserService service = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");

        try {
            service.resendOtp(email);
            req.setAttribute("alert", "Đã gửi lại mã OTP, vui lòng kiểm tra email.");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("alert", "Không gửi được email, vui lòng thử lại sau.");
        }

        req.setAttribute("email", email);
        req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
    }
}
