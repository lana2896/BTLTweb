<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý sản phẩm</title>
</head>
<body>
	<h2>Quản lý sản phẩm</h2>
	<hr>
	<a href="<c:url value='/admin/product/add'/>" class="btn btn-success mb-3">Thêm sản phẩm mới</a>

	<table class="table table-bordered table-striped bg-white">
		<thead>
			<tr>
				<th>STT</th>
				<th>Hình ảnh</th>
				<th>Tên sản phẩm</th>
				<th>Danh mục</th>
				<th>Giá</th>
				<th>Số lượng</th>
				<th>Hành động</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${productList}" var="p" varStatus="STT">
				<tr>
					<td>${STT.index + 1}</td>
					<td>
						<c:url value="/image?fname=${p.image}" var="imgUrl"></c:url>
						<img height="60" width="80" src="${imgUrl}" alt="Ảnh"
							onerror="this.src='https://via.placeholder.com/80x60?text=No+Image'" />
					</td>
					<td>${p.name}</td>
					<td>${p.category.catename}</td>
					<td><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/> đ</td>
					<td>${p.quantity}</td>
					<td>
						<a href="<c:url value='/admin/product/edit?id=${p.id}'/>" class="btn btn-primary btn-sm">Sửa</a>
						<a href="<c:url value='/admin/product/delete?id=${p.id}'/>" class="btn btn-danger btn-sm"
							onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">Xóa</a>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${empty productList}">
				<tr>
					<td colspan="7" class="text-center">Không có sản phẩm nào.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</body>
</html>
