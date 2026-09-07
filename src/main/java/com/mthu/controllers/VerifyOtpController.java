package com.mthu.controllers;

import java.io.IOException;

import com.mthu.services.IUserService;
import com.mthu.services.impl.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/verify-otp")
public class VerifyOtpController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	IUserService service = new UserService();

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String email = req.getParameter("email");
		String otp = req.getParameter("otp");
		boolean ok = service.verifyOtp(email, otp);
		req.setAttribute("alert", ok ? "Kích hoạt thành công! Vui lòng đăng nhập." : "Mã OTP không đúng hoặc đã hết hạn.");
		if (ok) {
			req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
		} else {
			req.setAttribute("email", email);
			req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
		}
	}
}