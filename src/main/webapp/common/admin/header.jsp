<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<header class="admin-topbar d-flex justify-content-between align-items-center">
    <span class="fw-semibold text-secondary">Bảng điều khiển</span>
    <c:if test="${not empty sessionScope.account}">
        <div class="d-flex align-items-center gap-2">
            <span class="badge rounded-circle bg-success">${fn:substring(sessionScope.account.fullname, 0, 1)}</span>
            <span class="fw-semibold">${sessionScope.account.fullname}</span>
            <a href="<c:url value='/logout'/>" class="btn btn-outline-danger btn-sm ms-2">Đăng xuất</a>
        </div>
    </c:if>
</header>
