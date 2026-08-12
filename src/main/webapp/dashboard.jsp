<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    if(session.getAttribute("loggingemployee")==null){
        response.sendRedirect("dashboard");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<title>HRMS | Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
      rel="stylesheet">

<style>

body{
    background:linear-gradient(135deg,#eeeaff,#eef6ff);
    font-family:"Segoe UI",sans-serif;
}

/* NAVBAR */

.navbar{
    background:linear-gradient(90deg,#4844d8,#3269e8)!important;
    padding:14px 0;
}

.navbar-brand{
    font-weight:700;
    font-size:22px;
}

.nav-link{
    color:#fff!important;
    margin-left:15px;
    transition:.3s;
}

.nav-link:hover{
    opacity:.75;
    transform:translateY(-2px);
}

/* WELCOME */

.welcome{
    animation:show .6s ease;
}

h2{
    color:#202a4d;
    font-weight:700;
}

.welcome p{
    color:#667085;
}

/* DASHBOARD CARDS */

.dashboard-card{
    border:0;
    border-radius:18px;
    background:linear-gradient(145deg,#ffffff,#f7f8ff);
    transition:.3s;
    animation:show .6s ease;
}

.dashboard-card:hover{
    transform:translateY(-6px);
    box-shadow:0 15px 30px rgba(70,80,180,.15)!important;
}

.dashboard-card h4{
    color:#384579;
    font-weight:600;
}

.dashboard-card p{
    color:#667085;
}

/* BUTTON */

.btn-primary{
    border:0;
    border-radius:10px;
    background:linear-gradient(90deg,#5145e5,#2869e8);
    transition:.3s;
}

.btn-primary:hover{
    transform:translateY(-2px);
    box-shadow:0 8px 18px #4264e855;
}

.btn-warning{
    border:0;
    border-radius:10px;
    background:#fff0c2;
    color:#806000;
}

/* RECENT LEAVE */

.recent-card{
    border:0;
    border-radius:18px;
    background:#fff;
}

.recent-card h4{
    color:#384579;
}

.table{
    margin-bottom:0;
}

.table thead{
    background:#f1f3ff;
}

.table th{
    color:#46517d;
    font-weight:600;
}

.table td{
    color:#667085;
    vertical-align:middle;
}

/* STATUS */

.badge{
    font-size:12px;
    padding:7px 11px;
    border-radius:20px;
}

.bg-success{
    background:#d9f7e8!important;
    color:#16804b!important;
}

.bg-danger{
    background:#ffe0e0!important;
    color:#c03939!important;
}

.bg-warning{
    background:#fff0c2!important;
    color:#806000!important;
}

/* ANIMATION */

@keyframes show{
    from{
        opacity:0;
        transform:translateY(20px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

</style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-expand-lg navbar-dark">

<div class="container">

<a class="navbar-brand" href="dashboard">
    <i class="bi bi-people-fill me-2"></i>HRMS
</a>

<div class="navbar-nav ms-auto">

<a href="dashboard" class="nav-link">
    <i class="bi bi-grid me-1"></i> Dashboard
</a>

<a href="leave" class="nav-link">
    <i class="bi bi-calendar-check me-1"></i> Leave
</a>

<a href="documents" class="nav-link">
    <i class="bi bi-file-earmark-text me-1"></i> Documents
</a>

<c:if test="${sessionScope.loggingemployee.role eq 'ADMIN'}">

<a href="employees" class="nav-link">
    <i class="bi bi-people me-1"></i> Employees
</a>

</c:if>

<a href="logout" class="nav-link">
    <i class="bi bi-box-arrow-right me-1"></i> Sign out
</a>

</div>

</div>

</nav>

<!-- MAIN -->

<div class="container mt-5">

<!-- WELCOME -->

<div class="welcome d-flex justify-content-between align-items-center">

<div>

<h2>
    Welcome, ${sessionScope.loggingemployee.fullName} 👋
</h2>

<p class="mb-0">
    ${sessionScope.loggingemployee.department}
    •
    ${sessionScope.loggingemployee.role}
</p>

</div>

<c:if test="${!sessionScope.loggingemployee.password_changed}">

<a href="changePassword" class="btn btn-warning">

    <i class="bi bi-key me-1"></i>
    Change Password

</a>

</c:if>

</div>

<!-- DASHBOARD CARDS -->

<div class="row g-4 mt-3">

<!-- LEAVE -->

<div class="col-md-4">

<div class="card dashboard-card shadow-sm">

<div class="card-body p-4">

<h4>
    <i class="bi bi-calendar-check text-primary me-2"></i>
    Leave
</h4>

<p class="mt-2">
    Submit and track your leave requests.
</p>

<a href="leave" class="btn btn-primary btn-sm">
    Open
</a>

</div>

</div>

</div>

<!-- DOCUMENTS -->

<div class="col-md-4">

<div class="card dashboard-card shadow-sm">

<div class="card-body p-4">

<h4>
    <i class="bi bi-file-earmark-text text-primary me-2"></i>
    Documents
</h4>

<p class="mt-2">
    Upload and manage secure personal files.
</p>

<a href="documents" class="btn btn-primary btn-sm">
    Open
</a>

</div>

</div>

</div>

<!-- EMPLOYEES -->

<c:if test="${sessionScope.loggingemployee.role eq 'ADMIN'}">

<div class="col-md-4">

<div class="card dashboard-card shadow-sm">

<div class="card-body p-4">

<h4>
    <i class="bi bi-people text-primary me-2"></i>
    Employees
</h4>

<p class="mt-2">
    Manage employee accounts and details.
</p>

<a href="employees" class="btn btn-primary btn-sm">
    Open
</a>

</div>

</div>

</div>

</c:if>

<!-- PROFILE -->

<div class="col-md-4">

<div class="card dashboard-card shadow-sm">

<div class="card-body p-4">

<h4>
    <i class="bi bi-person text-primary me-2"></i>
    Profile
</h4>

<p class="mt-2">
    View your personal information.
</p>

<a href="profile" class="btn btn-primary btn-sm">
    Open
</a>

</div>

</div>

</div>

</div>

<!-- RECENT LEAVES -->

<div class="card recent-card shadow-sm mt-5 mb-5">

<div class="card-body p-4">

<h4 class="mb-3">
    <i class="bi bi-clock-history text-primary me-2"></i>
    Recent Leave Requests
</h4>

<div class="table-responsive">

<table class="table table-hover">

<thead>

<tr>
    <th>Employee</th>
    <th>Type</th>
    <th>Dates</th>
    <th>Status</th>
</tr>

</thead>

<tbody>

<c:forEach items="${recentLeaves}" var="leave">

<tr>

<td>${leave.employeeName}</td>

<td>${leave.leaveType}</td>

<td>${leave.startDate} to ${leave.endDate}</td>

<td>

<c:choose>

<c:when test="${leave.status eq 'APPROVED'}">
<span class="badge bg-success">APPROVED</span>
</c:when>

<c:when test="${leave.status eq 'REJECTED'}">
<span class="badge bg-danger">REJECTED</span>
</c:when>

<c:otherwise>
<span class="badge bg-warning text-dark">PENDING</span>
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

</div>

</body>

</html>