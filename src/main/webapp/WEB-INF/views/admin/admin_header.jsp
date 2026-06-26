<%@ page language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin — DeadlyShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
</head>
<body class="ds-admin-body">

<nav class="ds-admin-nav">
  <div class="ds-admin-nav-brand">
    <a href="${pageContext.request.contextPath}/admin/dashboard">
      DEADLY<span>SHOP</span> <small>Admin</small>
    </a>
  </div>
  <div class="ds-admin-nav-links">
    <a href="${pageContext.request.contextPath}/admin/dashboard">&#128202; Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/products">&#127955; Products</a>
    <a href="${pageContext.request.contextPath}/admin/orders">&#128230; Orders</a>
    <a href="${pageContext.request.contextPath}/admin/users">&#128100; Users</a>
    <a href="${pageContext.request.contextPath}/logout" class="ds-admin-logout">&#128682; Logout</a>
  </div>
</nav>

<div class="ds-admin-layout">
