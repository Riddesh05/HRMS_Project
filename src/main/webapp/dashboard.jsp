<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    if(session.getAttribute("loggingemployee")==null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">
<style>
body{

background:#f4f6fb;

}

.navbar{

background:#17172b;

}

.navbar-brand{

font-weight:bold;

}

.nav-link{

color:white !important;

margin-left:15px;

}

.dashboard-card{

border:none;

border-radius:15px;

transition:.3s;

}

.dashboard-card:hover{

transform:translateY(-5px);

box-shadow:0 10px 25px rgba(0,0,0,.15);

}

.badge{

font-size:13px;

}

.table td{

vertical-align:middle;

}

</style>

</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark">

<div class="container">

<a class="navbar-brand">

HRMS

</a>

<div class="navbar-nav ms-auto">

<a href="dashboard"
class="nav-link">

Dashboard

</a>

<a href="leave"
class="nav-link">

Leave

</a>

<a href="documents"
class="nav-link">

Documents

</a>

<c:if test="${sessionScope.loggingemployee.role eq 'ADMIN'}">

<a href="employees"
class="nav-link">

Employees

</a>

</c:if>

<a href="logout"
class="nav-link">

Sign out

</a>

</div>

</div>

</nav>

<div class="container mt-5">

    <div class="d-flex justify-content-between align-items-center">

        <div>

            <h2>
                Welcome, ${sessionScope.loggingemployee.fullName}
            </h2>

            <p class="text-secondary mb-0">
                ${sessionScope.loggingemployee.department}
                •
                ${sessionScope.loggingemployee.role}
            </p>

        </div>

        <c:if test="${!sessionScope.loggingemployee.password_changed}">
            <a href="changePassword"
               class="btn btn-warning">
                Change Password
            </a>
        </c:if>

    </div>

    <div class="row mt-4">

<div class="col-md-4">

<div class="card dashboard-card shadow-sm">

<div class="card-body">

<h4>

Leave

</h4>

<p>

Submit and track requests.

</p>

<a href="leave"
class="btn btn-primary btn-sm">

Open

</a>

</div>

</div>

</div>

<div class="col-md-4">

<div class="card dashboard-card shadow-sm">

<div class="card-body">

<h4>

Documents

</h4>

<p>

Upload secure personal files.

</p>

<a href="documents"
class="btn btn-primary btn-sm">

Open

</a>

</div>

</div>

</div>

<c:if test="${sessionScope.loggingemployee.role eq 'ADMIN'}">

<div class="col-md-4">

<div class="card dashboard-card shadow-sm">

<div class="card-body">

<h4>

Employees

</h4>

<p>

Manage employee accounts.

</p>

<a href="employees"
class="btn btn-primary btn-sm">

Open

</a>

</div>

</div>

</div>

</c:if>



<div class="col-md-4">

    <div class="card dashboard-card shadow-sm">

        <div class="card-body">

            <h4>Profile</h4>

            <p>
                View your personal information.
            </p>

            <a href="profile"
               class="btn btn-primary btn-sm">
                Open
            </a>

        </div>

    </div>

</div>
</div>
    </div>

<div class="card shadow mt-5">

<div class="card-body">

<h4 class="mb-3">

Recent Leave Requests

</h4>

<table class="table table-hover">

<thead>

<tr>

<th>

Employee

</th>

<th>

Type

</th>

<th>

Dates

</th>

<th>

Status

</th>

</tr>

</thead>

<tbody>

<c:forEach items="${recentLeaves}" var="leave">

<tr>

<td>

${leave.employeeName}

</td>

<td>

${leave.leaveType}

</td>

<td>

${leave.startDate}

to

${leave.endDate}

</td>

<td>

<c:choose>

<c:when test="${leave.status eq 'APPROVED'}">

<span class="badge bg-success">

APPROVED

</span>

</c:when>

<c:when test="${leave.status eq 'REJECTED'}">

<span class="badge bg-danger">

REJECTED

</span>

</c:when>

<c:otherwise>

<span class="badge bg-warning text-dark">

PENDING

</span>

</c:otherwise>

</c:choose>

</td>

</tr>

</c:forEach>

</tbody>

</table>

</div>

</div>

</div>

</body>

</html>