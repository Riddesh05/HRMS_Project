<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>

    <title>Change Password</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>

        body{
            background:#f4f6fb;
        }

        .password-card{
            max-width:600px;
            margin:auto;
            margin-top:80px;
            border:none;
            border-radius:15px;
        }

    </style>

</head>

<body>

<div class="container">

    <div class="card shadow password-card">

        <div class="card-body p-4">

            <h3 class="mb-4 text-center">
                Change Password
            </h3>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    ${success}
                </div>
            </c:if>

            <form action="change-password"
                  method="post">

                <div class="mb-3">

                    <label class="form-label">
                        Current Password
                    </label>

                    <input type="password"
                           name="currentPassword"
                           class="form-control"
                           required>

                </div>

                <div class="mb-3">

                    <label class="form-label">
                        New Password
                    </label>

                    <input type="password"
                           name="password"
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

                <div class="alert alert-info">

                    Password must:
                    <ul class="mb-0">
                        <li>Contain at least 8 characters</li>
                        <li>Contain one uppercase letter</li>
                        <li>Contain one digit</li>
                    </ul>

                </div>

                <button type="submit"
                        class="btn btn-primary w-100">

                    Change Password

                </button>

            </form>

        </div>

    </div>

</div>

</body>
</html>