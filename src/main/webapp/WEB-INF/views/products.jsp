<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>
    <c:choose>
      <c:when test="${not empty searchQuery}">Search: ${searchQuery}</c:when>
      <c:when test="${not empty selectedCategory}">${selectedCategory.name}</c:when>
      <c:otherwise>All Products</c:otherwise>
    </c:choose>
    — DeadlyShop
  </title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="ds-page-header">
  <div class="ds-container">
    <h1>
      <c:choose>
        <c:when test="${not empty searchQuery}">Results for: "${searchQuery}"</c:when>
        <c:when test="${not empty selectedCategory}">${selectedCategory.name}</c:when>
        <c:otherwise>All Products</c:otherwise>
      </c:choose>
    </h1>
    <p>${products.size()} products found</p>
  </div>
</div>

<div class="ds-shop-layout ds-container">


  <aside class="ds-sidebar">
    <h3>Filter by Category</h3>
    <ul class="ds-filter-list">
      <li>
        <a href="${pageContext.request.contextPath}/products"
           class="${empty param.category && empty param.search ? 'active' : ''}">
          All Products
        </a>
      </li>
      <c:forEach var="cat" items="${categories}">
        <li>
          <a href="${pageContext.request.contextPath}/products?category=${cat.id}"
             class="${param.category == cat.id ? 'active' : ''}">
            ${cat.name}
          </a>
        </li>
      </c:forEach>
    </ul>
  </aside>

 
  <main class="ds-main-products">
    <c:choose>
      <c:when test="${empty products}">
        <div class="ds-empty-state">
          <p>&#128269; No products found.</p>
          <a href="${pageContext.request.contextPath}/products" class="ds-btn ds-btn-primary">
            Browse All
          </a>
        </div>
      </c:when>
      <c:otherwise>
        <div class="ds-product-grid">
          <c:forEach var="product" items="${products}">
            <div class="ds-product-card">
              <a href="${pageContext.request.contextPath}/product?id=${product.id}">
                <div class="ds-product-img-wrap">
                  <img src="${product.imageUrl}" alt="${product.name}" loading="lazy"/>
                  <c:if test="${product.stock == 0}">
                    <span class="ds-badge ds-badge-oos">Out of Stock</span>
                  </c:if>
                </div>
              </a>
              <div class="ds-product-info">
                <p class="ds-product-cat">${product.categoryName}</p>
                <h3 class="ds-product-name">
                  <a href="${pageContext.request.contextPath}/product?id=${product.id}">
                    ${product.name}
                  </a>
                </h3>
                <p class="ds-product-brand">${product.brand}</p>
                <div class="ds-product-rating">
                  <span class="ds-stars">&#9733;</span> ${product.rating}
                </div>
                <div class="ds-product-footer">
                  <span class="ds-price">
                    <fmt:formatNumber value="${product.price}" type="currency"
                                      currencySymbol="&#8377;" maxFractionDigits="0"/>
                  </span>
                  <form action="${pageContext.request.contextPath}/cart" method="post">
                    <input type="hidden" name="action" value="add"/>
                    <input type="hidden" name="productId" value="${product.id}"/>
                    <input type="hidden" name="qty" value="1"/>
                    <button type="submit" class="ds-btn ds-btn-add"
                            ${product.stock == 0 ? 'disabled' : ''}>&#43; Add</button>
                  </form>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>
  </main>
</div>

<%@ include file="footer.jsp" %>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
