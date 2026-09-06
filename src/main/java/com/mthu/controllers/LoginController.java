package com.mthu.controllers;

import java.io.IOException;

import com.mthu.entity.User;
import com.mthu.services.IUserService;
import com.mthu.services.impl.UserService;
import com.mthu.utils.Constant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	IUserService service = new UserService();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");
		
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String remember = req.getParameter("remember");
		boolean isRememberMe = false;
		
		if("on".equals(remember)){
			 isRememberMe = true;
		}
		String alertMsg="";
		
		if(username.isEmpty() || password.isEmpty()){
			alertMsg = "Tài khoản hoặc mật khẩu không được rỗng";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
			return;
		}
		
		User user = service.login(username, password);
		 
		if(user!=null){
			 HttpSession session = req.getSession(true);
			 session.setAttribute("account", user);
			 if(isRememberMe){
				 saveRemeberMe(resp, username);
			 }
			 
			 resp.sendRedirect(req.getContextPath()+"/waiting");
			 
		}else{
			 alertMsg = "Tài khoản hoặc mật khẩu không đúng";
			 req.setAttribute("alert", alertMsg);
			 req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
			}
		}

	private void saveRemeberMe(HttpServletResponse response, String username) {
		Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, username);
		cookie.setMaxAge(30*60);
		response.addCookie(cookie);
	}
}
