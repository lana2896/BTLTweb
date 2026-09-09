<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục mới</title>
</head>
<body>
    <h2>Thêm mới danh mục</h2>
    <hr>
    <form role="form" action="<c:url value='/admin/category/add'/>" method="post" enctype="multipart/form-data" class="bg-white p-4 border rounded" style="max-width:600px;">
        <div class="form-group">
            <label>Tên danh mục:</label>
            <input type="text" class="form-control" placeholder="Nhập tên danh mục" name="name" required />
        </div>
        <div class="form-group">
            <label>Ảnh đại diện:</label>
            <input type="file" name="icon" class="form-control" />
        </div>
        <button type="submit" class="btn btn-success">Thêm</button>
        <button type="reset" class="btn btn-primary">Hủy</button>
        <a href="<c:url value='/admin/category/list'/>" class="btn btn-secondary">Quay lại danh sách</a>
    </form>
</body>
</html>
