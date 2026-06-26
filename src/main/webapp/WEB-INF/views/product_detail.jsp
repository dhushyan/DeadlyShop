<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>${product.name} — DeadlyShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="ds-container ds-detail-layout">

  
  <div class="ds-detail-img-col">
    <div class="ds-detail-img-wrap">
      <img src="${product.imageUrl}" alt="${product.name}" id="mainImg"/>
    </div>
  </div>

 
  <div class="ds-detail-info-col">
    <p class="ds-product-cat">${product.categoryName}</p>
    <h1 class="ds-detail-title">${product.name}</h1>
    <p class="ds-detail-brand">Brand: <strong>${product.brand}</strong></p>

    <div class="ds-detail-rating">
      <span class="ds-stars">
        <c:forEach begin="1" end="5" var="i">
          <c:choose>
            <c:when test="${i <= product.rating}">&#9733;</c:when>
            <c:otherwise>&#9734;</c:otherwise>
          </c:choose>
        </c:forEach>
      </span>
      <span>${product.rating} / 5</span>
    </div>

    <div class="ds-detail-price">
      <fmt:formatNumber value="${product.price}" type="currency"
                        currencySymbol="&#8377;" maxFractionDigits="0"/>
    </div>

    <p class="ds-detail-stock">
      <c:choose>
        <c:when test="${product.stock > 10}">
          <span class="ds-in-stock">&#10003; In Stock</span>
        </c:when>
        <c:when test="${product.stock > 0}">
          <span class="ds-low-stock">&#9888; Only ${product.stock} left!</span>
        </c:when>
        <c:otherwise>
          <span class="ds-oos">&#10007; Out of Stock</span>
        </c:otherwise>
      </c:choose>
    </p>

    <p class="ds-detail-desc">${product.description}</p>

    <c:if test="${product.stock > 0}">
      <form class="ds-detail-cart-form" action="${pageContext.request.contextPath}/cart" method="post">
        <input type="hidden" name="action" value="add"/>
        <input type="hidden" name="productId" value="${product.id}"/>
        <div class="ds-qty-control">
          <label>Qty:</label>
          <input type="number" name="qty" value="1" min="1" max="${product.stock}"/>
        </div>
        <div class="ds-detail-actions">
          <button type="submit" class="ds-btn ds-btn-primary ds-btn-lg">
            &#128722; Add to Cart
          </button>
          <a href="${pageContext.request.contextPath}/checkout"
             class="ds-btn ds-btn-ghost ds-btn-lg">Buy Now</a>
        </div>
      </form>
    </c:if>

    <div class="ds-detail-meta">
      <span>&#128666; Free delivery on orders above &#8377;999</span>
      <span>&#128260; 30-day easy returns</span>
    </div>
  </div>
</div>


<c:if test="${not empty relatedProducts}">
  <section class="ds-section ds-section-alt">
    <div class="ds-container">
      <div class="ds-section-header">
        <h2>You May Also Like</h2>
      </div>
      <div class="ds-product-grid">
        <c:forEach var="rp" items="${relatedProducts}">
          <div class="ds-product-card">
            <a href="${pageContext.request.contextPath}/product?id=${rp.id}">
              <div class="ds-product-img-wrap">
                <img src="${rp.imageUrl}" alt="${rp.name}" loading="lazy"/>
              </div>
            </a>
            <div class="ds-product-info">
              <h3 class="ds-product-name">
                <a href="${pageContext.request.contextPath}/product?id=${rp.id}">${rp.name}</a>
              </h3>
              <div class="ds-product-footer">
                <span class="ds-price">
                  <fmt:formatNumber value="${rp.price}" type="currency"
                                    currencySymbol="&#8377;" maxFractionDigits="0"/>
                </span>
                <form action="${pageContext.request.contextPath}/cart" method="post">
                  <input type="hidden" name="action" value="add"/>
                  <input type="hidden" name="productId" value="${rp.id}"/>
                  <input type="hidden" name="qty" value="1"/>
                  <button type="submit" class="ds-btn ds-btn-add">&#43; Add</button>
                </form>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </section>
</c:if>

<%@ include file="footer.jsp" %>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
