<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
    .site-header { display:flex; align-items:center; justify-content:space-between;
        padding:14px 32px; background:#FFFFFF; border-bottom:1px solid #E0E0E0;
        font-family:'Segoe UI', Arial, sans-serif; }
    .site-header .logo { font-weight:700; font-size:18px; color:#2E7D32; text-decoration:none; }
    .site-header nav { display:flex; gap:24px; align-items:center; }
    .site-header nav a { font-size:14px; color:#555; text-decoration:none; }
    .site-header nav a:hover { color:#2E7D32; }
    .site-header .user-box { display:flex; align-items:center; gap:8px; }
    .site-header .user-box img { width:32px; height:32px; border-radius:50%; object-fit:cover; border:1px solid #ddd; }
</style>
<div class="site-header">
    <a class="logo" href="<c:url value='/home'/>">Minh Thu Shop</a>
    <nav>
        <a href="<c:url value='/home'/>">Trang chủ</a>
        <a href="<c:url value='/product'/>">Sản phẩm</a>
        <c:if test="${not empty sessionScope.account}">
            <a href="<c:url value='/profile'/>">Trang cá nhân</a>
            <div class="user-box">
                <c:choose>
                    <c:when test="${not empty sessionScope.account.images}">
                        <img src="<c:url value='/image'/>?fname=${sessionScope.account.images}" alt="avatar"/>
                    </c:when>
                    <c:otherwise>
                        <img src="<c:url value='/assets/default-avatar.png'/>" alt="avatar"/>
                    </c:otherwise>
                </c:choose>
                <span>${sessionScope.account.fullname}</span>
            </div>
            <a href="<c:url value='/logout'/>">Đăng xuất</a>
        </c:if>
        <c:if test="${empty sessionScope.account}">
            <a href="<c:url value='/login'/>">Đăng nhập</a>
        </c:if>
    </nav>
</div>
