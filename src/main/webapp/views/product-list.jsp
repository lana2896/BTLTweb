<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tất cả sản phẩm</title>
<style>
    .section { max-width: 1140px; margin: 32px auto; padding: 0 15px; }
    .section-title { margin-bottom: 20px; }
    .section-title h1 { font-size: 22px; font-weight: 700; color: #222; }

    .product-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; }
    .product-card { background: #FFFFFF; border: 1px solid #E0E0E0; border-radius: 8px; padding: 12px; }
    .product-card:hover { border-color: #2E7D32; }
    .product-link { display: block; cursor: pointer; color: inherit; text-decoration: none; }
    .product-thumb { width: 100%; height: 250px; object-fit: cover; border-radius: 6px; margin-bottom: 10px; background: #F0F0F0; }
    .product-card h3 { font-size: 14px; font-weight: 600; color: #333; margin-bottom: 4px; }
    .product-price { font-size: 14px; font-weight: 700; color: #2E7D32; margin-bottom: 10px; }
    .btn-add-cart {
        width: 100%; padding: 8px; border: 1px solid #2E7D32; background: #2E7D32; color: #fff;
        border-radius: 4px; font-size: 13px; cursor: pointer;
    }
    .btn-add-cart:hover { background: #256a29; }

    .pagination-wrap { display: flex; justify-content: center; gap: 6px; margin-top: 28px; }
    .pagination-wrap a, .pagination-wrap span {
        display: inline-block; padding: 6px 12px; border: 1px solid #DDD; border-radius: 4px; font-size: 13px; color: #333;
    }
    .pagination-wrap a:hover { border-color: #2E7D32; color: #2E7D32; }
    .pagination-wrap .active { background: #2E7D32; color: #fff; border-color: #2E7D32; }

    @media (max-width: 900px) { .product-grid { grid-template-columns: repeat(2, 1fr); } }
</style>
</head>
<body>

    <section class="section">
        <div class="section-title">
            <h1>Tất cả sản phẩm</h1>
        </div>

        <div class="product-grid">
            <c:forEach items="${products}" var="p">
                <div class="product-card">
                    <a href="<c:url value='/product/detail?id=${p.id}'/>" class="product-link">
                        <c:url value="/image?fname=${p.image}" var="imgUrl"/>
                        <img src="${imgUrl}" class="product-thumb"
                             onerror="this.src='https://via.placeholder.com/220x150?text=No+Image'" />
                        <h3>${p.name}</h3>
                        <div class="product-price">
                            <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/> đ
                        </div>
                    </a>
                    <c:choose>
                        <c:when test="${p.quantity > 0}">
                            <form method="post" action="<c:url value='/cart/add'/>">
                                <input type="hidden" name="productId" value="${p.id}">
                                <input type="hidden" name="quantity" value="1">
                                <button type="submit" class="btn-add-cart">Thêm vào giỏ hàng</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <button class="btn-add-cart" disabled>Hết hàng</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:forEach>
            <c:if test="${empty products}">
                <p>Chưa có sản phẩm nào.</p>
            </c:if>
        </div>

        <div class="pagination-wrap">
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

</body>
</html>
