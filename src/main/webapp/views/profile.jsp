<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thông tin cá nhân</title>
<style>
    .profile-wrap { max-width:640px; margin:32px auto; padding:24px;
        background:#fff; border:1px solid #e0e0e0; border-radius:10px;
        font-family:'Segoe UI', Arial, sans-serif; }
    .profile-wrap h2 { margin-bottom:20px; color:#2E7D32; }
    .avatar-preview { display:flex; align-items:center; gap:16px; margin-bottom:20px; }
    .avatar-preview img { width:96px; height:96px; border-radius:50%; object-fit:cover; border:1px solid #ddd; }
    .form-group { margin-bottom:16px; }
    .form-group label { display:block; margin-bottom:6px; font-weight:600; font-size:14px; }
    .form-group input[type=text], .form-group input[type=file] {
        width:100%; padding:10px; border:1px solid #ccc; border-radius:6px; font-size:14px; }
    .form-group input[readonly] { background:#f5f5f5; color:#777; }
    .btn-save { background:#2E7D32; color:#fff; border:none; padding:10px 24px;
        border-radius:6px; cursor:pointer; font-size:14px; }
    .btn-save:hover { background:#256428; }
    .alert { padding:10px 14px; border-radius:6px; margin-bottom:16px; font-size:14px; }
    .alert-success { background:#E8F5E9; color:#2E7D32; border:1px solid #A5D6A7; }
    .alert-error { background:#FDECEA; color:#C62828; border:1px solid #F5C6CB; }
</style>
</head>
<body>

<div class="profile-wrap">
    <h2>Thông tin cá nhân</h2>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <div class="avatar-preview">
        <c:choose>
            <c:when test="${not empty user.images}">
                <img src="<c:url value='/image'/>?fname=${user.images}" alt="avatar" id="avatarImg"/>
            </c:when>
            <c:otherwise>
                <img src="<c:url value='/assets/default-avatar.png'/>" alt="avatar" id="avatarImg"/>
            </c:otherwise>
        </c:choose>
        <div>
            <div><strong>${user.username}</strong></div>
            <div style="color:#777; font-size:13px;">${user.email}</div>
        </div>
    </div>

    <form action="<c:url value='/profile'/>" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>Họ và tên</label>
            <input type="text" name="fullname" value="${user.fullname}" required/>
        </div>

        <div class="form-group">
            <label>Số điện thoại</label>
            <input type="text" name="phone" value="${user.phone}" placeholder="Vd: 0900000000"/>
        </div>

        <div class="form-group">
            <label>Ảnh đại diện (để trống nếu không đổi)</label>
            <input type="file" name="images" accept="image/*" onchange="previewAvatar(this)"/>
        </div>

        <button type="submit" class="btn-save">Lưu thay đổi</button>
    </form>
</div>

<script>
    function previewAvatar(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('avatarImg').src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>

</body>
</html>
