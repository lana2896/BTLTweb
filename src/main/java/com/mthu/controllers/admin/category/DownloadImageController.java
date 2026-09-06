package com.mthu.controllers.admin.category;

import java.io.File;

import java.io.FileInputStream;
import java.io.IOException;

import org.apache.commons.io.IOUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mthu.utils.Constant;

@WebServlet(urlPatterns = "/image") // ?fname=abc.png
public class DownloadImageController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String fileName = req.getParameter("fname");

		if (fileName == null || fileName.isEmpty()) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing file name parameter");
			return;
		}

		File file = new File(Constant.DIR + "/" + fileName);

		if (file.exists() && file.isFile()) {
			String contentType = getServletContext().getMimeType(file.getName());
			if (contentType == null) {
				contentType = "application/octet-stream";
			}
			resp.setContentType(contentType);

			try (FileInputStream fis = new FileInputStream(file)) {
				IOUtils.copy(fis, resp.getOutputStream());
			}
		} else {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
		}
	}
}
