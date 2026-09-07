package com.mthu.filters;

import java.io.IOException;

import com.mthu.entity.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Chặn truy cập trực tiếp vào /admin/* (chỉ ADMIN - roleid = 1)
 * và /manager/* (chỉ MANAGER - roleid = 2) bằng cách gõ URL.
 * Nếu chưa đăng nhập -> chuyển về /login.
 */
@WebFilter("/*")
public class AuthorizationFilter implements Filter {

    private static final int ROLE_ADMIN = 1;
    private static final int ROLE_MANAGER = 2;

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String contextPath = request.getContextPath();
        String path = request.getRequestURI().substring(contextPath.length());

        boolean isAdminPath = path.startsWith("/admin");
        boolean isManagerPath = path.startsWith("/manager");

        if (!isAdminPath && !isManagerPath) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);
        User account = (session != null) ? (User) session.getAttribute("account") : null;

        if (account == null) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        if (isAdminPath && account.getRoleid() != ROLE_ADMIN) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        if (isManagerPath && account.getRoleid() != ROLE_MANAGER) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        chain.doFilter(req, res);
    }
}