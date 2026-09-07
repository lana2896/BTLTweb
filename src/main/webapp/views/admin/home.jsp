<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trang Chủ - Người Dùng</title>
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
    .logo {
        font-weight: 700;
        font-size: 18px;
        color: #2E7D32;
    }

    nav { display: flex; gap: 24px; }
    nav a {
        font-size: 14px;
        color: #555;
    }
    nav a:hover, nav a.active { color: #2E7D32; font-weight: 600; }

    .header-actions { display: flex; align-items: center; gap: 14px; }
    .search-box {
        border: 1px solid #DDD;
        border-radius: 6px;
        padding: 6px 12px;
    }
    .search-box input {
        border: none; outline: none;
        font-size: 13px; width: 160px;
    }

    .icon-btn {
        width: 34px; height: 34px;
        border-radius: 6px;
        border: 1px solid #DDD;
        display: flex; align-items: center; justify-content: center;
        cursor: pointer;
        font-size: 14px;
        position: relative;
    }
    .badge {
        position: absolute; top: -6px; right: -6px;
        background: #2E7D32; color: #fff;
        font-size: 10px; font-weight: 700;
        width: 15px; height: 15px; border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 5px 10px;
        border: 1px solid #DDD;
        border-radius: 6px;
    }
    .user-avatar {
        width: 26px; height: 26px;
        border-radius: 50%;
        background: #2E7D32;
        color: #fff;
        display: flex; align-items: center; justify-content: center;
        font-weight: 700;
        font-size: 12px;
    }
    .user-detail { line-height: 1.2; }
    .user-detail .user-name { font-size: 12.5px; font-weight: 600; display: block; }
    .user-detail .user-role { font-size: 10.5px; color: #888; }
    .logout-link { font-size: 12px; color: #C0392B; margin-left: 4px; }

    .welcome-banner {
        max-width: 1000px;
        margin: 16px auto 0;
        padding: 0 32px;
        font-size: 13px;
        color: #2E7D32;
    }

    .hero {
        max-width: 1000px;
        margin: 32px auto;
        padding: 24px 32px;
        display: flex;
        align-items: center;
        gap: 32px;
        background: #FFFFFF;
        border: 1px solid #E0E0E0;
        border-radius: 8px;
    }
    .hero-text { flex: 1; }
    .hero-text .tag {
        display: inline-block;
        background: #E8F5E9;
        color: #2E7D32;
        font-size: 12px;
        font-weight: 600;
        padding: 4px 10px;
        border-radius: 4px;
        margin-bottom: 12px;
    }
    .hero-text h1 {
        font-size: 26px;
        font-weight: 700;
        color: #222;
        line-height: 1.35;
        margin-bottom: 10px;
    }
    .hero-text p {
        font-size: 14px;
        color: #666;
        margin-bottom: 18px;
        max-width: 400px;
    }
    .btn-primary {
        background: #2E7D32;
        color: #fff;
        font-weight: 600;
        font-size: 14px;
        padding: 10px 22px;
        border-radius: 6px;
        cursor: pointer;
        border: none;
    }
    .btn-primary:hover { background: #256428; }

    .hero-visual {
        flex: 0 0 140px;
        height: 140px;
        border-radius: 8px;
        background: #E8F5E9;
        display: flex; align-items: center; justify-content: center;
        font-size: 40px;
    }

    .section {
        max-width: 1000px;
        margin: 0 auto 40px;
        padding: 0 32px;
    }
    .section-title {
        display: flex;
        align-items: baseline;
        justify-content: space-between;
        margin-bottom: 16px;
    }
    .section-title h2 {
        font-size: 18px;
        font-weight: 700;
        color: #222;
    }
    .section-title a {
        font-size: 13px;
        color: #2E7D32;
    }

    .product-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 16px;
    }
    .product-card {
        background: #FFFFFF;
        border: 1px solid #E0E0E0;
        border-radius: 8px;
        padding: 12px;
        cursor: pointer;
    }
    .product-card:hover { border-color: #2E7D32; }
    .product-thumb {
        width: 100%;
        height: 110px;
        border-radius: 6px;
        background: #F0F0F0;
        display: flex; align-items: center; justify-content: center;
        margin-bottom: 10px;
        font-size: 28px;
        color: #AAA;
    }
    .product-card h3 {
        font-size: 13.5px;
        font-weight: 600;
        color: #333;
        margin-bottom: 4px;
    }
    .product-price {
        font-size: 14px;
        font-weight: 700;
        color: #2E7D32;
    }

    footer {
        text-align: center;
        padding: 20px;
        font-size: 12px;
        color: #999;
        border-top: 1px solid #E0E0E0;
    }

    @media (max-width: 900px) {
        .product-grid { grid-template-columns: repeat(2, 1fr); }
        .hero { flex-direction: column; }
        nav { display: none; }
        .search-box { display: none; }
    }
</style>
</head>
<body>

    <header>
        <div class="logo">Minh Thư</div>

			<nav>
			    <a href="<c:url value='/admin/home'/>" class="active">Trang chủ</a>
			    <a href="#">Khuyến mãi</a>
			    <a href="#">Liên hệ</a>
			    <a href="<c:url value='/admin/category/list'/>">Quản lý danh mục</a>
			    <a href="<c:url value='/admin/product/list'/>">Quản lý sản phẩm</a>
			</nav>

        <div class="header-actions">
            <div class="search-box">
                <input type="text" placeholder="Tìm sản phẩm...">
            </div>
            <div class="icon-btn">
                🛒
                <span class="badge">3</span>
            </div>
			<c:choose>
			    <c:when test="${not empty sessionScope.account}">
			        <div class="user-info">
			            <div class="user-avatar">
			                ${fn:substring(sessionScope.account.fullname, 0, 1)}
			            </div>
			            <div class="user-detail">
			                <a href="<c:url value='/profile'/>" class="user-name">${sessionScope.account.fullname}</a>
			                <span class="user-role">Người dùng</span>
			            </div>
			            <a href="<c:url value='/logout'/>" class="logout-link" title="Đăng xuất">Thoát</a>
			        </div>
			    </c:when>
			    <c:otherwise>
			        <div class="icon-btn">👤</div>
			    </c:otherwise>
			</c:choose>
        </div>
    </header>

<c:if test="${not empty sessionScope.account}">
    <div class="welcome-banner">
        Xin chào, <b>${sessionScope.account.fullname}</b>! Rất vui được phục vụ bạn hôm nay.
    </div>
</c:if>

    <section class="hero">
        <div class="hero-text">
            <span class="tag">Ưu đãi hôm nay</span>
            <h1>Trang chủ của Admin<br>Sống xanh mỗi ngày</h1>
            <p>Khám phá hàng ngàn sản phẩm chất lượng với mức giá tốt nhất, giao hàng nhanh chóng tận nơi.</p>
            <button class="btn-primary">Mua sắm ngay</button>
        </div>
        <div class="hero-visual">🌿</div>
    </section>

    <section class="section">
        <div class="section-title">
            <h2>Danh mục</h2>
            <a href="#">Xem tất cả →</a>
        </div>

        <div class="product-grid">
			<c:forEach items="${cateList}" var="cate">
			    <div class="product-card">
			        <c:url value="/image?fname=${cate.icon}" var="imgUrl"/>
			        <img src="${imgUrl}" class="product-thumb" />
			        <h3>${cate.catename}</h3>
			    </div>
			</c:forEach>
        </div>
    </section>

    <footer>
        © Nguyễn Ngọc Minh Thư - 24110347
    </footer>

</body>
</html>