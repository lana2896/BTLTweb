package com.mthu.controllers.admin;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mthu.entity.Category;
import com.mthu.services.ICategoryService;
import com.mthu.services.impl.CategoryService;

@WebServlet(urlPatterns = { "/admin/home" })
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    ICategoryService categoryService = new CategoryService();
	    List<Category> cateList = categoryService.getAll();
	    req.setAttribute("cateList", cateList);
	    req.getRequestDispatcher("/views/admin/home.jsp").forward(req, resp);
	}
}
