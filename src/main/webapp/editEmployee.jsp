<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>

    <title>Edit Employee</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body>

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-body">

            <h3>Edit Employee</h3>

            <form action="editEmployee"
                  method="post">

                <input type="hidden"
                       name="employeeId"
                       value="${employee.employeeId}">

                <div class="mb-3">

                    <label>Full Name</label>

                    <input type="text"
                           name="fullName"
                           value="${employee.fullName}"
                           class="form-control"
                           required>

                </div>

                <div class="mb-3">

                    <label>Email</label>

                    <input type="email"
                           name="email"
                           value="${employee.email}"
                           class="form-control"
                           required>

                </div>

                <div class="mb-3">

                    <label>Department</label>

                    <select name="department"
                            class="form-select">

                        <option value="IT"
                                ${employee.department=='IT'?'selected':''}>
                            IT
                        </option>

                        <option value="HR"
                                ${employee.department=='HR'?'selected':''}>
                            HR
                        </option>

                        <option value="Finance"
                                ${employee.department=='Finance'?'selected':''}>
                            Finance
                        </option>

                    </select>

                </div>

                <button type="submit"
                        class="btn btn-success">

                    Update Employee

                </button>

                <a href="employees"
                   class="btn btn-secondary">

                    Cancel

                </a>

            </form>

        </div>

    </div>

</div>

</body>
</html>