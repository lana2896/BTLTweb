<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${product.name}</title>
<style>
    .detail-wrap {
        max-width: 900px; margin: 32px auto; padding: 24px 32px;
        background: #FFFFFF; border: 1px solid #E0E0E0; border-radius: 8px;
        display: flex; gap: 32px;
    }
    .detail-img { flex: 0 0 320px; height: 320px; object-fit: cover; border-radius: 8px; background: #F0F0F0; }
    .detail-info { flex: 1; }
    .detail-info h1 { font-size: 22px; margin-bottom: 12px; color: #222; }
    .detail-price { font-size: 22px; font-weight: 700; color: #2E7D32; margin-bottom: 16px; }
    .detail-meta { font-size: 13px; color: #777; margin-bottom: 16px; }
    .detail-desc { font-size: 14px; color: #444; line-height: 1.6; margin-bottom: 20px; }
    .back-link { display: inline-block; margin: 20px 0 0 15px; font-size: 13px; color: #2E7D32; }
    .add-to-cart-form { display: flex; align-items: center; margin-top: 4px; }

    @media (max-width: 700px) {
        .detail-wrap { flex-direction: column; }
        .detail-img { flex: none; width: 100%; height: 220px; }
    }
</style>
</head>
<body>

    <a class="back-link" href="<c:url value='/product'/>">← Quay lại danh sách sản phẩm</a>

    <div class="detail-wrap">
        <c:url value="/image?fname=${product.image}" var="imgUrl"/>
        <img class="detail-img" src="${imgUrl}"
             onerror="this.src='https://via.placeholder.com/320x320?text=No+Image'" />

        <div class="detail-info">
            <h1>${product.name}</h1>
            <div class="detail-price">
                <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> đ
            </div>
            <div class="detail-meta">
                Danh mục: <b>${product.category.catename}</b> &nbsp;|&nbsp;
                Còn lại: <b>${product.quantity}</b> sản phẩm
            </div>
            <div class="detail-desc">${product.description}</div>

            <c:choose>
                <c:when test="${product.quantity > 0}">
                    <form method="post" action="<c:url value='/cart/add'/>" class="add-to-cart-form">
                        <input type="hidden" name="productId" value="${product.id}">
                        <label for="quantity" style="font-size:13px;color:#555;">Số lượng:</label>
                        <input type="number" id="quantity" name="quantity" value="1" min="1" max="${product.quantity}"
                               style="width:60px;padding:6px;margin:0 10px;">
                        <button type="submit" class="btn btn-brand">Thêm vào giỏ hàng</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <button class="btn btn-brand" disabled>Hết hàng</button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</body>
</html>
