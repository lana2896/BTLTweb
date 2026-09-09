<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Minh Thư Shop - <sitemesh:write property="title"/></title>

<!-- Phần <head> riêng của từng trang nội dung (vd: <style> đặc thù) sẽ được chèn vào đây -->
<sitemesh:write property="head"/>

<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
        font-family: 'Segoe UI', Arial, sans-serif;
        background: #F7F9F8;
        color: #333;
    }

    a { text-decoration: none; color: inherit; }

    header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 14px 32px;
        background: #FFFFFF;
        border-bottom: 1px solid #E0E0E0;
    }
    .logo { font-weight: 700; font-size: 18px; color: #2E7D32; }

    nav { display: flex; gap: 24px; }
    nav a { font-size: 14px; color: #555; }
    nav a:hover, nav a.active { color: #2E7D32; font-weight: 600; }

    .header-actions { display: flex; align-items: center; gap: 14px; }

    .user-info { display: flex; align-items: center; gap: 8px; }
    .user-avatar {
        width: 34px; height: 34px; border-radius: 50%;
        background: #2E7D32; color: #fff;
        display: flex; align-items: center; justify-content: center;
        font-weight: 700; font-size: 14px; overflow: hidden;
    }
    .user-avatar img { width: 100%; height: 100%; object-fit: cover; }
    .user-detail { display: flex; flex-direction: column; line-height: 1.2; }
    .user-name { font-size: 13px; font-weight: 600; }
    .user-role { font-size: 11px; color: #888; }
    .logout-link { font-size: 12px; color: #C0392B; margin-left: 4px; }

    footer {
        margin-top: 40px;
        padding: 24px 32px;
        background: #FFFFFF;
        border-top: 1px solid #E0E0E0;
        text-align: center;
        font-size: 12px;
        color: #888;
    }

    main { min-height: 60vh; }

    @media (max-width: 720px) {
        nav { display: none; }
    }
</style>
</head>
<body>

    <header>
        <a href="<c:url value='/home'/>" class="logo">Minh Thư</a>

        <nav>
            <a href="<c:url value='/home'/>">Trang chủ</a>
            <a href="<c:url value='/product'/>">Sản phẩm</a>
            <a href="#">Khuyến mãi</a>
            <a href="#">Liên hệ</a>
        </nav>

        <div class="header-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.account}">
                    <div class="user-info">
                        <div class="user-avatar">
                            <c:choose>
                                <c:when test="${not empty sessionScope.account.images}">
                                    <c:url value="/image?fname=${sessionScope.account.images}" var="avatarUrl"/>
                                    <img src="${avatarUrl}" alt="avatar">
                                </c:when>
                                <c:otherwise>
                                    ${fn:substring(sessionScope.account.fullname, 0, 1)}
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="user-detail">
                            <a href="<c:url value='/profile'/>" class="user-name">${sessionScope.account.fullname}</a>
                            <span class="user-role">Người dùng</span>
                        </div>
                        <a href="<c:url value='/logout'/>" class="logout-link" title="Đăng xuất">Thoát</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/login'/>">Đăng nhập</a>
                </c:otherwise>
            </c:choose>
        </div>
    </header>

    <main>
        <sitemesh:write property="body"/>
    </main>

    <footer>
        &copy; <%= java.time.Year.now() %> Minh Thư Shop. Sống xanh mỗi ngày.
    </footer>

</body>
</html>
