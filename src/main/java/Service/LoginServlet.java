package Service;

import DAO.EmployeeDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Employee;

import java.io.IOException;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final EmployeeDAO employeeDAO=new EmployeeDAO();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email=req.getParameter("email");
        String password=req.getParameter("password");

        try {
            Employee employee=employeeDAO.findbyemailpassword(email,password);

          //  req.setAttribute("name",employee.getFullName());
           if (employee==null)
           {
               req.setAttribute("error","invalid login and password");
               req.getRequestDispatcher("login.jsp").forward(req,resp);
               return;
           }
            HttpSession session = req.getSession();
            session.setAttribute("loggingemployee", employee);

            System.out.println("Employee Name = " + employee.getFullName());
            System.out.println("Session Object = " + session.getAttribute("loggingemployee"));

            session.setAttribute("loggingemployee", employee);

            if(!employee.isPasswordChanged()) {
                resp.sendRedirect("dashboard");
                return;
            }
            resp.sendRedirect("dashboard");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
