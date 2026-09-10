<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
<style>
    .welcome-banner { max-width: 1140px; margin: 16px auto 0; padding: 0 15px; font-size: 13px; color: #2E7D32; }

    .hero {
        max-width: 1140px; margin: 32px auto; padding: 24px 32px;
        display: flex; align-items: center; gap: 32px;
        background: #FFFFFF; border: 1px solid #E0E0E0; border-radius: 8px;
    }
    .hero-text { flex: 1; }
    .hero-text .tag {
        display: inline-block; background: #E8F5E9; color: #2E7D32;
        font-size: 12px; font-weight: 600; padding: 4px 10px; border-radius: 4px; margin-bottom: 12px;
    }
    .hero-text h1 { font-size: 26px; font-weight: 700; color: #222; line-height: 1.35; margin-bottom: 10px; }
    .hero-text p { font-size: 14px; color: #666; margin-bottom: 18px; max-width: 400px; }
    .hero-visual {
        flex: 0 0 140px; height: 140px; border-radius: 8px; background: #E8F5E9;
        display: flex; align-items: center; justify-content: center; font-size: 40px;
    }

    .section { max-width: 1140px; margin: 0 auto 40px; padding: 0 15px; }
    .section-title { display: flex; align-items: baseline; justify-content: space-between; margin-bottom: 16px; }
    .section-title h2 { font-size: 18px; font-weight: 700; color: #222; }
    .section-title a { font-size: 13px; color: #2E7D32; }

    .product-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; }
    .product-card { background: #FFFFFF; border: 1px solid #E0E0E0; border-radius: 8px; padding: 12px; cursor: pointer; }
    .product-card:hover { border-color: #2E7D32; }
    .product-thumb {
        width: 100%; height: 200px; border-radius: 6px; background: #F0F0F0;
        display: flex; align-items: center; justify-content: center; margin-bottom: 10px;
        object-fit: cover; font-size: 28px; color: #AAA;
    }
    .product-card h3 { font-size: 13.5px; font-weight: 600; color: #333; margin-bottom: 4px; }
    .product-price { font-size: 14px; font-weight: 700; color: #2E7D32; }

    @media (max-width: 900px) { .product-grid { grid-template-columns: repeat(2, 1fr); } .hero { flex-direction: column; } }
</style>
</head>
<body>

    <c:if test="${not empty sessionScope.account}">
        <div class="welcome-banner">
            Xin chào, <b>${sessionScope.account.fullname}</b>! Rất vui được phục vụ bạn hôm nay.
        </div>
    </c:if>

    <section class="hero">
        <div class="hero-text">
            <span class="tag">Ưu đãi hôm nay</span>
            <h1>Sống xanh mỗi ngày</h1>
            <p>Khám phá hàng ngàn sản phẩm chất lượng với mức giá tốt nhất, giao hàng nhanh chóng tận nơi.</p>
            <a href="<c:url value='/product'/>" class="btn btn-brand">Mua sắm ngay</a>
        </div>
        <div class="hero-visual">🌿</div>
    </section>

    <section class="section">
        <div class="section-title">
            <h2>Sản phẩm mới nhất</h2>
            <a href="<c:url value='/product'/>">Xem tất cả →</a>
        </div>

        <div class="product-grid">
            <c:forEach items="${latestProducts}" var="p">
                <a href="<c:url value='/product/detail?id=${p.id}'/>">
                    <div class="product-card">
                        <c:url value="/image?fname=${p.image}" var="imgUrl"/>
                        <img src="${imgUrl}" class="product-thumb"
                             onerror="this.src='https://via.placeholder.com/150x110?text=No+Image'" />
                        <h3>${p.name}</h3>
                        <div class="product-price">
                            <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/> đ
                        </div>
                    </div>
                </a>
            </c:forEach>
            <c:if test="${empty latestProducts}">
                <p>Chưa có sản phẩm nào.</p>
            </c:if>
        </div>
    </section>

</body>
</html>
