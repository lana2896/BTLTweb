package com.mthu.controllers.admin.category;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import com.mthu.entity.Category;
import com.mthu.services.ICategoryService;
import com.mthu.services.impl.CategoryService;
import com.mthu.utils.Constant;

@WebServlet(urlPatterns = { "/admin/category/edit" })
@MultipartConfig(
	fileSizeThreshold = 1024 * 1024 * 2, // 2MB
	maxFileSize = 1024 * 1024 * 10, // 10MB
	maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class CategoryEditController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ICategoryService categoryService = new CategoryService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String idStr = req.getParameter("id");
		if (idStr != null && !idStr.isEmpty()) {
			int id = Integer.parseInt(idStr);
			Category category = categoryService.get(id);
			req.setAttribute("category", category);
		}
		RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/category/edit-category.jsp");
		dispatcher.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			resp.setCharacterEncoding("UTF-8");

			Category category = new Category();

			String idStr = req.getParameter("id");
			if (idStr != null) {
				category.setCateid(Integer.parseInt(idStr));
			}
			category.setCatename(req.getParameter("name"));

			Part filePart = req.getPart("icon");
			if (filePart != null && filePart.getSize() > 0) {
				String originalFileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();
				int index = originalFileName.lastIndexOf(".");
				String ext = originalFileName.substring(index + 1);
				String fileName = System.currentTimeMillis() + "." + ext;

				File uploadDir = new File(Constant.DIR + "/category/");
				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}

				File file = new File(uploadDir, fileName);
				filePart.write(file.getAbsolutePath());
				category.setIcon("category/" + fileName);
			} else {
				// Giữ icon cũ nếu người dùng không chọn ảnh mới
				Category old = categoryService.get(category.getCateid());
				category.setIcon(old != null ? old.getIcon() : null);
			}

			categoryService.edit(category);
			resp.sendRedirect(req.getContextPath() + "/admin/category/list");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
