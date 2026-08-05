package Service;

import DAO.DocumentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Document;

import java.io.*;

@WebServlet("/download")
public class DownloadServlet extends HttpServlet {

    private final DocumentDAO documentDAO = new DocumentDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int documentId =
                    Integer.parseInt(request.getParameter("documentId"));

            Document document =
                    documentDAO.findById(documentId);

            if(document == null){
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            File file = new File(document.getFilePath());

            response.setContentType(document.getFileType());

            response.setHeader(
                    "Content-Disposition",
                    "attachment; filename=\"" +
                            document.getFileName() + "\""
            );

            FileInputStream fis = new FileInputStream(file);

            OutputStream os = response.getOutputStream();

            byte[] buffer = new byte[4096];

            int bytesRead;

            while((bytesRead = fis.read(buffer)) != -1){

                os.write(buffer,0,bytesRead);

            }

            fis.close();
            os.close();

        } catch (Exception e) {

            throw new ServletException(e);

        }
    }
}