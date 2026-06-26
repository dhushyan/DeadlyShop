<%@ page import="dao.CartDAO" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    int cartCount = 0;
    if (userId != null) {
        cartCount = new CartDAO().countItems(userId);
    }
    String cp = request.getContextPath();
%>
<nav class="ds-navbar">
  <div class="ds-nav-inner">
    <a class="ds-logo" href="<%= cp %>/home">
      DEADLY<span>SHOP</span>
    </a>

   
    <form class="ds-search-form" action="<%= cp %>/products" method="get">
      <input type="text" name="search" placeholder="Search helmets, gloves, jackets…"
             value="${param.search}" autocomplete="off"/>
      <button type="submit">&#128269;</button>
    </form>


    <div class="ds-nav-links">
      <a href="<%= cp %>/products">Shop</a>

      <% if (userId == null) { %>
        <a href="<%= cp %>/login"  class="ds-btn ds-btn-outline">Login</a>
        <a href="<%= cp %>/register" class="ds-btn ds-btn-primary">Register</a>
      <% } else { %>
        <a href="<%= cp %>/orders">My Orders</a>
        <a href="<%= cp %>/logout" class="ds-btn ds-btn-outline">Logout</a>
      <% } %>

      <a href="<%= cp %>/cart" class="ds-cart-btn">
        &#128722;
        <% if (cartCount > 0) { %>
          <span class="ds-cart-badge"><%= cartCount %></span>
        <% } %>
      </a>
    </div>

   
    <button class="ds-hamburger" onclick="toggleMobileNav()">&#9776;</button>
  </div>

  
  <div class="ds-cat-bar">
    <a href="<%= cp %>/products">All</a>
    <c:forEach var="cat" items="${categories}">
      <a href="<%= cp %>/products?category=${cat.id}">${cat.name}</a>
    </c:forEach>
  </div>
</nav>
