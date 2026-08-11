package Controller;

import DAO.DocumentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.FileOutputStream;
import java.io.File;

import model.Document;
import model.Employee;

import java.io.IOException;
import java.util.List;

@WebServlet("/documents")
@MultipartConfig
public class DocumentServlet extends HttpServlet {
    private final DocumentDAO documentDAO=new DocumentDAO();

    @Override
    protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
        HttpSession session=request.getSession(false);
        if(session==null||session.getAttribute("loggingemployee")==null)
        {
            response.sendRedirect("login.jsp");
            return;
        }
        Employee employee=(Employee) session.getAttribute("loggingemployee");

        try {
            List<Document> documents;
            if(employee.getRole().name().equals("ADMIN")) {
                documents=documentDAO.findAll();
            } else {
                documents=documentDAO.findByEmployee(employee.getEmployeeId());
            }
            request.setAttribute("documents",documents);
            request.getRequestDispatcher("documents.jsp").forward(request,response);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
        HttpSession session=request.getSession(false);
        Employee employee=(Employee) session.getAttribute("loggingemployee");

        try {
            String documentType=request.getParameter("documentType");
            Part filePart=request.getPart("document");
            String fileName=filePart.getSubmittedFileName();
            String uploadPath="C:\\Shreya\\hrms\\src\\main\\webapp\\uploads";

            OutputStream outputStream=null;
            InputStream inputStream=null;

            try {
                outputStream=new FileOutputStream(uploadPath+File.separator+fileName);
                inputStream=filePart.getInputStream();

                int read;
                byte[] buffer=new byte[1024];
                while ((read=inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer,0,read);
                }

            } finally {
                if (inputStream!=null) {
                    inputStream.close();
                }
                if (outputStream!=null) {
                    outputStream.close();
                }
            }
            String filePath=uploadPath+File.separator+fileName;
            Document document=new Document();
            document.setEmployeeId(employee.getEmployeeId());
            document.setDocumentType(documentType);
            document.setFileName(fileName);
            document.setFilePath(filePath);
            document.setFileType(filePart.getContentType());
            document.setFileSize(filePart.getSize());

            documentDAO.save(document);
            response.sendRedirect("documents");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}