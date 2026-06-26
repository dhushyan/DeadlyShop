<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>404 Not Found — DeadlyShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
  <div class="ds-empty-state" style="padding:120px 20px">
    <p style="font-size:80px">🏍️</p>
    <h1 style="font-size:5rem;color:#e94560">404</h1>
    <h2>Page Not Found</h2>
    <p style="margin:12px 0 28px">Looks like you took a wrong turn, rider.</p>
    <a href="${pageContext.request.contextPath}/home" class="ds-btn ds-btn-primary ds-btn-lg">
      Back to Home
    </a>
  </div>
</body>
</html>
