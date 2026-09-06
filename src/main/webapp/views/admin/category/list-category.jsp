<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý danh mục</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
	<div class="container" style="margin-top: 30px;">
		<h2>Quản lý danh mục</h2>
		<a href="<c:url value='/admin/home'/>">&laquo; Về trang chủ admin</a>
		<hr>
		<a href="<c:url value='/admin/category/add'/>" class="btn btn-success" style="margin-bottom: 15px;">Thêm danh mục mới</a>

		<table class="table table-bordered table-striped">
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
	</div>
</body>
</html>
