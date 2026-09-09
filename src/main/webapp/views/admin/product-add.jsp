<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm mới</title>
</head>
<body>
    <h2>Thêm mới sản phẩm</h2>
    <hr>
    <form role="form" action="<c:url value='/admin/product/add'/>" method="post" enctype="multipart/form-data" class="bg-white p-4 border rounded" style="max-width:600px;">
        <div class="form-group">
            <label>Tên sản phẩm:</label>
            <input type="text" class="form-control" placeholder="Nhập tên sản phẩm" name="name" required />
        </div>
        <div class="form-group">
            <label>Danh mục:</label>
            <select class="form-control" name="cateid" required>
                <c:forEach items="${cateList}" var="cate">
                    <option value="${cate.cateid}">${cate.catename}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label>Giá:</label>
            <input type="number" step="0.01" min="0" class="form-control" name="price" required />
        </div>
        <div class="form-group">
            <label>Số lượng:</label>
            <input type="number" min="0" class="form-control" name="quantity" required />
        </div>
        <div class="form-group">
            <label>Mô tả:</label>
            <textarea class="form-control" name="description" rows="4"></textarea>
        </div>
        <div class="form-group">
            <label>Ảnh sản phẩm:</label>
            <input type="file" name="image" class="form-control" />
        </div>
        <button type="submit" class="btn btn-success">Thêm</button>
        <button type="reset" class="btn btn-primary">Hủy</button>
        <a href="<c:url value='/admin/product/list'/>" class="btn btn-secondary">Quay lại danh sách</a>
    </form>
</body>
</html>
