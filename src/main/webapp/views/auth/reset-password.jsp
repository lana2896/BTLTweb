<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đặt Lại Mật Khẩu</title>
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
        font-family: Arial, sans-serif;
        min-height: 100vh;
        display: flex; align-items: center; justify-content: center;
        background: #F5F5F5;
    }
    .login-card {
        width: 100%; max-width: 320px;
        background: #fff; border: 1px solid #DDD; border-radius: 6px;
        padding: 28px 24px;
    }
    h1 { text-align: center; font-size: 18px; margin-bottom: 20px; color: #222; }
    label { display: block; font-size: 13px; color: #555; margin-bottom: 4px; }
    input[type="text"], input[type="email"], input[type="password"] {
        width: 100%; padding: 8px 10px; margin-bottom: 12px;
        border: 1px solid #CCC; border-radius: 4px; font-size: 14px;
    }
    input:focus { outline: none; border-color: #2E7D32; }
    button {
        width: 100%; padding: 10px; border: none; border-radius: 4px;
        background: #2E7D32; color: #fff; font-size: 14px; font-weight: bold; cursor: pointer;
    }
    button:hover { background: #256428; }
    .footer-text { text-align: center; font-size: 13px; color: #666; margin-top: 16px; }
    .footer-text a { color: #2E7D32; font-weight: bold; text-decoration: none; }
    .alert {
        font-size: 13px; padding: 8px 10px; border-radius: 4px; margin-bottom: 14px;
        text-align: center; background: #FDECEA; color: #C0392B; border: 1px solid #F5C6C0;
    }
</style>
</head>
<body>
    <div class="login-card">
        <h1>Đặt Lại Mật Khẩu</h1>

        <c:if test="${alert != null}">
            <div class="alert">${alert}</div>
        </c:if>

        <form action="<c:url value='/reset-password'/>" method="post">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="${email}" required autofocus>

            <label for="otp">Mã OTP</label>
            <input type="text" id="otp" name="otp" maxlength="6" required>

            <label for="newPassword">Mật khẩu mới</label>
            <input type="password" id="newPassword" name="newPassword" required>

            <label for="confirmPassword">Xác nhận mật khẩu mới</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>

            <button type="submit">Đặt lại mật khẩu</button>
        </form>

        <p class="footer-text">
            <a href="<c:url value='/login'/>">← Quay lại đăng nhập</a>
        </p>
    </div>
</body>
</html>