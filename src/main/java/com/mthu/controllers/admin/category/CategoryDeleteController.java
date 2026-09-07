package com.mthu.controllers.admin.category;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mthu.services.ICategoryService;
import com.mthu.services.impl.CategoryService;

@WebServlet(urlPatterns = { "/admin/category/delete" })
public class CategoryDeleteController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ICategoryService categoryService = new CategoryService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		if (id != null) {
			categoryService.delete(Integer.parseInt(id));
		}
		resp.sendRedirect(req.getContextPath() + "/admin/category/list");
	}
}
