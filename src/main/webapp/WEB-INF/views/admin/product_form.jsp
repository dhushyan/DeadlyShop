<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="admin_header.jsp" %>

<div class="ds-admin-content">
  <h1 class="ds-admin-title">
    <c:choose>
      <c:when test="${not empty product}">Edit Product: ${product.name}</c:when>
      <c:otherwise>Add New Product</c:otherwise>
    </c:choose>
  </h1>

  <form class="ds-admin-form"
        action="${pageContext.request.contextPath}/admin/products/${not empty product ? 'edit' : 'add'}"
        method="post">

    <c:if test="${not empty product}">
      <input type="hidden" name="id" value="${product.id}"/>
    </c:if>

    <div class="ds-form-row2">
      <div class="ds-form-group">
        <label>Product Name *</label>
        <input type="text" name="name" required
               value="${not empty product ? product.name : ''}"/>
      </div>
      <div class="ds-form-group">
        <label>Brand *</label>
        <input type="text" name="brand" required
               value="${not empty product ? product.brand : ''}"/>
      </div>
    </div>

    <div class="ds-form-row2">
      <div class="ds-form-group">
        <label>Category *</label>
        <select name="categoryId" required>
          <option value="">-- Select Category --</option>
          <c:forEach var="cat" items="${categories}">
            <option value="${cat.id}"
              ${not empty product && product.categoryId == cat.id ? 'selected' : ''}>
              ${cat.name}
            </option>
          </c:forEach>
        </select>
      </div>
      <div class="ds-form-group">
        <label>Rating (1–5)</label>
        <input type="number" name="rating" step="0.1" min="1" max="5" required
               value="${not empty product ? product.rating : '4.0'}"/>
      </div>
    </div>

    <div class="ds-form-row2">
      <div class="ds-form-group">
        <label>Price (&#8377;) *</label>
        <input type="number" name="price" step="0.01" min="0" required
               value="${not empty product ? product.price : ''}"/>
      </div>
      <div class="ds-form-group">
        <label>Stock *</label>
        <input type="number" name="stock" min="0" required
               value="${not empty product ? product.stock : '0'}"/>
      </div>
    </div>

    <div class="ds-form-group">
      <label>Image URL</label>
      <input type="text" name="imageUrl"
             placeholder="https://example.com/image.jpg"
             value="${not empty product ? product.imageUrl : ''}"/>
    </div>

    <div class="ds-form-group">
      <label>Description</label>
      <textarea name="description" rows="4"
                placeholder="Product description...">${not empty product ? product.description : ''}</textarea>
    </div>

    <div class="ds-form-actions">
      <button type="submit" class="ds-btn ds-btn-primary">
        <c:choose>
          <c:when test="${not empty product}">&#10003; Update Product</c:when>
          <c:otherwise>&#43; Add Product</c:otherwise>
        </c:choose>
      </button>
      <a href="${pageContext.request.contextPath}/admin/products"
         class="ds-btn ds-btn-outline">Cancel</a>
    </div>
  </form>
</div>

<%@ include file="admin_footer.jsp" %>
