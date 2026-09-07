<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tất Cả Sản Phẩm</title>
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Segoe UI', Arial, sans-serif; background: #F7F9F8; color: #333; }
    a { text-decoration: none; color: inherit; }

    header {
        display: flex; align-items: center; justify-content: space-between;
        padding: 14px 32px; background: #FFFFFF; border-bottom: 1px solid #E0E0E0;
    }
    .logo { font-weight: 700; font-size: 18px; color: #2E7D32; }

    .section { max-width: 1000px; margin: 32px auto; padding: 0 32px; }
    .section-title { margin-bottom: 20px; }
    .section-title h1 { font-size: 22px; font-weight: 700; color: #222; }

    .product-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; }
    .product-card {
        background: #FFFFFF; border: 1px solid #E0E0E0; border-radius: 8px; padding: 12px; cursor: pointer;
    }
    .product-card:hover { border-color: #2E7D32; }
    .product-thumb {
        width: 100%; height: 150px; object-fit: cover; border-radius: 6px; margin-bottom: 10px; background: #F0F0F0;
    }
    .product-card h3 { font-size: 14px; font-weight: 600; color: #333; margin-bottom: 4px; }
    .product-price { font-size: 14px; font-weight: 700; color: #2E7D32; }

    .pagination { display: flex; justify-content: center; gap: 6px; margin-top: 28px; }
    .pagination a, .pagination span {
        display: inline-block; padding: 6px 12px; border: 1px solid #DDD; border-radius: 4px;
        font-size: 13px; color: #333;
    }
    .pagination a:hover { border-color: #2E7D32; color: #2E7D32; }
    .pagination .active { background: #2E7D32; color: #fff; border-color: #2E7D32; }

    footer { text-align: center; padding: 20px; font-size: 12px; color: #999; border-top: 1px solid #E0E0E0; }

    @media (max-width: 900px) {
        .product-grid { grid-template-columns: repeat(2, 1fr); }
    }
</style>
</head>
<body>

    <header>
        <a href="<c:url value='/home'/>" class="logo">Minh Thư</a>
    </header>

    <section class="section">
        <div class="section-title">
            <h1>Tất cả sản phẩm</h1>
        </div>

        <div class="product-grid">
            <c:forEach items="${products}" var="p">
                <a href="<c:url value='/product/detail?id=${p.id}'/>">
                    <div class="product-card">
                        <c:url value="/image?fname=${p.image}" var="imgUrl"/>
                        <img src="${imgUrl}" class="product-thumb"
                             onerror="this.src='https://via.placeholder.com/220x150?text=No+Image'" />
                        <h3>${p.name}</h3>
                        <div class="product-price">
                            <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/> đ
                        </div>
                    </div>
                </a>
            </c:forEach>
            <c:if test="${empty products}">
                <p>Chưa có sản phẩm nào.</p>
            </c:if>
        </div>

        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="<c:url value='/product?page=${currentPage - 1}'/>">‹ Trước</a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span class="active">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/product?page=${i}'/>">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="<c:url value='/product?page=${currentPage + 1}'/>">Sau ›</a>
            </c:if>
        </div>
    </section>

    <footer>© Minh Thư</footer>

</body>
</html>