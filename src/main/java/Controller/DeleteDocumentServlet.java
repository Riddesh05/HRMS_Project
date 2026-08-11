package Controller;

import DAO.DocumentDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Document;

import java.io.File;
import java.io.IOException;

@WebServlet("/deleteDocument")
public class DeleteDocumentServlet extends HttpServlet {

    private final DocumentDAO documentDAO = new DocumentDAO();

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws IOException {

        try {

            int documentId =
                    Integer.parseInt(req.getParameter("documentId"));

            Document document =
                    documentDAO.findById(documentId);

            if(document != null){

                File file =
                        new File(document.getFilePath());

                if(file.exists()){
                    file.delete();
                }

                documentDAO.delete(documentId);
            }

            resp.sendRedirect("documents");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}