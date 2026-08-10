package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Employee;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
        HttpSession session=request.getSession(false);
        if(session==null||session.getAttribute("loggingemployee") == null)
        {
            response.sendRedirect("login");
            return;
        }
        Employee employee=(Employee) session.getAttribute("loggingemployee");
        request.setAttribute("employee",employee);
        request.getRequestDispatcher("profile.jsp").forward(request,response);
    }
}