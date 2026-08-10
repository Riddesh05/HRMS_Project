<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="includes/header.jsp" %>


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

        .profile-card{
            border:none;
            border-radius:15px;
        }
    </style>
</head>

<body>


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