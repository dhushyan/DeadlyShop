<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>DeadlyShop — Premium Motorcycle Accessories</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<%@ include file="header.jsp" %>


<section class="ds-hero">
  <div class="ds-hero-content">
    <span class="ds-hero-badge">&#128293; New Arrivals 2025</span>
    <h1>Gear Up.<br/>Ride <span>Fearless.</span></h1>
    <p>Premium motorcycle accessories engineered for performance, safety &amp; style.</p>
    <div class="ds-hero-cta">
      <a href="${pageContext.request.contextPath}/products" class="ds-btn ds-btn-primary ds-btn-lg">
        Shop Now &#10132;
      </a>
      <a href="#categories" class="ds-btn ds-btn-ghost ds-btn-lg">Explore Categories</a>
    </div>
    <div class="ds-trust-badges">
      <span>&#9989; Free Shipping &#8377;999+</span>
      <span>&#9989; 30-Day Returns</span>
      <span>&#9989; Genuine Products</span>
    </div>
  </div>
  <div class="ds-hero-visual">
    <div class="ds-hero-img-wrapper">
      <img src="https://images.unsplash.com/photo-1506424482693-1f123321fa53?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
     alt="Premium Motorcycle Accessories"
     loading="lazy"/>
    </div>
  </div>
</section>


<section class="ds-section" id="categories">
  <div class="ds-container">
    <div class="ds-section-header">
      <h2>Shop by Category</h2>
      <p>Everything a rider needs, all in one place</p>
    </div>
<div class="ds-category-grid">

<c:forEach var="cat" items="${categories}">

<a href="${pageContext.request.contextPath}/products?category=${cat.id}"
   class="ds-cat-card">

    <c:choose>

        <c:when test="${cat.name=='Accessories'}">
            <img class="ds-cat-img" src="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=300"/>
        </c:when>

        <c:when test="${cat.name=='Gloves'}">
            <img class="ds-cat-img" src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300"/>
        </c:when>

        <c:when test="${cat.name=='Helmets'}">
            <img class="ds-cat-img" src="https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=300"/>
        </c:when>

        <c:when test="${cat.name=='Jackets'}">
            <img class="ds-cat-img" src="https://images.unsplash.com/photo-1521223890158-f9f7c3d5d504?w=300"/>
        </c:when>

        <c:when test="${cat.name=='Riding Boots'}">
            <img class="ds-cat-img" src="https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=300"/>
        </c:when>

        <c:when test="${cat.name=='Visors & Goggles'}">
            <img class="ds-cat-img" src="https://images.unsplash.com/photo-1517841905240-472988babdf9?w=300"/>
        </c:when>

        <c:otherwise>
            <img class="ds-cat-img" src="https://images.unsplash.com/photo-1506424482693-1f123321fa53?w=300"/>
        </c:otherwise>

    </c:choose>

    <h3>${cat.name}</h3>
    <span>Shop →</span>

</a>

</c:forEach>

</div>
  </div>
</section>


<section class="ds-section ds-section-alt">
  <div class="ds-container">
    <div class="ds-section-header">
      <h2>Featured Products</h2>
      <a href="${pageContext.request.contextPath}/products" class="ds-link">View all &#8594;</a>
    </div>
    <div class="ds-product-grid">
      <c:forEach var="product" items="${featuredProducts}">
        <div class="ds-product-card">
          <a href="${pageContext.request.contextPath}/product?id=${product.id}">
            <div class="ds-product-img-wrap">
              <img src="${product.imageUrl}" alt="${product.name}" loading="lazy"/>
              <c:if test="${product.stock == 0}">
                <span class="ds-badge ds-badge-oos">Out of Stock</span>
              </c:if>
              <c:if test="${product.stock > 0 && product.stock < 10}">
                <span class="ds-badge ds-badge-low">Only ${product.stock} left</span>
              </c:if>
            </div>
          </a>
          <div class="ds-product-info">
            <p class="ds-product-cat">${product.categoryName}</p>
            <h3 class="ds-product-name">
              <a href="${pageContext.request.contextPath}/product?id=${product.id}">${product.name}</a>
            </h3>
            <p class="ds-product-brand">${product.brand}</p>
            <div class="ds-product-rating">
              <span class="ds-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
              <span>${product.rating}</span>
            </div>
            <div class="ds-product-footer">
              <span class="ds-price">
                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="&#8377;" maxFractionDigits="0"/>
              </span>
              <form action="${pageContext.request.contextPath}/cart" method="post">
                <input type="hidden" name="action" value="add"/>
                <input type="hidden" name="productId" value="${product.id}"/>
                <input type="hidden" name="qty" value="1"/>
                <button type="submit" class="ds-btn ds-btn-add"
                        ${product.stock == 0 ? 'disabled' : ''}>
                  &#43; Add
                </button>
              </form>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</section>


<section class="ds-usp">
  <div class="ds-container ds-usp-grid">
    <div class="ds-usp-item">
      <span class="ds-usp-icon">&#128666;</span>
      <h4>Fast Delivery</h4>
      <p>2–5 business days pan-India</p>
    </div>
    <div class="ds-usp-item">
      <span class="ds-usp-icon">&#128274;</span>
      <h4>Secure Payments</h4>
      <p>COD, UPI, Cards accepted</p>
    </div>
    <div class="ds-usp-item">
      <span class="ds-usp-icon">&#128260;</span>
      <h4>Easy Returns</h4>
      <p>Hassle-free 30-day returns</p>
    </div>
    <div class="ds-usp-item">
      <span class="ds-usp-icon">&#128100;</span>
      <h4>Expert Support</h4>
      <p>Rider-first customer care</p>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
