<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Register — DeadlyShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body class="ds-auth-page">

<div class="ds-auth-container">
  <div class="ds-auth-brand">
    <a href="${pageContext.request.contextPath}/home" class="ds-logo">
      DEADLY<span>SHOP</span>
    </a>
    <h2>Join the Riders' Club</h2>
    <p>Create your free account today</p>
  </div>

  <% if (request.getAttribute("error") != null) { %>
    <div class="ds-alert ds-alert-error">${error}</div>
  <% } %>

  <form class="ds-auth-form" action="${pageContext.request.contextPath}/register"
        method="post" onsubmit="return validateRegister(this)">
    <div class="ds-form-group">
      <label for="name">Full Name</label>
      <input type="text" id="name" name="name" required
             placeholder="Raj Kumar" value="${param.name}"/>
    </div>
    <div class="ds-form-group">
      <label for="email">Email Address</label>
      <input type="email" id="email" name="email" required
             placeholder="you@example.com" value="${param.email}"/>
    </div>
    <div class="ds-form-group">
      <label for="mobile">Mobile Number</label>
      <input type="tel" id="mobile" name="mobile" pattern="[6-9][0-9]{9}"
             placeholder="9876543210" value="${param.mobile}"/>
    </div>
    <div class="ds-form-group">
      <label for="password">Password</label>
      <input type="password" id="password" name="password" required
             placeholder="Min 6 characters" minlength="6"/>
    </div>
    <div class="ds-form-group">
      <label for="confirm">Confirm Password</label>
      <input type="password" id="confirm" name="confirm" required
             placeholder="Re-enter password"/>
    </div>
    <button type="submit" class="ds-btn ds-btn-primary ds-btn-full">Create Account</button>
  </form>

  <p class="ds-auth-switch">
    Already have an account?
    <a href="${pageContext.request.contextPath}/login">Login here</a>
  </p>
</div>

<script>
function validateRegister(form) {
  if (form.password.value !== form.confirm.value) {
    alert('Passwords do not match.');
    return false;
  }
  if (form.password.value.length < 6) {
    alert('Password must be at least 6 characters.');
    return false;
  }
  return true;
}
</script>
</body>
</html>
