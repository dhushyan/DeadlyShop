<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="admin_header.jsp" %>

<div class="ds-admin-content">
  <div class="ds-admin-section-header">
    <h1 class="ds-admin-title">Products</h1>
    <a href="${pageContext.request.contextPath}/admin/products/add"
       class="ds-btn ds-btn-primary">&#43; Add Product</a>
  </div>

  <c:if test="${not empty param.msg}">
    <div class="ds-alert ${param.msg == 'error' ? 'ds-alert-error' : 'ds-alert-success'}">
      <c:choose>
        <c:when test="${param.msg == 'added'}">Product added successfully.</c:when>
        <c:when test="${param.msg == 'updated'}">Product updated successfully.</c:when>
        <c:when test="${param.msg == 'deleted'}">Product deleted.</c:when>
        <c:otherwise>An error occurred.</c:otherwise>
      </c:choose>
    </div>
  </c:if>

  <div class="ds-admin-table-wrap">
    <table class="ds-admin-table">
      <thead>
        <tr>
          <th>ID</th><th>Image</th><th>Name</th><th>Category</th>
          <th>Brand</th><th>Price</th><th>Stock</th><th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="p" items="${products}">
          <tr>
            <td>${p.id}</td>
            <td><img src="${p.imageUrl}" alt="" style="width:60px;height:45px;object-fit:cover;border-radius:6px;"/></td>
            <td>${p.name}</td>
            <td>${p.categoryName}</td>
            <td>${p.brand}</td>
            <td>
              <fmt:formatNumber value="${p.price}" type="currency"
                                currencySymbol="&#8377;" maxFractionDigits="0"/>
            </td>
            <td>
              <span class="${p.stock == 0 ? 'ds-badge-oos' : (p.stock < 10 ? 'ds-badge-low' : '')}">
                ${p.stock}
              </span>
            </td>
            <td class="ds-action-btns">
              <a href="${pageContext.request.contextPath}/admin/products/edit?id=${p.id}"
                 class="ds-btn ds-btn-sm ds-btn-edit">Edit</a>
              <a href="${pageContext.request.contextPath}/admin/products/delete?id=${p.id}"
                 class="ds-btn ds-btn-sm ds-btn-danger"
                 onclick="return confirm('Delete this product?')">Delete</a>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty products}">
          <tr><td colspan="8" style="text-align:center">No products found.</td></tr>
        </c:if>
      </tbody>
    </table>
  </div>
</div>

<%@ include file="admin_footer.jsp" %>
