<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="admin_header.jsp" %>

<div class="ds-admin-content">
  <h1 class="ds-admin-title">Customers</h1>

  <c:if test="${not empty param.msg}">
    <div class="ds-alert ds-alert-success">User deleted successfully.</div>
  </c:if>

  <div class="ds-admin-table-wrap">
    <table class="ds-admin-table">
      <thead>
        <tr>
          <th>ID</th><th>Name</th><th>Email</th>
          <th>Mobile</th><th>Joined</th><th>Action</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="user" items="${users}">
          <tr>
            <td>${user.id}</td>
            <td>${user.name}</td>
            <td>${user.email}</td>
            <td>${user.mobile}</td>
            <td><fmt:formatDate value="${user.createdAt}" pattern="dd MMM yyyy"/></td>
            <td>
              <a href="${pageContext.request.contextPath}/admin/users/delete?id=${user.id}"
                 class="ds-btn ds-btn-sm ds-btn-danger"
                 onclick="return confirm('Delete user ${user.name}?')">Delete</a>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty users}">
          <tr><td colspan="6" style="text-align:center">No customers yet.</td></tr>
        </c:if>
      </tbody>
    </table>
  </div>
</div>

<%@ include file="admin_footer.jsp" %>
