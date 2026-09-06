<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng Nhập Vào Hệ Thống</title>
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
        font-family: Arial, sans-serif;
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #F5F5F5;
    }

    .login-card {
        width: 100%;
        max-width: 320px;
        background: #fff;
        border: 1px solid #DDD;
        border-radius: 6px;
        padding: 28px 24px;
    }

    h1 {
        text-align: center;
        font-size: 18px;
        margin-bottom: 20px;
        color: #222;
    }

    label {
        display: block;
        font-size: 13px;
        color: #555;
        margin-bottom: 4px;
    }

    input[type="text"], input[type="password"] {
        width: 100%;
        padding: 8px 10px;
        margin-bottom: 12px;
        border: 1px solid #CCC;
        border-radius: 4px;
        font-size: 14px;
    }
    input:focus { outline: none; border-color: #2E7D32; }

    .row-options {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 16px;
        font-size: 13px;
    }
    .row-options a { color: #2E7D32; text-decoration: none; }
    .row-options a:hover { text-decoration: underline; }

    button {
        width: 100%;
        padding: 10px;
        border: none;
        border-radius: 4px;
        background: #2E7D32;
        color: #fff;
        font-size: 14px;
        font-weight: bold;
        cursor: pointer;
    }
    button:hover { background: #256428; }

    .footer-text {
        text-align: center;
        font-size: 13px;
        color: #666;
        margin-top: 16px;
    }
    .footer-text a { color: #2E7D32; font-weight: bold; text-decoration: none; }
    .footer-text a:hover { text-decoration: underline; }

    .alert {
        font-size: 13px;
        padding: 8px 10px;
        border-radius: 4px;
        margin-bottom: 14px;
        text-align: center;
        background: #FDECEA;
        color: #C0392B;
        border: 1px solid #F5C6C0;
    }
</style>
</head>
<body>

    <div class="login-card">

        <h1>Đăng Nhập</h1>

        <c:if test="${not empty errorMsg}">
            <div class="alert">${errorMsg}</div>
        </c:if>

        <c:if test="${alert != null}">
            <div class="alert">${alert}</div>
        </c:if>

        <form action="login" method="post">

            <label for="username">Tên đăng nhập</label>
            <input type="text" id="username" name="username" required autofocus>

            <label for="passwordField">Mật khẩu</label>
            <input type="password" id="passwordField" name="password" required>

            <div class="row-options">
                <label><input type="checkbox" name="remember"> Nhớ tôi</label>
                <a href="forgot-password">Quên mật khẩu?</a>
            </div>

            <button type="submit">Đăng nhập</button>

        </form>

        <p class="footer-text">
            Chưa có tài khoản? <a href="register">Đăng ký</a>
        </p>

    </div>

</body>
</html>