package com.mthu.controllers;

import java.io.IOException;

import com.mthu.services.IUserService;
import com.mthu.services.impl.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/register" })
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	IUserService service = new UserService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String username = req.getParameter("username");
		String fullname = req.getParameter("fullname");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String confirmPassword = req.getParameter("confirmPassword");

		if (username == null || username.trim().isEmpty()
				|| password == null || password.trim().isEmpty()) {
			req.setAttribute("alert", "Tên đăng nhập và mật khẩu không được rỗng");
			req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
			return;
		}

		if (!password.equals(confirmPassword)) {
			req.setAttribute("alert", "Mật khẩu xác nhận không khớp");
			req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
			return;
		}

		if (service.checkExistEmail(email)) {
			req.setAttribute("alert", "Email đã được sử dụng");
			req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
			return;
		}

		boolean isSuccess = service.register(username, password, email, fullname);

		if (isSuccess) {
			req.setAttribute("alert", "Đăng ký thành công! Vui lòng nhập mã OTP đã gửi tới email để kích hoạt tài khoản.");
			req.setAttribute("email", email);
			req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
		} else {
			req.setAttribute("alert", "Tên đăng nhập đã tồn tại!");
			req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
		}
	}
}