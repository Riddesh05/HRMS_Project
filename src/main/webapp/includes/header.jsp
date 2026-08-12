<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">


    <style>

        /* =========================
           HEADER / NAVBAR
           ========================= */

        .navbar {
            background: linear-gradient(90deg, #4844d8, #3269e8) !important;
            padding: 20px 0;
        }

        /* HRMS LOGO */

        .navbar-brand {
            font-weight: 700;
            font-size: 22px;
            color: #ffffff !important;
        }

        /* MENU */

        .nav-link {
            color: #ffffff !important;
            margin-left: 15px;
            transition: 0.3s;
        }

        /* MENU HOVER */

        .nav-link:hover {
            opacity: 0.75;
            transform: translateY(-2px);
        }

    </style>

</head>


<body>


<!-- =========================
     NAVBAR
     ========================= -->

<nav class="navbar navbar-expand-lg navbar-dark">

    <div class="container">


        <!-- HRMS LOGO -->

        <a class="navbar-brand" href="dashboard">

            <i class="bi bi-people-fill me-2"></i>

            HRMS

        </a>


        <!-- NAVIGATION -->

        <div class="navbar-nav ms-auto">


            <!-- DASHBOARD -->

            <a href="dashboard" class="nav-link">

                <i class="bi bi-grid me-1"></i>

                Dashboard

            </a>


            <!-- LEAVE -->

            <a href="leave" class="nav-link">

                <i class="bi bi-calendar-check me-1"></i>

                Leave

            </a>


            <!-- DOCUMENTS -->

            <a href="documents" class="nav-link">

                <i class="bi bi-file-earmark-text me-1"></i>

                Documents

            </a>


            <!-- EMPLOYEES
                 ONLY ADMIN -->

            <c:if test="${sessionScope.loggingemployee.role eq 'ADMIN'}">

                <a href="employees" class="nav-link">

                    <i class="bi bi-people me-1"></i>

                    Employees

                </a>

            </c:if>


            <!-- SIGN OUT -->

            <a href="logout" class="nav-link">

                <i class="bi bi-box-arrow-right me-1"></i>

                Sign out

            </a>


        </div>

    </div>

</nav>