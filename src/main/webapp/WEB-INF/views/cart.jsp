<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Cart — DeadlyShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="ds-container ds-cart-layout">
  <h1 class="ds-page-title">Your Cart</h1>

  <c:choose>
    <c:when test="${empty cartItems}">
      <div class="ds-empty-state">
        <p style="font-size:60px">&#128722;</p>
        <h2>Your cart is empty</h2>
        <a href="${pageContext.request.contextPath}/products" class="ds-btn ds-btn-primary">
          Start Shopping
        </a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="ds-cart-grid">
   
        <div class="ds-cart-items">
          <c:forEach var="item" items="${cartItems}">
            <div class="ds-cart-row" id="cart-row-${item.productId}">
              <img src="${item.imageUrl}" alt="${item.productName}" class="ds-cart-img"/>
              <div class="ds-cart-item-info">
                <h3>${item.productName}</h3>
                <p class="ds-price">
                  <fmt:formatNumber value="${item.unitPrice}" type="currency"
                                    currencySymbol="&#8377;" maxFractionDigits="0"/>
                </p>
              </div>
              <div class="ds-cart-qty">
                <button class="ds-qty-btn" onclick="updateQty(${item.productId}, -1)">&#8722;</button>
                <span id="qty-${item.productId}">${item.quantity}</span>
                <button class="ds-qty-btn" onclick="updateQty(${item.productId}, 1)">&#43;</button>
              </div>
              <div class="ds-cart-subtotal" id="sub-${item.productId}">
                <fmt:formatNumber value="${item.subtotal}" type="currency"
                                  currencySymbol="&#8377;" maxFractionDigits="0"/>
              </div>
              <button class="ds-remove-btn" onclick="removeItem(${item.productId})">&#10007;</button>
            </div>
          </c:forEach>
        </div>

      
        <div class="ds-cart-summary">
          <h2>Order Summary</h2>
          <div class="ds-summary-row">
            <span>Subtotal</span>
            <span id="cart-total">
              <fmt:formatNumber value="${cartTotal}" type="currency"
                                currencySymbol="&#8377;" maxFractionDigits="0"/>
            </span>
          </div>
          <div class="ds-summary-row">
            <span>Shipping</span>
            <span id="shipping-cost">
              <c:choose>
                <c:when test="${cartTotal >= 999}">FREE</c:when>
                <c:otherwise>&#8377;99</c:otherwise>
              </c:choose>
            </span>
          </div>
          <div class="ds-summary-row ds-summary-total">
            <span>Total</span>
            <span id="grand-total">
              <fmt:formatNumber value="${cartTotal + (cartTotal >= 999 ? 0 : 99)}"
                                type="currency" currencySymbol="&#8377;" maxFractionDigits="0"/>
            </span>
          </div>
          <a href="${pageContext.request.contextPath}/checkout"
             class="ds-btn ds-btn-primary ds-btn-full ds-btn-lg">
            Proceed to Checkout &#10132;
          </a>
          <a href="${pageContext.request.contextPath}/products" class="ds-link-center">
            &#8592; Continue Shopping
          </a>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<%@ include file="footer.jsp" %>
<script>
const CP = '${pageContext.request.contextPath}';

function updateQty(productId, delta) {
  const qtyEl = document.getElementById('qty-' + productId);
  let qty = parseInt(qtyEl.textContent) + delta;
  if (qty < 1) qty = 1;

  fetch(CP + '/cart', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded',
                'Accept': 'application/json' },
    body: 'action=update&productId=' + productId + '&qty=' + qty
  })
  .then(r => r.json())
  .then(data => {
    if (data.success) {
      qtyEl.textContent = qty;
      location.reload(); 
    }
  });
}

function removeItem(productId) {
  if (!confirm('Remove this item?')) return;
  fetch(CP + '/cart', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded',
                'Accept': 'application/json' },
    body: 'action=remove&productId=' + productId
  })
  .then(r => r.json())
  .then(data => {
    if (data.success) {
      const row = document.getElementById('cart-row-' + productId);
      if (row) row.remove();
      
      if (data.cartCount === 0) location.reload();
    }
  });
}
</script>
</body>
</html>
