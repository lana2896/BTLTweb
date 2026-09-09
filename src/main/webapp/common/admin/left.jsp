<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="admin-sidebar d-flex flex-column">
    <a class="brand" href="<c:url value='/admin/home'/>">🌿 Minh Thư Admin</a>
    <a class="nav-link" href="<c:url value='/admin/home'/>">🏠 Trang chủ</a>
    <a class="nav-link" href="<c:url value='/admin/category/list'/>">🗂️ Quản lý danh mục</a>
    <a class="nav-link" href="<c:url value='/admin/product/list'/>">📦 Quản lý sản phẩm</a>
    <hr style="border-color: rgba(255,255,255,.1); margin: 8px 16px;">
    <a class="nav-link" href="<c:url value='/home'/>">🔙 Về trang người dùng</a>
    <a class="nav-link text-danger" href="<c:url value='/logout'/>">🚪 Đăng xuất</a>
</nav>
