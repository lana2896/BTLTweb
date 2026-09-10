<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
<style>
    .cate-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-top: 16px; }
    .cate-card {
        background: #FFFFFF; border: 1px solid #E0E0E0; border-radius: 8px;
        padding: 12px; text-align: center;
    }
    .cate-card img { width: 100%; height: 250px; object-fit: cover; border-radius: 6px; margin-bottom: 8px; background: #F0F0F0; }
    .cate-card h3 { font-size: 13.5px; font-weight: 600; color: #333; }
    @media (max-width: 900px) { .cate-grid { grid-template-columns: repeat(2, 1fr); } }
</style>
</head>
<body>

    <div class="p-4 mb-4 bg-white border rounded">
        <span class="badge bg-success-subtle text-success mb-2">Bảng điều khiển</span>
        <h1 class="h4 fw-bold">Chào mừng đến trang quản trị Minh Thư Shop</h1>
        <p class="text-muted mb-0">Quản lý danh mục và sản phẩm của cửa hàng tại đây.</p>
    </div>

    <div class="d-flex justify-content-between align-items-baseline">
        <h2 class="h5 fw-bold">Danh mục hiện có</h2>
        <a href="<c:url value='/admin/category/list'/>">Quản lý danh mục →</a>
    </div>

    <div class="cate-grid">
        <c:forEach items="${cateList}" var="cate">
            <div class="cate-card">
                <c:url value="/image?fname=${cate.icon}" var="imgUrl"/>
                <img src="${imgUrl}" onerror="this.src='https://via.placeholder.com/150x100?text=No+Image'" />
                <h3>${cate.catename}</h3>
            </div>
        </c:forEach>
        <c:if test="${empty cateList}">
            <p>Chưa có danh mục nào.</p>
        </c:if>
    </div>

</body>
</html>
