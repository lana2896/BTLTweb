package com.mthu.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;

import com.mthu.entity.User;
import com.mthu.services.IUserService;
import com.mthu.services.impl.UserService;
import com.mthu.utils.Constant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

/**
 * Trang "Thông tin cá nhân" của User đang đăng nhập.
 * - GET  /profile : hiển thị form với dữ liệu hiện tại (fullname, phone, avatar)
 * - POST /profile : nhận multipart/form-data, cập nhật fullname, phone, avatar (nếu có chọn file mới)
 *
 * View /views/profile.jsp là 1 trang JSP thuần (không tự vẽ header/footer),
 * vì nó sẽ được SiteMesh "trang trí" (decorate) bằng /WEB-INF/decorators/web.jsp
 * (xem cấu hình mapping trong /WEB-INF/sitemesh3.xml).
 */
@WebServlet(urlPatterns = { "/profile" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 5,       // 5MB / ảnh
    maxRequestSize = 1024 * 1024 * 20    // 20MB / request
)
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User account = (session != null) ? (User) session.getAttribute("account") : null;
        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Luôn lấy bản mới nhất từ DB (tránh hiển thị dữ liệu cũ trong session)
        User fresh = userService.findById(account.getId());
        req.setAttribute("user", fresh);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/profile.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        User account = (session != null) ? (User) session.getAttribute("account") : null;
        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String errorMsg = validate(fullname, phone);

        if (errorMsg != null) {
            User fresh = userService.findById(account.getId());
            req.setAttribute("user", fresh);
            req.setAttribute("error", errorMsg);
            req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
            return;
        }

        String newImagePath = null;
        try {
            Part filePart = req.getPart("images"); // input file name="images"
            if (filePart != null && filePart.getSize() > 0) {
                newImagePath = saveAvatar(filePart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        User updated = userService.updateProfile(account.getId(), fullname, phone, newImagePath);

        if (updated != null) {
            // Đồng bộ lại session để header (avatar/fullname) hiển thị đúng ngay lập tức
            session.setAttribute("account", updated);
            req.setAttribute("success", "Cập nhật thông tin cá nhân thành công!");
            req.setAttribute("user", updated);
        } else {
            req.setAttribute("error", "Không tìm thấy tài khoản để cập nhật.");
            req.setAttribute("user", account);
        }

        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
    }

    private String validate(String fullname, String phone) {
        if (fullname == null || fullname.isBlank()) {
            return "Họ tên không được để trống";
        }
        if (phone != null && !phone.isBlank() && !phone.matches("^[0-9+\\-\\s]{8,15}$")) {
            return "Số điện thoại không hợp lệ";
        }
        return null;
    }

    /** Lưu file avatar mới vào Constant.DIR/avatar và trả về đường dẫn tương đối (vd: avatar/173xxx.jpg) */
    private String saveAvatar(Part filePart) throws IOException {
        String originalFileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();
        int dot = originalFileName.lastIndexOf(".");
        String ext = (dot >= 0) ? originalFileName.substring(dot + 1) : "jpg";
        String fileName = System.currentTimeMillis() + "." + ext;

        File uploadDir = new File(Constant.DIR + File.separator + Constant.AVATAR_SUBDIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        File dest = new File(uploadDir, fileName);
        filePart.write(dest.getAbsolutePath());

        return Constant.AVATAR_SUBDIR + "/" + fileName;
    }
}
