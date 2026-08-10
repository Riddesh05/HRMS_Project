<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Employee" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>



<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Change Password</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-5">

            <div class="card shadow">

                <div class="card-header bg-warning">

                    <h4 class="mb-0">
                        Change Password
                    </h4>

                </div>

                <div class="card-body">

                    <p class="text-muted">
                        You are using a temporary password. Please change it. This can be done only once.
                    </p>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                            ${error}
                        </div>
                    </c:if>

                    <form action="changePassword" method="post">

                        <div class="mb-3">

                            <label class="form-label">
                                New Password
                            </label>

                            <input type="password"
                                   name="newPassword"
                                   class="form-control"
                                   required>

                        </div>

                        <div class="mb-3">

                            <label class="form-label">
                                Confirm Password
                            </label>

                            <input type="password"
                                   name="confirmPassword"
                                   class="form-control"
                                   required>

                        </div>

                        <button type="submit"
                                class="btn btn-primary w-100">

                            Change Password

                        </button>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>