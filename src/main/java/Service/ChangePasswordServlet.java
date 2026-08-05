package Service;


import DAO.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Employee;
import Util.PasswordUtil;


import java.io.IOException;


@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {
    private EmployeeDAO employeeDAO=new EmployeeDAO();

    @Override
    protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
        HttpSession session=request.getSession(false);
        if(session==null){
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("changePassword.jsp")
                .forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
        HttpSession session=request.getSession(false);
        Employee employee=(Employee)session.getAttribute("loggingemployee");
        String password=request.getParameter("password");
        if(!PasswordUtil.isStrongPassword(password)){
            request.setAttribute("error", "Password must contain 8 characters, uppercase and digit");
            request.getRequestDispatcher("changePassword.jsp")
                    .forward(request,response);
            return;
        }
        try{
            EmployeeDAO dao=new EmployeeDAO();
            dao.changePassword(employee.getEmployeeId(),password);
            employee.setPassword_changed(true);
            session.setAttribute("loggingemployee",employee);
            response.sendRedirect("dashboard");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}