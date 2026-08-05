<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body{
            background:#f4f6fb;
        }

        .navbar{
            background:#17172b;
        }

        .nav-link{
            color:white !important;
            margin-left:15px;
        }

        .profile-card{
            border:none;
            border-radius:15px;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark">

    <div class="container">

        <a class="navbar-brand fw-bold">
            HRMS
        </a>

        <div class="navbar-nav ms-auto">

            <a href="dashboard" class="nav-link">Dashboard</a>
            <a href="leave" class="nav-link">Leave</a>
            <a href="documents" class="nav-link">Documents</a>
            <a href="profile" class="nav-link">Profile</a>
            <a href="logout" class="nav-link">Sign Out</a>

        </div>

    </div>

</nav>

<div class="container mt-5">

    <h2>My Profile</h2>

    <div class="card profile-card shadow mt-4">

        <div class="card-body">

            <table class="table">

                <tr>
                    <th>Employee ID</th>
                    <td>${employee.employeeId}</td>
                </tr>

                <tr>
                    <th>Name</th>
                    <td>${employee.fullName}</td>
                </tr>

                <tr>
                    <th>Email</th>
                    <td>${employee.email}</td>
                </tr>

                <tr>
                    <th>Department</th>
                    <td>${employee.department}</td>
                </tr>

                <tr>
                    <th>Role</th>
                    <td>${employee.role}</td>
                </tr>

            </table>

        </div>

    </div>

</div>

</body>
</html>