package Controller;

import Service.EmployeeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteEmployee")
public class DeleteEmployeeServlet extends HttpServlet {
    private final EmployeeService employeeService=new EmployeeService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int id= Integer.parseInt(req.getParameter("id"));

        try {
            employeeService.deleteEmployee(id);
            resp.sendRedirect("employees");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
