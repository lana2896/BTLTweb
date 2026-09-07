<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${product.name}</title>
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Segoe UI', Arial, sans-serif; background: #F7F9F8; color: #333; }
    a { text-decoration: none; color: inherit; }

    header {
        display: flex; align-items: center; padding: 14px 32px;
        background: #FFFFFF; border-bottom: 1px solid #E0E0E0;
    }
    .logo { font-weight: 700; font-size: 18px; color: #2E7D32; }

    .detail-wrap {
        max-width: 900px; margin: 32px auto; padding: 24px 32px;
        background: #FFFFFF; border: 1px solid #E0E0E0; border-radius: 8px;
        display: flex; gap: 32px;
    }
    .detail-img {
        flex: 0 0 320px; height: 320px; object-fit: cover;
        border-radius: 8px; background: #F0F0F0;
    }
    .detail-info { flex: 1; }
    .detail-info h1 { font-size: 22px; margin-bottom: 12px; color: #222; }
    .detail-price { font-size: 22px; font-weight: 700; color: #2E7D32; margin-bottom: 16px; }
    .detail-meta { font-size: 13px; color: #777; margin-bottom: 16px; }
    .detail-desc { font-size: 14px; color: #444; line-height: 1.6; margin-bottom: 20px; }

    .btn-primary {
        background: #2E7D32; color: #fff; font-weight: 600; font-size: 14px;
        padding: 10px 22px; border-radius: 6px; cursor: pointer; border: none;
    }
    .btn-primary:hover { background: #256428; }

    .back-link { display: inline-block; margin: 20px 32px; font-size: 13px; color: #2E7D32; }

    footer { text-align: center; padding: 20px; font-size: 12px; color: #999; border-top: 1px solid #E0E0E0; margin-top: 20px; }

    @media (max-width: 700px) {
        .detail-wrap { flex-direction: column; }
        .detail-img { flex: none; width: 100%; height: 220px; }
    }
</style>
</head>
<body>

    <header>
        <a href="<c:url value='/home'/>" class="logo">Minh Thư</a>
    </header>

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
            <button class="btn-primary">Thêm vào giỏ hàng</button>
        </div>
    </div>

    <footer>© Minh Thư</footer>

</body>
</html>