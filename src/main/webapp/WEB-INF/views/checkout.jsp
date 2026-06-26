<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Checkout — DeadlyShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="ds-container ds-checkout-layout">
  <h1 class="ds-page-title">Checkout</h1>

  <c:if test="${not empty error}">
    <div class="ds-alert ds-alert-error">${error}</div>
  </c:if>

  <div class="ds-checkout-grid">

    <div class="ds-checkout-form-col">
      <form action="${pageContext.request.contextPath}/checkout" method="post"
            id="checkoutForm">
        <section class="ds-form-section">
          <h2>Shipping Details</h2>
          <div class="ds-form-row2">
            <div class="ds-form-group">
              <label>Full Name *</label>
              <input type="text" name="shippingName" required
                     value="${sessionScope.userName}" placeholder="Full Name"/>
            </div>
            <div class="ds-form-group">
              <label>Phone Number *</label>
              <input type="tel" name="shippingPhone" required
                     pattern="[6-9][0-9]{9}" placeholder="9876543210"/>
            </div>
          </div>
          <div class="ds-form-group">
            <label>Address *</label>
            <textarea name="shippingAddress" required rows="3"
                      placeholder="House No, Street, Area"></textarea>
          </div>
          <div class="ds-form-row3">
            <div class="ds-form-group">
              <label>City *</label>
              <input type="text" name="shippingCity" required placeholder="City"/>
            </div>
            <div class="ds-form-group">
              <label>State *</label>
              <input type="text" name="shippingState" required placeholder="State"/>
            </div>
            <div class="ds-form-group">
              <label>Pincode *</label>
              <input type="text" name="shippingPincode" required
                     pattern="[0-9]{6}" placeholder="560001"/>
            </div>
          </div>
        </section>

        <section class="ds-form-section">
          <h2>Payment Method</h2>
          <div class="ds-payment-options">
            <label class="ds-payment-opt">
              <input type="radio" name="paymentMethod" value="COD" checked/>
              <span>&#128181; Cash on Delivery</span>
            </label>
            <label class="ds-payment-opt">
              <input type="radio" name="paymentMethod" value="UPI"/>
              <span>&#128247; UPI</span>
            </label>
            <label class="ds-payment-opt">
              <input type="radio" name="paymentMethod" value="Card"/>
              <span>&#128179; Debit/Credit Card</span>
            </label>
          </div>
        </section>

        <button type="submit" class="ds-btn ds-btn-primary ds-btn-full ds-btn-lg">
          &#10003; Place Order
        </button>
      </form>
    </div>


    <div class="ds-checkout-summary">
      <h2>Order Items</h2>
      <c:forEach var="item" items="${cartItems}">
        <div class="ds-summary-item">
          <img src="${item.imageUrl}" alt="${item.productName}" class="ds-summary-thumb"/>
          <div>
            <p>${item.productName}</p>
            <p>Qty: ${item.quantity} &times;
              <fmt:formatNumber value="${item.unitPrice}" type="currency"
                                currencySymbol="&#8377;" maxFractionDigits="0"/>
            </p>
          </div>
          <span class="ds-price">
            <fmt:formatNumber value="${item.subtotal}" type="currency"
                              currencySymbol="&#8377;" maxFractionDigits="0"/>
          </span>
        </div>
      </c:forEach>

      <hr class="ds-divider"/>
      <div class="ds-summary-row">
        <span>Subtotal</span>
        <span><fmt:formatNumber value="${subtotal}" type="currency"
                                currencySymbol="&#8377;" maxFractionDigits="0"/></span>
      </div>
      <div class="ds-summary-row">
        <span>Shipping</span>
        <span>
          <c:choose>
            <c:when test="${shipping == 0}">FREE</c:when>
            <c:otherwise><fmt:formatNumber value="${shipping}" type="currency"
                                            currencySymbol="&#8377;" maxFractionDigits="0"/>
            </c:otherwise>
          </c:choose>
        </span>
      </div>
      <div class="ds-summary-row ds-summary-total">
        <span>Grand Total</span>
        <span><fmt:formatNumber value="${grandTotal}" type="currency"
                                currencySymbol="&#8377;" maxFractionDigits="0"/></span>
      </div>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
