<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="includes/header.jsp" %>

<!DOCTYPE html>
<html>

<head>

    <title>Documents</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>

        body{
            background:linear-gradient(135deg,#eeeaff,#eef6ff);
            font-family:"Segoe UI",sans-serif;
        }

        .card{
            border:0;
            border-radius:18px;
            background:linear-gradient(145deg,#ffffff,#f7f8ff);
            transition:.3s;
        }

        .card:hover{
            transform:translateY(-6px);
            box-shadow:0 15px 30px rgba(70,80,180,.15)!important;
        }

        h2{
            color:#202a4d;
            font-weight:700;
        }

        h4{
            color:#384579;
            font-weight:600;
        }

        .form-label{
            color:#46517d;
            font-weight:600;
        }

        .form-control,
        .form-select{
            border:1px solid #dfe3f2;
            border-radius:10px;
            color:#384579;
        }

        .form-control:focus,
        .form-select:focus{
            border-color:#5145e5;
            box-shadow:0 0 0 3px rgba(81,69,229,.12);
        }

        .btn-primary{
            border:0;
            border-radius:10px;
            background:linear-gradient(90deg,#5145e5,#2869e8);
            transition:.3s;
        }

        .btn-primary:hover{
            transform:translateY(-2px);
            box-shadow:0 8px 18px #4264e855;
        }

        .table thead{
            background:#f1f3ff!important;
        }

        .table thead th{
            color:#46517d;
            font-weight:600;
            border:0;
        }

        .table td{
            color:#667085;
            vertical-align:middle;
        }

        .btn-success{
            border:0;
            border-radius:10px;
            background:#d9f7e8;
            color:#16804b;
        }

        .btn-warning{
            border:0;
            border-radius:10px;
            background:#fff0c2;
            color:#806000;
        }

        .btn-danger{
            border:0;
            border-radius:10px;
            background:#ffe0e0;
            color:#c03939;
        }

        .btn-secondary{
            border:0;
            border-radius:10px;
        }

        .modal-content{
            border:0;
            border-radius:18px;
        }

        .modal-header.bg-danger{
            background:#ffe0e0!important;
            color:#c03939!important;
            border:0;
        }

        .alert{
            border:0;
            border-radius:12px;
        }

    </style>

</head>

<body>

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

                        <c:if test="${loggingemployee.role == 'ADMIN'}">
                            <th>Employee Name</th>
                        </c:if>

                        <th>Document Type</th>
                        <th>File Name</th>
                        <th>Size (KB)</th>
                        <th>Download</th>

                        <c:if test="${loggingemployee.role != 'ADMIN'}">
                            <th>Edit</th>
                            <th>Delete</th>
                        </c:if>

                    </tr>

                </thead>

                <tbody>

                <c:choose>

                    <c:when test="${not empty documents}">

                        <c:forEach items="${documents}" var="doc">

                            <tr>

                                <c:if test="${loggingemployee.role == 'ADMIN'}">
                                    <td>${doc.employeeName}</td>
                                </c:if>

                                <td>${doc.documentType}</td>

                                <td>${doc.fileName}</td>

                                <td>${doc.fileSize / 1024} KB</td>

                                <td>

                                    <a href="download?documentId=${doc.documentId}"
                                       class="btn btn-success btn-sm">
                                        Download
                                    </a>

                                </td>

                                <c:if test="${loggingemployee.role != 'ADMIN'}">

                                    <td>

                                        <a href="editDocument?documentId=${doc.documentId}"
                                           class="btn btn-warning btn-sm">
                                            Edit
                                        </a>

                                    </td>

                                    <td>

                                        <button type="button"
                                                class="btn btn-danger btn-sm"
                                                onclick="showDeleteModal(${doc.documentId})">
                                            Delete
                                        </button>

                                    </td>

                                </c:if>

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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

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

                Are you sure you want to delete this document?

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

function showDeleteModal(documentId)
{
    document.getElementById("deleteBtn").href =
            "deleteDocument?documentId=" + documentId;

    new bootstrap.Modal(
            document.getElementById("deleteModal")
    ).show();
}

</script>

</body>
</html>