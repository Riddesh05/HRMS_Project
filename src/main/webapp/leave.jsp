<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="includes/header.jsp" %>


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
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Leave Management</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>

        body{
            background:#f4f6fb;
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

</head>

<body>



<div class="container mt-5">

    <h2 class="mb-4">

        Leave Management

    </h2>

    <c:if test="${not empty sessionScope.success}">

        <div class="alert alert-success">

            ${sessionScope.success}

        </div>

        <c:remove var="success" scope="session"/>

    </c:if>

    <c:if test="${not empty error}">

        <div class="alert alert-danger">

            ${error}

        </div>

    </c:if>

    <!-- Leave Apply Form -->

    <div class="card shadow mb-4">

        <div class="card-body">

            <h4 class="mb-4">

                Apply Leave

            </h4>

            <form action="leave"
                  method="post">

                <input type="hidden"
                       name="action"
                       value="apply">

                <div class="row">

                    <div class="col-md-4 mb-3">

                        <label class="form-label">

                            Leave Type

                        </label>

                        <select class="form-select"
                                name="leaveType"
                                required>

                            <option value="">Select Leave</option>

                            <option value="SICK">
                                Sick Leave
                            </option>

                            <option value="CASUAL">
                                Casual Leave
                            </option>

                            <option value="PAID">
                                Paid Leave
                            </option>

                            <option value="UNPAID">
                                Unpaid Leave
                            </option>

                            <option value="ANNUAL">
                                Annual Leave
                            </option>

                        </select>

                    </div>

                    <div class="col-md-4 mb-3">

                        <label class="form-label">

                            Start Date

                        </label>

                        <input type="date"
                               class="form-control"
                               id="startDate"
                               name="startDate"
                               required>

                    </div>

                    <div class="col-md-4 mb-3">

                        <label class="form-label">

                            End Date

                        </label>

                        <input type="date"
                               class="form-control"
                               id="endDate"
                               name="endDate"
                               required>

                    </div>

                </div>

                <div class="mb-3">

                    <label class="form-label">

                        Reason

                    </label>

                    <textarea class="form-control"
                              name="reason"
                              rows="4"
                              maxlength="255"
                              required></textarea>

                </div>

                <button class="btn btn-primary">

                    Apply Leave

                </button>

            </form>

        </div>

    </div>

    <!-- Leave History -->

    <div class="card shadow">

        <div class="card-body">

            <h4 class="mb-3">

                Leave History

            </h4>

            <div class="table-responsive">

                <table class="table table-hover">

                    <thead class="table-dark">

                    <tr>

                        <th>Employee</th>

                        <th>Leave Type</th>

                        <th>Start Date</th>

                        <th>End Date</th>

                        <th>Reason</th>

                        <th>Status</th>

                        <c:if test="${sessionScope.loggingemployee.role eq 'ADMIN'}">

                            <th>Action</th>

                        </c:if>

                    </tr>

                    </thead>

                    <tbody>

                    <c:forEach items="${leaveList}"
                               var="leave">

                        <tr>

                            <td>

                                ${leave.employeeName}

                            </td>

                            <td>

                                ${leave.leaveType}

                            </td>

                            <td>

                                ${leave.startDate}

                            </td>

                            <td>

                                ${leave.endDate}

                            </td>

                            <td>

                                ${leave.reason}

                            </td>

                            <td>

                                <c:choose>

                                    <c:when test="${leave.status eq 'APPROVED'}">

                                        <span class="badge bg-success">

                                            Approved

                                        </span>

                                    </c:when>

                                    <c:when test="${leave.status eq 'REJECTED'}">

                                        <span class="badge bg-danger">

                                            Rejected

                                        </span>

                                    </c:when>

                                    <c:otherwise>

                                        <span class="badge bg-warning text-dark">

                                            Pending

                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </td>
<c:if test="${sessionScope.loggingemployee.role eq 'ADMIN'}">

                                                            <td>

                                                                <c:choose>
                                                                    <c:when test="${leave.status eq 'PENDING'}">

                                                                        <!-- Approve -->

                                                                        <form action="leave"
                                                                              method="post"
                                                                              style="display:inline;">

                                                                            <input type="hidden"
                                                                                   name="action"
                                                                                   value="approve">

                                                                            <input type="hidden"
                                                                                   name="leaveId"
                                                                                   value="${leave.leaveId}">

                                                                            <button type="submit"
                                                                                    class="btn btn-success btn-sm">

                                                                                Approve

                                                                            </button>

                                                                        </form>

                                                                        <!-- Reject -->

                                                                        <form action="leave"
                                                                              method="post"
                                                                              style="display:inline;">

                                                                            <input type="hidden"
                                                                                   name="action"
                                                                                   value="reject">

                                                                            <input type="hidden"
                                                                                   name="leaveId"
                                                                                   value="${leave.leaveId}">

                                                                            <button type="submit"
                                                                                    class="btn btn-danger btn-sm">

                                                                                Reject

                                                                            </button>

                                                                        </form>

                                                                    </c:when>

                                                                    <c:otherwise>

                                                                        <span class="text-secondary">

                                                                            -

                                                                        </span>

                                                                    </c:otherwise>

                                                                </c:choose>

                                                            </td>

                                                        </c:if>

                                                    </tr>

                                                </c:forEach>

                                                </tbody>

                                            </table>

                                        </div>

                                    </div>

                                </div>

                            </div>

                            <script>

                                const startDate = document.getElementById("startDate");
                                const endDate = document.getElementById("endDate");

                                const today = new Date();

                                const yyyy = today.getFullYear();

                                const mm = String(today.getMonth() + 1).padStart(2, '0');

                                const dd = String(today.getDate()).padStart(2, '0');

                                const currentDate = yyyy + "-" + mm + "-" + dd;

                                startDate.min = currentDate;

                                endDate.min = currentDate;

                                startDate.addEventListener("change", function () {

                                    endDate.min = this.value;

                                    if (endDate.value < this.value) {

                                        endDate.value = this.value;

                                    }

                                });

                            </script>

                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

                            </body>

                            </html>