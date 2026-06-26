<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>My Orders — DeadlyShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="ds-container">
  <h1 class="ds-page-title">My Orders</h1>

  <c:if test="${not empty newOrderId}">
    <div class="ds-alert ds-alert-success">
      &#10003; Order #${newOrderId} placed successfully! Thank you for shopping with DeadlyShop.
    </div>
  </c:if>

  <c:choose>
    <c:when test="${empty orders}">
      <div class="ds-empty-state">
        <p style="font-size:60px">&#128230;</p>
        <h2>No orders yet</h2>
        <a href="${pageContext.request.contextPath}/products" class="ds-btn ds-btn-primary">
          Start Shopping
        </a>
      </div>
    </c:when>
    <c:otherwise>
      <c:forEach var="order" items="${orders}">
        <div class="ds-order-card">
          <div class="ds-order-header">
            <div>
              <span class="ds-order-id">Order #${order.id}</span>
              <span class="ds-order-date">
                <fmt:formatDate value="${order.placedAt}" pattern="dd MMM yyyy, hh:mm a"/>
              </span>
            </div>
            <div>
              <span class="ds-status ds-status-${order.status}">${order.status}</span>
              <span class="ds-price">
                <fmt:formatNumber value="${order.totalAmount}" type="currency"
                                  currencySymbol="&#8377;" maxFractionDigits="0"/>
              </span>
            </div>
          </div>
          <div class="ds-order-shipping">
            &#128205; ${order.shippingAddress}, ${order.shippingCity} — ${order.shippingPincode}
          </div>
          <div class="ds-order-items-list">
            <c:forEach var="item" items="${order.items}">
              <div class="ds-order-item-row">
                <img src="${item.imageUrl}" alt="${item.productName}" class="ds-order-thumb"/>
                <div>
                  <p>${item.productName}</p>
                  <p>Qty: ${item.quantity} &times;
                    <fmt:formatNumber value="${item.unitPrice}" type="currency"
                                      currencySymbol="&#8377;" maxFractionDigits="0"/>
                  </p>
                </div>
              </div>
            </c:forEach>
          </div>
          <div class="ds-order-footer">
            <span>Payment: ${order.paymentMethod}</span>
          </div>
        </div>
      </c:forEach>
    </c:otherwise>
  </c:choose>
</div>

<%@ include file="footer.jsp" %>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
