package Controller;

import Service.EmployeeService;
import Util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Employee;
import model.EmployeeRole;
import model.GmailSender;
import model.PasswordGenerator;

import java.io.IOException;
import java.util.List;

@WebServlet("/addEmployee")
public class AddEmployeeServlet extends HttpServlet {

    private final EmployeeService employeeService=new EmployeeService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String name=req.getParameter("fullName");
        String email=req.getParameter("email");
        //  String password=req.getParameter("password");
        String dept=req.getParameter("department");
        //    String role=req.getParameter("role");


        Employee employee=new Employee();
        employee.setEmail(email);
        employee.setFullName(name);
        employee.setDepartment(dept);
        employee.setRole(EmployeeRole.EMPLOYEE);

        String plainpwd = PasswordGenerator.generatePassword(name);
        employee.setPassword(PasswordUtil.hash(plainpwd));

        try {
            // GmailSender.sendMail(email,"OTP","Your Password is="+plainpwd);
            GmailSender.sendMail(
                    email,
                    "HRMS Account Created",
                    "Dear " + employee.getFullName() + ",\n\n" +
                            "Your HRMS account has been created.\n" +
                            "Temporary Password: " + plainpwd +
                            "\n\nPlease change your password after your first login.\n\nRegards,\nHRMS Team"
            );

            Employee saveEmployee=employeeService.addEmployee(employee);
            if (saveEmployee!=null){
                //  req.setAttribute("success", "Employee Added Successfully.");
                resp.sendRedirect("employees");
            }
            else {
                req.setAttribute("error", "Unable to Add Employee.");
                req.getRequestDispatcher("addEmployee.jsp").forward(req, resp);

            }

        } catch (Exception e) {
            if("EMAIL_ALREADY_EXISTS".equals(e.getMessage())) {
                req.getSession().setAttribute("error", "Employee with this email already exists.");
                resp.sendRedirect("employees");
                return;
            }
            throw new RuntimeException(e);
        }
    }
}