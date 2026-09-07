<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục mới</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container" style="margin-top: 30px;">
        <h2>Thêm mới danh mục</h2>
        <hr>
        <form role="form" action="<c:url value='/admin/category/add'/>" method="post" enctype="multipart/form-data">
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
            <a href="<c:url value='/admin/category/list'/>" class="btn btn-default">Quay lại danh sách</a>
        </form>
    </div>
</body>
</html>
