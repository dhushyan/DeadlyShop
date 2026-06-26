<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login — DeadlyShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body class="ds-auth-page">

<div class="ds-auth-container">
  <div class="ds-auth-brand">
    <a href="${pageContext.request.contextPath}/home" class="ds-logo">
      DEADLY<span>SHOP</span>
    </a>
    <h2>Welcome Back, Rider</h2>
    <p>Log in to continue shopping</p>
  </div>

  <% if (request.getParameter("registered") != null) { %>
    <div class="ds-alert ds-alert-success">Registration successful! Please log in.</div>
  <% } %>
  <% if (request.getParameter("logout") != null) { %>
    <div class="ds-alert ds-alert-success">Logged out successfully.</div>
  <% } %>
  <% if (request.getAttribute("error") != null) { %>
    <div class="ds-alert ds-alert-error">${error}</div>
  <% } %>

  <form class="ds-auth-form" action="${pageContext.request.contextPath}/login" method="post">
    <div class="ds-form-group">
      <label for="email">Email Address</label>
      <input type="email" id="email" name="email" required
             placeholder="you@example.com" value="${param.email}"/>
    </div>
    <div class="ds-form-group">
      <label for="password">Password</label>
      <input type="password" id="password" name="password" required
             placeholder="••••••••"/>
    </div>
    <button type="submit" class="ds-btn ds-btn-primary ds-btn-full">Login</button>
  </form>

  <p class="ds-auth-switch">
    Don't have an account?
    <a href="${pageContext.request.contextPath}/register">Register here</a>
  </p>
  <p class="ds-auth-hint">
    Demo admin: <strong>admin@deadlyshop.com</strong> / <strong>Admin@123</strong>
  </p>
</div>

</body>
</html>
