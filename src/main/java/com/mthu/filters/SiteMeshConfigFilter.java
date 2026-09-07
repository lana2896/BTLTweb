package com.mthu.filters;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

import jakarta.servlet.annotation.WebFilter;

/**
 * Cấu hình SiteMesh 3 để quản lý layout (header/nav/footer dùng chung)
 * bằng decorator, thay vì lặp lại HTML trong từng JSP.
 *
 * Hiện tại chỉ áp dụng decorator cho trang /profile (tính năng mới),
 * để không ảnh hưởng tới các JSP hiện có (home.jsp, admin/*, ... vốn
 * đang tự chứa toàn bộ <html><head><body> của riêng chúng).
 *
 * Muốn mở rộng ra các trang khác: gỡ phần <header>/<nav>/<footer> lặp lại
 * trong JSP đó rồi thêm 1 dòng builder.addDecoratorPath(...) tương ứng.
 */
@WebFilter(urlPatterns = "/*", filterName = "siteMeshFilter")
public class SiteMeshConfigFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.addDecoratorPath("/profile", "/WEB-INF/decorators/user-decorator.jsp");
    }
}
