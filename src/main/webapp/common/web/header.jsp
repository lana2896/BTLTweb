<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm" style="background:#2E7D32;">
  <div class="container">
    <a class="navbar-brand fw-bold" href="<c:url value='/home'/>">🌿 Minh Thư Shop</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="mainNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item"><a class="nav-link" href="<c:url value='/home'/>">Trang chủ</a></li>
        <li class="nav-item"><a class="nav-link" href="<c:url value='/product'/>">Sản phẩm</a></li>
      </ul>
      <ul class="navbar-nav align-items-lg-center">
        <c:choose>
          <c:when test="${not empty sessionScope.account}">
            <c:if test="${sessionScope.account.roleid == 1}">
              <li class="nav-item"><a class="nav-link" href="<c:url value='/admin/home'/>">Trang quản trị</a></li>
            </c:if>
            <c:if test="${sessionScope.account.roleid == 2}">
              <li class="nav-item"><a class="nav-link" href="<c:url value='/manager/home'/>">Trang quản lý</a></li>
            </c:if>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" href="#" role="button" data-bs-toggle="dropdown">
                <c:choose>
                  <c:when test="${not empty sessionScope.account.images}">
                    <c:url value="/image?fname=${sessionScope.account.images}" var="avatarUrl"/>
                    <img src="${avatarUrl}" class="rounded-circle" width="28" height="28" style="object-fit:cover;" alt="avatar">
                  </c:when>
                  <c:otherwise>
                    <span class="badge rounded-circle bg-light text-success">${fn:substring(sessionScope.account.fullname, 0, 1)}</span>
                  </c:otherwise>
                </c:choose>
                ${sessionScope.account.fullname}
              </a>
              <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="<c:url value='/profile'/>">Trang cá nhân</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>">Đăng xuất</a></li>
              </ul>
            </li>
          </c:when>
          <c:otherwise>
            <li class="nav-item">
              <a class="btn btn-light btn-sm text-brand fw-semibold" href="<c:url value='/login'/>">Đăng nhập</a>
            </li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>
