<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="includes/header.jsp" %>

<%@ page import="model.Employee" %>

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

    <style>

        .dashboard-card{

            transition:.3s;

        }

        .dashboard-card:hover{

            transform:translateY(-5px);

            box-shadow:0 10px 25px rgba(0,0,0,.15);

        }

    </style>

</head>

<body>


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

                    <h4>Leave</h4>

                    <p>Submit and track requests.</p>

                    <a href="leave" class="btn btn-primary btn-sm">
                        Open
                    </a>

                </div>

            </div>

        </div>

        <div class="col-md-4">

            <div class="card dashboard-card shadow-sm">

                <div class="card-body">

                    <h4>Documents</h4>

                    <p>Upload secure personal files.</p>

                    <a href="documents" class="btn btn-primary btn-sm">
                        Open
                    </a>

                </div>

            </div>

        </div>

        <c:if test="${sessionScope.loggingemployee.role eq 'ADMIN'}">

            <div class="col-md-4">

                <div class="card dashboard-card shadow-sm">

                    <div class="card-body">

                        <h4>Employees</h4>

                        <p>Manage employee accounts.</p>

                        <a href="employees"
                           class="btn btn-primary btn-sm">

                            Open

                        </a>

                    </div>

                </div>

            </div>

        </c:if>

    </div>

    <div class="card shadow mt-5">

        <div class="card-body">

            <h4 class="mb-3">

                Recent Leave Requests

            </h4>

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