<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employees</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header">
            <h3>Employees</h3>
        </div>

        <div class="card-body">

            <h4 class="mb-4">Add Employee</h4>

            <c:if test="${success != null}">
                <div class="alert alert-success">
                    ${success}<br>
                </div>
            </c:if>

            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show">

                    ${sessionScope.error}

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="alert">
                    </button>

                </div>

                <c:remove var="error" scope="session"/>

            </c:if>

            <form action="addEmployee" method="post">

                <div class="row">

                    <div class="col-md-4 mb-3">

                        <label class="form-label">Full Name</label>

                        <input type="text"
                              name="fullName"
                               class="form-control"
                               required>

                    </div>

                    <div class="col-md-4 mb-3">

                        <label class="form-label">Work Email</label>

                        <input type="email"
                               name="email"
                               class="form-control"
                               required>

                    </div>

                    <div class="col-md-4 mb-3">

                        <label class="form-label">Department</label>

                        <select name="department" class="form-select" required>

                            <option value="">Select Department</option>
                            <option value="IT">IT</option>
                            <option value="HR">HR</option>
                            <option value="Finance">Finance</option>
                            <option value="People Operations">People Operations</option>

                        </select>

                    </div>

                </div>

                <button type="submit" class="btn btn-primary">
                    Add Employee
                </button>

            </form>
            <div class="card shadow mt-4">

                <div class="card-body">

                    <h4 class="mb-3">
                        Employee List
                    </h4>

                    <div class="table-responsive">

                        <table class="table table-hover">

                            <thead class="table-dark">

                            <tr>

                                <th>Name</th>
                                <th>Email</th>
                                <th>Department</th>
                                <th>Role</th>
                                <th>Action</th>

                            </tr>

                            </thead>

                            <tbody>

                            <c:forEach items="${employeeList}" var="employee">

                                <tr>

                                    <td>${employee.fullName}</td>

                                    <td>${employee.email}</td>

                                    <td>${employee.department}</td>

                                    <td>${employee.role}</td>

                                    <td>

                                        <a href="editEmployee?id=${employee.employeeId}"
                                           class="btn btn-warning btn-sm">
                                            Edit
                                        </a>

                                        <button type="button"
                                                class="btn btn-danger btn-sm"
                                                onclick="showDeleteModal(${employee.employeeId})">

                                            Delete

                                        </button>

                                    </td>

                                </tr>

                            </c:forEach>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>
<!-- Delete Confirmation Modal -->
<div class="modal fade"
     id="deleteModal"
     tabindex="-1">

    <div class="modal-dialog modal-dialog-centered">

        <div class="modal-content">

            <div class="modal-header bg-danger text-white">

                <h5 class="modal-title">
                    Confirm Delete
                </h5>

                <button type="button"
                        class="btn-close btn-close-white"
                        data-bs-dismiss="modal">
                </button>

            </div>

            <div class="modal-body">

                Are you sure you want to delete this employee?

            </div>

            <div class="modal-footer">

                <button type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal">

                    Cancel

                </button>

                <a id="deleteBtn"
                   href="#"
                   class="btn btn-danger">

                    Delete

                </a>

            </div>

        </div>

    </div>

</div>

<script>

function showDeleteModal(employeeId)
{
    document.getElementById("deleteBtn").href =
        "deleteEmployee?id=" + employeeId;

    new bootstrap.Modal(
        document.getElementById("deleteModal")
    ).show();
}

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>