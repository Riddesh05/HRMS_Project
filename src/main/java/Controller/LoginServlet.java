package Controller;

import DAO.EmployeeDAO;
import Service.EmployeeService;
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
   // private final EmployeeDAO employeeDAO=new EmployeeDAO();

    private final EmployeeService employeeService=new EmployeeService();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email=req.getParameter("email");
        String password=req.getParameter("password");

        try {
            Employee employee=employeeService.login(email,password);

            //req.setAttribute("name",employee.getFullName());
           if (employee==null)
           {
               req.setAttribute("error","Invalid login and password");
               req.getRequestDispatcher("index.jsp").forward(req,resp);
               return;
           }
            HttpSession session = req.getSession();
            session.setAttribute("loggingemployee", employee);
//            if (!employee.getPassword_changed()){
//                resp.sendRedirect("changePassword.jsp");
//                return;
//            }

            System.out.println("Employee Name = " + employee.getFullName());
            System.out.println("Session Object = " + session.getAttribute("loggingemployee"));

            resp.sendRedirect("dashboard");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
