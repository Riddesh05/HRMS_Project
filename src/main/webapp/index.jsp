<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Login</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body{
            background-color:#f8f9fa;
        }
        .login-card{
            width:400px;
            border-radius:15px;
        }
    </style>
</head>
<body>

<div class="container vh-100 d-flex justify-content-center align-items-center">

    <div class="card shadow login-card p-4">

        <h2 class="text-center mb-4">Employee Login</h2>


        <form action="login" method="post">

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email"
                       name="email"
                       class="form-control"
                       placeholder="Enter Email"
                       required>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password"
                       name="password"
                       class="form-control"
                       placeholder="Enter Password"
                       required>
            </div>
<c:if test="${not empty error}">
    <div class="alert alert-danger">
        ${error}
    </div>
</c:if>
            <button type="submit" class="btn btn-primary w-100">
                Login
            </button>

        </form>

    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>