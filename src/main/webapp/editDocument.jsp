<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Document</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body{
            background:#f4f6fb;
        }

        .card{
            border:none;
            border-radius:15px;
        }

        .form-label{
            font-weight:500;
        }

        .current-file{
            background:#f8f9fa;
            padding:10px;
            border-radius:8px;
            border:1px solid #dee2e6;
        }
    </style>
</head>

<body>

<div class="container">

    <div class="row justify-content-center mt-5">

        <div class="col-lg-8">

            <div class="card shadow">

                <div class="card-body p-4">

                    <h3 class="mb-4">
                        Edit Document
                    </h3>

                    <form action="editDocument"
                          method="post"
                          enctype="multipart/form-data">

                        <input type="hidden"
                               name="documentId"
                               value="${document.documentId}">

                        <div class="mb-3">

                            <label class="form-label">
                                Document Type
                            </label>

                            <select name="documentType"
                                    class="form-select"
                                    required>

                                <option value="ADHAAR"
                                    ${document.documentType=='ADHAAR'?'selected':''}>
                                    Aadhaar Card
                                </option>

                                <option value="PAN"
                                    ${document.documentType=='PAN'?'selected':''}>
                                    PAN Card
                                </option>

                                <option value="PASSPORT"
                                    ${document.documentType=='PASSPORT'?'selected':''}>
                                    Passport
                                </option>

                                <option value="RESUME"
                                    ${document.documentType=='RESUME'?'selected':''}>
                                    Resume
                                </option>

                                <option value="OFFER_LETTER"
                                    ${document.documentType=='OFFER_LETTER'?'selected':''}>
                                    Offer Letter
                                </option>

                                <option value="EXPERIENCE_LETTER"
                                    ${document.documentType=='EXPERIENCE_LETTER'?'selected':''}>
                                    Experience Letter
                                </option>

                                <option value="SALARY_SLIP"
                                    ${document.documentType=='SALARY_SLIP'?'selected':''}>
                                    Salary Slip
                                </option>

                                <option value="BANK_DOCUMENT"
                                    ${document.documentType=='BANK_DOCUMENT'?'selected':''}>
                                    Bank Document
                                </option>

                                <option value="EDUCATION"
                                    ${document.documentType=='EDUCATION'?'selected':''}>
                                    Education Certificate
                                </option>

                                <option value="OTHER"
                                    ${document.documentType=='OTHER'?'selected':''}>
                                    Other
                                </option>

                            </select>

                        </div>

                        <div class="mb-3">

                            <label class="form-label">
                                Current File
                            </label>

                            <div class="current-file">
                                ${document.fileName}
                            </div>

                        </div>

                        <div class="mb-4">

                            <label class="form-label">
                                Upload New File (Optional)
                            </label>

                            <input type="file"
                                   name="document"
                                   class="form-control">

                            <small class="text-muted">
                                Leave empty if you only want to change document type.
                            </small>

                        </div>

                        <div class="d-flex gap-2">

                            <button type="submit"
                                    class="btn btn-primary">
                                Update Document
                            </button>

                            <a href="documents"
                               class="btn btn-secondary">
                                Cancel
                            </a>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>