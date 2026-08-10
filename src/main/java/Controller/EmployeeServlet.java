package Controller;

import Service.EmployeeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Employee;

import java.io.IOException;
import java.util.List;

@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {
    private final EmployeeService employeeService = new EmployeeService();

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        List<Employee> employeeList = null;
        try {
            employeeList = employeeService.getAllEmployees();
        } catch (Exception e) {
            if ("EMAIL_ALREADY_EXISTS".equals(e.getMessage())) {
                req.getSession().setAttribute("error", "Employee with this email already exists.");
                resp.sendRedirect("employees");
                return;
            }
            throw new RuntimeException(e);
        }
        req.setAttribute("employeeList", employeeList);
        req.getRequestDispatcher("addEmployee.jsp").forward(req, resp);
    }
}