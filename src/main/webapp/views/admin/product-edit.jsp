<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
</head>
<body>
    <h2>Sửa sản phẩm</h2>
    <hr>
    <form role="form" action="<c:url value='/admin/product/edit'/>" method="post" enctype="multipart/form-data" class="bg-white p-4 border rounded" style="max-width:600px;">
        <input type="hidden" name="id" value="${product.id}" />

        <div class="form-group">
            <label>Tên sản phẩm:</label>
            <input type="text" class="form-control" name="name" value="${product.name}" required />
        </div>
        <div class="form-group">
            <label>Danh mục:</label>
            <select class="form-control" name="cateid" required>
                <c:forEach items="${cateList}" var="cate">
                    <option value="${cate.cateid}" ${cate.cateid == product.category.cateid ? 'selected' : ''}>
                        ${cate.catename}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label>Giá:</label>
            <input type="number" step="0.01" min="0" class="form-control" name="price" value="${product.price}" required />
        </div>
        <div class="form-group">
            <label>Số lượng:</label>
            <input type="number" min="0" class="form-control" name="quantity" value="${product.quantity}" required />
        </div>
        <div class="form-group">
            <label>Mô tả:</label>
            <textarea class="form-control" name="description" rows="4">${product.description}</textarea>
        </div>
        <div class="form-group">
            <label>Ảnh hiện tại:</label><br>
            <c:url value="/image?fname=${product.image}" var="imgUrl"/>
            <img height="80" src="${imgUrl}" onerror="this.src='https://via.placeholder.com/100x80?text=No+Image'" /><br><br>
            <label>Chọn ảnh mới (để trống nếu giữ ảnh cũ):</label>
            <input type="file" name="image" class="form-control" />
        </div>
        <button type="submit" class="btn btn-success">Cập nhật</button>
        <a href="<c:url value='/admin/product/list'/>" class="btn btn-secondary">Quay lại danh sách</a>
    </form>
</body>
</html>
