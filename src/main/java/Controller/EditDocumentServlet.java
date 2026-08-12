package Controller;

import DAO.DocumentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Document;

import java.io.File;
import java.io.IOException;

@WebServlet("/editDocument")
@MultipartConfig
public class EditDocumentServlet extends HttpServlet {
    private DocumentDAO documentDAO=new DocumentDAO();

    @Override
    protected void doGet(HttpServletRequest req,HttpServletResponse resp)throws ServletException, IOException {
        int documentId=Integer.parseInt(req.getParameter("documentId"));
        try {
            Document document=documentDAO.findById(documentId);
            req.setAttribute("document", document);
            req.getRequestDispatcher("editDocument.jsp").forward(req, resp);

        } catch (Exception e){
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req,HttpServletResponse resp)throws ServletException, IOException {
        try {
            int documentId=Integer.parseInt(req.getParameter("documentId"));
            String documentType=req.getParameter("documentType");
            Document oldDocument=documentDAO.findById(documentId);
            if(oldDocument == null){
                resp.sendRedirect("documents");
                return;
            }

            Part filePart=req.getPart("document");

            if(filePart==null||filePart.getSize() ==0){
                oldDocument.setDocumentType(documentType);
                documentDAO.update(oldDocument);
                resp.sendRedirect("documents");
                return;
            }

            File oldFile =new File(oldDocument.getFilePath());
            if(oldFile.exists()){
                oldFile.delete();
            }

            String fileName=filePart.getSubmittedFileName();
            String uploadPath=getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadPath);

            if(!uploadDir.exists()){
                uploadDir.mkdirs();
            }
            String filePath=uploadPath+File.separator+fileName;
            filePart.write(filePath);
            Document document=new Document();

            document.setDocumentId(documentId);
            document.setDocumentType(documentType);
            document.setFileName(fileName);
            document.setFilePath(filePath);
            document.setFileType(filePart.getContentType());
            document.setFileSize(filePart.getSize());

            documentDAO.update(document);
            resp.sendRedirect("documents");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}