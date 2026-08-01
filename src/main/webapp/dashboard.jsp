<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    if (session.getAttribute("loggingemployee") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow p-4">

        <h2 class="text-success">
            Welcome, ${sessionScope.loggingemployee.fullName}
        </h2>

        <hr>

        <p><strong>Employee ID :</strong> ${sessionScope.loggingemployee.employeeId}</p>
        <p><strong>Email :</strong> ${sessionScope.loggingemployee.email}</p>
        <p><strong>Department :</strong> ${sessionScope.loggingemployee.department}</p>
        <p><strong>Role :</strong> ${sessionScope.loggingemployee.role}</p>

        <hr>

        <c:if test="${sessionScope.loggingemployee.role eq 'ADMIN'}">
            <button class="btn btn-success">Approve</button>
            <button class="btn btn-danger">Reject</button>
        </c:if>

        <c:if test="${sessionScope.loggingemployee.role ne 'ADMIN'}">
            <button class="btn btn-primary">Apply Leave</button>
        </c:if>

        <br><br>

        <a href="logout" class="btn btn-dark">Logout</a>

    </div>

</div>

</body>
</html>