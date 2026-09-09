<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý danh mục</title>
</head>
<body>
	<h2>Quản lý danh mục</h2>
	<hr>
	<a href="<c:url value='/admin/category/add'/>" class="btn btn-success mb-3">Thêm danh mục mới</a>

	<table class="table table-bordered table-striped bg-white">
		<thead>
			<tr>
				<th>STT</th>
				<th>Hình ảnh</th>
				<th>Tên danh mục</th>
				<th>Thao tác ảnh</th>
				<th>Hành động</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${cateList}" var="cate" varStatus="STT">
				<tr>
					<td>${STT.index + 1}</td>
					<td>
						<c:url value="/image?fname=${cate.icon}" var="imgUrl"></c:url>
						<img height="60" width="80" src="${imgUrl}" alt="Icon"
							onerror="this.src='https://via.placeholder.com/80x60?text=No+Image'" />
					</td>
					<td>${cate.catename}</td>
					<td>
						<a href="${imgUrl}" class="btn btn-info btn-sm" target="_blank">Xem/Tải ảnh</a>
					</td>
					<td>
						<a href="<c:url value='/admin/category/edit?id=${cate.cateid}'/>" class="btn btn-primary btn-sm">Sửa</a>
						<a href="<c:url value='/admin/category/delete?id=${cate.cateid}'/>" class="btn btn-danger btn-sm"
							onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">Xóa</a>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${empty cateList}">
				<tr>
					<td colspan="5" class="text-center">Không có danh mục nào.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</body>
</html>
