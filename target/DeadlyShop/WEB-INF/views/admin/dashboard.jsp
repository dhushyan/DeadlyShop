<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="admin_header.jsp" %>

<div class="ds-admin-content">
  <h1 class="ds-admin-title">Dashboard</h1>

  <div class="ds-dash-stats">
    <div class="ds-stat-card ds-stat-blue">
      <div class="ds-stat-icon">&#127955;</div>
      <div class="ds-stat-info">
        <span class="ds-stat-num">${productCount}</span>
        <span class="ds-stat-label">Products</span>
      </div>
    </div>
    <div class="ds-stat-card ds-stat-green">
      <div class="ds-stat-icon">&#128230;</div>
      <div class="ds-stat-info">
        <span class="ds-stat-num">${orderCount}</span>
        <span class="ds-stat-label">Orders</span>
      </div>
    </div>
    <div class="ds-stat-card ds-stat-purple">
      <div class="ds-stat-icon">&#128100;</div>
      <div class="ds-stat-info">
        <span class="ds-stat-num">${userCount}</span>
        <span class="ds-stat-label">Customers</span>
      </div>
    </div>
    <div class="ds-stat-card ds-stat-red">
      <div class="ds-stat-icon">&#8377;</div>
      <div class="ds-stat-info">
        <span class="ds-stat-num">
          <fmt:formatNumber value="${revenue}" type="currency"
                            currencySymbol="&#8377;" maxFractionDigits="0"/>
        </span>
        <span class="ds-stat-label">Revenue</span>
      </div>
    </div>
  </div>

  <div class="ds-admin-section">
    <div class="ds-admin-section-header">
      <h2>Recent Orders</h2>
      <a href="${pageContext.request.contextPath}/admin/orders" class="ds-btn ds-btn-outline">
        View All
      </a>
    </div>
    <div class="ds-admin-table-wrap">
      <table class="ds-admin-table">
        <thead>
          <tr>
            <th>#ID</th><th>Customer</th><th>Amount</th>
            <th>Status</th><th>Date</th><th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="order" items="${recentOrders}">
            <tr>
              <td>#${order.id}</td>
              <td>${order.userName}</td>
              <td>
                <fmt:formatNumber value="${order.totalAmount}" type="currency"
                                  currencySymbol="&#8377;" maxFractionDigits="0"/>
              </td>
              <td><span class="ds-status ds-status-${order.status}">${order.status}</span></td>
              <td><fmt:formatDate value="${order.placedAt}" pattern="dd MMM yyyy"/></td>
              <td>
                <a href="${pageContext.request.contextPath}/admin/orders"
                   class="ds-btn ds-btn-sm">View</a>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty recentOrders}">
            <tr><td colspan="6" style="text-align:center">No orders yet.</td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>

  <div class="ds-admin-quick-links">
    <a href="${pageContext.request.contextPath}/admin/products/add"
       class="ds-btn ds-btn-primary">&#43; Add New Product</a>
    <a href="${pageContext.request.contextPath}/products" target="_blank"
       class="ds-btn ds-btn-outline">&#128279; View Store</a>
  </div>
</div>

<%@ include file="admin_footer.jsp" %>
