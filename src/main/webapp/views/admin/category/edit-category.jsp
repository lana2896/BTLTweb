<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa danh mục</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container" style="margin-top: 30px;">
        <h2>Sửa danh mục</h2>
        <hr>
        <form role="form" action="<c:url value='/admin/category/edit'/>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${category.cateid}" />
            <div class="form-group">
                <label>Tên danh mục:</label>
                <input type="text" class="form-control" name="name" value="${category.catename}" required />
            </div>
            <div class="form-group">
                <label>Ảnh hiện tại:</label><br>
                <c:if test="${not empty category.icon}">
                    <c:url value="/image?fname=${category.icon}" var="imgUrl"></c:url>
                    <img height="60" width="80" src="${imgUrl}" alt="Icon"
                        onerror="this.src='https://via.placeholder.com/80x60?text=No+Image'" />
                </c:if>
            </div>
            <div class="form-group">
                <label>Đổi ảnh mới (bỏ trống nếu giữ ảnh cũ):</label>
                <input type="file" name="icon" class="form-control" />
            </div>
            <button type="submit" class="btn btn-success">Lưu</button>
            <a href="<c:url value='/admin/category/list'/>" class="btn btn-default">Quay lại danh sách</a>
        </form>
    </div>
</body>
</html>
