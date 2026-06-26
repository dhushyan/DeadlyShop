<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="admin_header.jsp" %>

<div class="ds-admin-content">
  <h1 class="ds-admin-title">All Orders</h1>

  <c:if test="${not empty param.msg}">
    <div class="ds-alert ds-alert-success">Order status updated.</div>
  </c:if>

  <c:forEach var="order" items="${orders}">
    <div class="ds-order-card ds-admin-order-card">
      <div class="ds-order-header">
        <div>
          <span class="ds-order-id">Order #${order.id}</span>
          <span class="ds-order-date">
            <fmt:formatDate value="${order.placedAt}" pattern="dd MMM yyyy, hh:mm a"/>
          </span>
          <span style="margin-left:10px">Customer: <strong>${order.userName}</strong></span>
        </div>
        <div style="display:flex;align-items:center;gap:10px">
          <span class="ds-status ds-status-${order.status}">${order.status}</span>
          <span class="ds-price">
            <fmt:formatNumber value="${order.totalAmount}" type="currency"
                              currencySymbol="&#8377;" maxFractionDigits="0"/>
          </span>
        </div>
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

      <div class="ds-order-footer" style="display:flex;align-items:center;gap:16px;flex-wrap:wrap">
        <span>&#128205; ${order.shippingAddress}, ${order.shippingCity} — ${order.shippingPincode}</span>
        <span>Payment: ${order.paymentMethod}</span>
        <form action="${pageContext.request.contextPath}/admin/orders/update" method="post"
              style="display:flex;gap:8px;align-items:center;margin-left:auto">
          <input type="hidden" name="orderId" value="${order.id}"/>
          <select name="status" class="ds-select-sm">
            <option value="pending"   ${order.status=='pending'   ? 'selected':''}>Pending</option>
            <option value="confirmed" ${order.status=='confirmed' ? 'selected':''}>Confirmed</option>
            <option value="shipped"   ${order.status=='shipped'   ? 'selected':''}>Shipped</option>
            <option value="delivered" ${order.status=='delivered' ? 'selected':''}>Delivered</option>
            <option value="cancelled" ${order.status=='cancelled' ? 'selected':''}>Cancelled</option>
          </select>
          <button type="submit" class="ds-btn ds-btn-sm ds-btn-primary">Update</button>
        </form>
      </div>
    </div>
  </c:forEach>

  <c:if test="${empty orders}">
    <div class="ds-empty-state"><p>No orders found.</p></div>
  </c:if>
</div>

<%@ include file="admin_footer.jsp" %>
