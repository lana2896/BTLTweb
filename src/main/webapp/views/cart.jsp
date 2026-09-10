<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Giỏ hàng</title>
<style>
    .cart-wrap { max-width: 1100px; margin: 32px auto; padding: 0 15px; }
    .cart-row { display: grid; grid-template-columns: 34px 64px 1fr 110px 150px 110px 46px; gap: 12px; align-items: center; padding: 12px 0; border-bottom: 1px solid #e5e5e5; }
    .cart-head { font-weight: 700; color: #555; }
    .cart-product { font-weight: 600; }
    .cart-thumb { width: 56px; height: 56px; object-fit: cover; border-radius: 6px; background: #f0f0f0; border: 1px solid #e5e5e5; }
    .cart-qty-box { display: flex; align-items: center; gap: 6px; }
    .qty-btn { width: 26px; height: 26px; padding: 0; line-height: 1; border: 1px solid #ccc; background: #f5f5f5; color: #333; border-radius: 4px; cursor: pointer; }
    .cart-quantity { width: 50px; padding: 5px; text-align: center; }
    .cart-total { margin-top: 22px; text-align: right; font-size: 20px; font-weight: 700; color: #2E7D32; }
    .cart-selected-summary { margin-top: 6px; text-align: right; color: #444; font-size: 14px; }
    .select-all-row { display: flex; align-items: center; gap: 8px; margin: 10px 0; font-weight: 600; }
    .cart-actions { display: flex; gap: 8px; margin-top: 18px; justify-content: flex-end; flex-wrap: wrap; }
    .message { padding: 10px 12px; margin-bottom: 16px; background: #edf7ed; color: #236b2b; border-radius: 4px; }
    .empty { padding: 36px 0; text-align: center; color: #666; }
    button, .back { border: 1px solid #2E7D32; background: #2E7D32; color: #fff; padding: 8px 14px; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 14px; }
    .remove { border: none; background: transparent; color: #b3261e; font-size: 18px; cursor: pointer; padding: 4px; }
    .btn-update { background: #1565C0; border-color: #1565C0; }
    .btn-clear { background: #b3261e; border-color: #b3261e; }
    .btn-checkout { background: #EF6C00; border-color: #EF6C00; }
    .btn-checkout:disabled { background: #bbb; border-color: #bbb; cursor: not-allowed; }
    .select-checkbox { width: 18px; height: 18px; cursor: pointer; }

    /* Custom confirm modal (thay cho window.confirm mặc định của trình duyệt) */
    .confirm-overlay {
        display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.45);
        align-items: center; justify-content: center; z-index: 1000;
    }
    .confirm-box {
        background: #fff; border-radius: 10px; padding: 24px; width: 320px; max-width: 90%;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2); text-align: center;
    }
    .confirm-box p { margin: 0 0 20px; font-size: 15px; color: #333; }
    .confirm-actions { display: flex; gap: 10px; justify-content: center; }
    .confirm-actions button { flex: 1; padding: 9px 0; font-size: 14px; }
    .btn-confirm-ok { background: #b3261e; border-color: #b3261e; }
    .btn-confirm-cancel { background: #eee; border-color: #ccc; color: #333; }

    @media (max-width: 760px) {
        .cart-row { grid-template-columns: 26px 50px 1fr 90px 40px; }
        .cart-head { display: none; }
        .cart-row > :nth-child(4), .cart-row > :nth-child(5) { display: none; }
    }
</style>
</head>
<body>
<main class="cart-wrap">
    <h1>Giỏ hàng</h1>
    <c:if test="${not empty cartMessage}"><div class="message">${cartMessage}</div></c:if>
    <c:choose>
        <c:when test="${empty cart.items}">
            <div class="empty">Giỏ hàng đang trống. <a href="<c:url value='/product'/>">Xem sản phẩm</a></div>
        </c:when>
        <c:otherwise>
            <%-- Tính số lượng & tổng tiền của các sản phẩm đang được chọn --%>
            <c:set var="totalCount" value="${fn:length(cart.items)}" />
            <c:set var="selectedCount" value="0" />
            <c:set var="selectedTotal" value="0" />
            <c:forEach items="${cart.items}" var="i">
                <c:if test="${i.selected}">
                    <c:set var="selectedCount" value="${selectedCount + 1}" />
                    <c:set var="selectedTotal" value="${selectedTotal + i.subtotal}" />
                </c:if>
            </c:forEach>

            <%-- Checkbox "Chọn tất cả" - submit riêng tới /cart/select hoặc /cart/unselect với itemId=all --%>
            <form id="selectAllForm" method="post" action="<c:url value='/cart/select'/>">
                <input type="hidden" name="itemId" value="all">
            </form>
            <div class="select-all-row">
                <input type="checkbox" class="select-checkbox" id="selectAllCheckbox"
                       ${selectedCount == totalCount ? 'checked' : ''}
                       onchange="submitSelectAll(this.checked)">
                <label for="selectAllCheckbox">Chọn tất cả (${totalCount})</label>
            </div>

            <div class="cart-row cart-head">
                <span></span><span></span><span>Sản phẩm</span><span>Đơn giá</span><span>Số lượng</span><span>Thành tiền</span><span>Thao tác</span>
            </div>

            <%-- Form lớn bao toàn bộ danh sách để hỗ trợ cập nhật số lượng hàng loạt --%>
            <form id="cartMainForm" method="post" action="<c:url value='/cart/update'/>">
                <c:set var="total" value="0" />
                <c:forEach items="${cart.items}" var="item">
                    <div class="cart-row">
                        <span>
                            <%-- Checkbox chọn từng sản phẩm: submit ngay tới /cart/select hoặc /cart/unselect --%>
                            <input type="checkbox" class="select-checkbox item-select"
                                   data-item-id="${item.id}"
                                   ${item.selected ? 'checked' : ''}
                                   onchange="submitSelectOne(${item.id}, this.checked)">
                        </span>
                        <span>
                            <c:url value="/image?fname=${item.product.image}" var="imgUrl"/>
                            <img src="${imgUrl}" class="cart-thumb" alt="${item.product.name}"
                                 onerror="this.src='https://via.placeholder.com/56x56?text=No+Image'" />
                        </span>
                        <span class="cart-product">${item.product.name}</span>
                        <span><fmt:formatNumber value="${item.price}" type="number"/> đ</span>
                        <span class="cart-qty-box">
                            <button type="button" class="qty-btn" onclick="stepQty(this, -1)">-</button>
                            <input class="cart-quantity" type="number" name="quantity" min="0"
                                   max="${item.product.quantity}" value="${item.quantity}">
                            <input type="hidden" name="itemId" value="${item.id}">
                            <button type="button" class="qty-btn" onclick="stepQty(this, 1)">+</button>
                        </span>
                        <span><fmt:formatNumber value="${item.subtotal}" type="number"/> đ</span>
                        <span>
                            <button type="button" class="remove" onclick="submitRemove(${item.id})" title="Xóa sản phẩm">🗑️</button>
                        </span>
                    </div>
                    <c:set var="total" value="${total + item.subtotal}" />
                </c:forEach>

                <div class="cart-selected-summary">
                    🛒 Đã chọn ${selectedCount} sản phẩm - Tổng cộng: <fmt:formatNumber value="${selectedTotal}" type="number"/> đ
                </div>
                <div class="cart-total">Tổng giá trị giỏ hàng: <fmt:formatNumber value="${total}" type="number"/> đ</div>

                <div class="cart-actions">
                    <button type="submit" class="btn-update">Cập nhật giỏ hàng</button>
                    <button type="button" class="btn-clear" onclick="confirmClearCart()">Xóa giỏ hàng</button>
                    <a class="back" href="<c:url value='/product'/>">Tiếp tục mua hàng</a>
                    <button type="button" class="btn-checkout" ${selectedCount == 0 ? 'disabled' : ''}
                            onclick="goCheckout(${selectedCount})">Thanh toán (${selectedCount})</button>
                </div>
            </form>
        </c:otherwise>
    </c:choose>

    <%-- Modal xác nhận dùng chung (thay cho window.confirm) --%>
    <div class="confirm-overlay" id="confirmOverlay">
        <div class="confirm-box">
            <p id="confirmMessage"></p>
            <div class="confirm-actions">
                <button type="button" class="btn-confirm-cancel" onclick="confirmCancel()">Hủy</button>
                <button type="button" class="btn-confirm-ok" onclick="confirmOk()">Đồng ý</button>
            </div>
        </div>
    </div>
</main>

<script>
    function stepQty(btn, delta) {
        var box = btn.parentElement;
        var input = box.querySelector('input[type=number]');
        var min = parseInt(input.min || '0', 10);
        var max = input.max ? parseInt(input.max, 10) : Infinity;
        var value = parseInt(input.value || '0', 10) + delta;
        if (value < min) value = min;
        if (value > max) value = max;
        input.value = value;
    }

    var SELECT_URL = '<c:url value="/cart/select"/>';
    var UNSELECT_URL = '<c:url value="/cart/unselect"/>';
    var CLEAR_URL = '<c:url value="/cart/clear"/>';

    /* ---- Custom confirm modal (thay window.confirm) ---- */
    var pendingConfirmAction = null;

    function showConfirm(message, onConfirm) {
        document.getElementById('confirmMessage').textContent = message;
        pendingConfirmAction = onConfirm;
        document.getElementById('confirmOverlay').style.display = 'flex';
    }

    function confirmOk() {
        document.getElementById('confirmOverlay').style.display = 'none';
        var action = pendingConfirmAction;
        pendingConfirmAction = null;
        if (action) {
            action();
        }
    }

    function confirmCancel() {
        document.getElementById('confirmOverlay').style.display = 'none';
        pendingConfirmAction = null;
    }

    function confirmClearCart() {
        showConfirm('Xóa toàn bộ giỏ hàng?', function () {
            var form = document.getElementById('cartMainForm');
            form.action = CLEAR_URL;
            form.submit();
        });
    }

    function submitSelectOne(itemId, checked) {
        var form = document.createElement('form');
        form.method = 'post';
        form.action = checked ? SELECT_URL : UNSELECT_URL;
        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'itemId';
        input.value = itemId;
        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }

    function submitSelectAll(checked) {
        var form = document.getElementById('selectAllForm');
        form.action = checked ? SELECT_URL : UNSELECT_URL;
        form.submit();
    }

    function submitRemove(itemId) {
        showConfirm('Xóa sản phẩm này khỏi giỏ hàng?', function () {
            var form = document.createElement('form');
            form.method = 'post';
            form.action = '<c:url value="/cart/remove"/>';
            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'itemId';
            input.value = itemId;
            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        });
    }

    function goCheckout(selectedCount) {
        if (selectedCount === 0) {
            return;
        }
        alert('Chức năng thanh toán sẽ sớm được triển khai. Bạn đã chọn ' + selectedCount + ' sản phẩm.');
    }
</script>
</body>
</html>
