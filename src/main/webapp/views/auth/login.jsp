<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --mint-50: #f2faf6; --mint-100: #e3f6ec; --mint-200: #c9ecda; --mint-300: #a9e0c3;
            --mint-400: #7fd1a6; --mint-500: #5cbd8c; --mint-600: #479f73; --mint-700: #38805d; --ink: #2f4a3d;
        }
        body { font-family: 'Poppins', sans-serif; background: linear-gradient(160deg, var(--mint-50) 0%, #eef9f2 45%, #e6f5ec 100%); min-height: 100vh; color: var(--ink); }
        .page-wrap { max-width: 440px; margin: 60px auto; padding: 0 20px; }
        .page-header { background: linear-gradient(120deg, var(--mint-400), var(--mint-500)); border-radius: 22px; padding: 26px 30px; box-shadow: 0 10px 30px rgba(92,189,140,0.35); margin-bottom: 26px; text-align:center; }
        .page-header h2 { color: #fff; font-weight: 700; margin: 0; }
        .page-header p { color: rgba(255,255,255,0.9); margin: 6px 0 0; font-size: 13.5px; }
        .form-card { background: #fff; border-radius: 20px; padding: 30px 32px; box-shadow: 0 10px 35px rgba(92,189,140,0.18); }
        .form-group label { font-weight: 600; color: var(--mint-700); font-size: 13px; text-transform: uppercase; letter-spacing: 0.4px; margin-bottom: 6px; }
        .form-control { border: 1.5px solid var(--mint-200); border-radius: 12px; padding: 10px 14px; font-size: 14px; }
        .btn { border-radius: 24px; font-weight: 600; padding: 10px 22px; border: none; width: 100%; }
        .btn-success { background: linear-gradient(120deg, var(--mint-500), var(--mint-600)); color: #fff; }
        .alert { border-radius: 12px; }
        .bottom-link { text-align: center; margin-top: 14px; font-size: 13.5px; }
        .bottom-link a { color: var(--mint-700); font-weight: 600; }
        .link-row { display:flex; justify-content: space-between; font-size: 12.5px; margin: -6px 0 16px; }
        .link-row a { color: var(--mint-600); }
    </style>
</head>
<body>
    <div class="page-wrap">
        <div class="page-header">
            <h2>🔐 Đăng nhập</h2>
            <p>Đăng nhập để tiếp tục mua sắm</p>
        </div>

        <div class="form-card">
            <c:if test="${not empty alert}">
                <div class="alert alert-danger">${alert}</div>
            </c:if>

            <form action="<c:url value='/login'/>" method="post">
                <div class="form-group">
                    <label>Tên đăng nhập / Email</label>
                    <input type="text" class="form-control" name="username" value="${username}" required>
                </div>
                <div class="form-group">
                    <label>Mật khẩu</label>
                    <input type="password" class="form-control" name="password" required>
                </div>
                <div class="link-row">
                    <span></span>
                    <a href="<c:url value='/forgot-password'/>">Quên mật khẩu?</a>
                </div>
                <button type="submit" class="btn btn-success">Đăng nhập</button>
            </form>

            <div class="bottom-link">
                Chưa có tài khoản? <a href="<c:url value='/register'/>">Đăng ký ngay</a>
            </div>
        </div>
    </div>
</body>
</html>
