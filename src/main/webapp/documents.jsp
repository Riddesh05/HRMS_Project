<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>

    <title>Documents</title>

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

        .card{
            border:none;
            border-radius:15px;
        }

        .table th{
            font-weight:600;
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

            <a href="dashboard" class="nav-link">
                Dashboard
            </a>

            <a href="leave" class="nav-link">
                Leave
            </a>

            <a href="documents" class="nav-link">
                Documents
            </a>

            <c:if test="${sessionScope.loggingemployee.role eq 'ADMIN'}">

                <a href="employees" class="nav-link">
                    Employees
                </a>

            </c:if>

            <a href="logout" class="nav-link">
                Sign out
            </a>

        </div>

    </div>

</nav>

<div class="container mt-5">

    <h2 class="mb-4">
        My Documents
    </h2>

    <!-- Upload Card -->

    <div class="card shadow">

        <div class="card-body">

            <h4 class="mb-4">
                Upload Document
            </h4>

            <form action="documents"
                  method="post"
                  enctype="multipart/form-data">

                <div class="row">

                    <div class="col-md-4 mb-3">

                        <label class="form-label">
                            Document Type
                        </label>

                        <select
                                name="documentType"
                                class="form-select"
                                required>

                            <option value="">
                                Select Document Type
                            </option>

                            <option value="ADHAAR">
                                Aadhaar Card
                            </option>

                            <option value="PAN">
                                PAN Card
                            </option>

                            <option value="PASSPORT">
                                Passport
                            </option>

                            <option value="RESUME">
                                Resume
                            </option>

                            <option value="OFFER_LETTER">
                                Offer Letter
                            </option>

                            <option value="EXPERIENCE_LETTER">
                                Experience Letter
                            </option>

                            <option value="SALARY_SLIP">
                                Salary Slip
                            </option>

                            <option value="BANK_DOCUMENT">
                                Bank Document
                            </option>

                            <option value="EDUCATION">
                                Education Certificate
                            </option>

                            <option value="OTHER">
                                Other
                            </option>

                        </select>

                    </div>

                    <div class="col-md-8 mb-3">

                        <label class="form-label">
                            Select File
                        </label>

                        <input
                                type="file"
                                name="document"
                                class="form-control"
                                required>

                    </div>

                </div>

                <button type="submit"
                        class="btn btn-primary">
                    Upload
                </button>

            </form>

        </div>

    </div>

    <!-- Documents Table -->

    <div class="card shadow mt-4">

        <div class="card-body">

            <h4 class="mb-3">
                Uploaded Documents
            </h4>

            <table class="table table-hover align-middle">

                <thead>

                <tr>

                    <tr>
                        <th>Document Type</th>
                        <th>File Name</th>
                        <th>Size (KB)</th>
                        <th>Download</th>
                    </tr>


                </tr>

                </thead>

                <tbody>

                <c:choose>

                    <c:when test="${not empty documents}">

                        <c:forEach items="${documents}" var="doc">

                            <tr>

                                <td>${doc.documentType}</td>

                                <td>${doc.fileName}</td>

                                <td>${doc.fileSize / 1024} KB</td>

                                <td>
                                    <a href="download?documentId=${doc.documentId}"
                                       class="btn btn-success btn-sm">
                                        Download
                                    </a>
                                </td>

                            </tr>

                        </c:forEach>

                    </c:when>

                    <c:otherwise>

                        <tr>

                            <td colspan="4"
                                class="text-center text-muted">

                                No documents uploaded yet

                            </td>

                        </tr>

                    </c:otherwise>

                </c:choose>

                </tbody>

            </table>

        </div>

    </div>

</div>

</body>
</html>