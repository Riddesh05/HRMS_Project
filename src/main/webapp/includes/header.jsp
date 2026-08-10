<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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

.card{
    border:none;
    border-radius:15px;
}

.table td{
    vertical-align:middle;
}

textarea{
    resize:none;
}

.badge{
    font-size:13px;
}

</style>

<nav class="navbar navbar-expand-lg navbar-dark">

    <div class="container">

        <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
            HRMS
        </a>

        <div class="navbar-nav ms-auto">

            <a href="dashboard" class="nav-link">Dashboard</a>

            <a href="leave" class="nav-link">Leave</a>

            <a href="documents" class="nav-link">Documents</a>

            <c:if test="${sessionScope.loggingemployee.role eq 'ADMIN'}">
                <a href="employees" class="nav-link">Employees</a>
            </c:if>

            <a href="logout" class="nav-link">Logout</a>

        </div>

    </div>

</nav>