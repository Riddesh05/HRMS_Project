package Controller;

import DAO.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Employee;

import java.io.IOException;

@WebServlet("/editEmployee")
public class EditEmployeeServlet extends HttpServlet {

    private EmployeeDAO employeeDAO = new EmployeeDAO();

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        try {

            Employee employee = employeeDAO.findById(id);

            req.setAttribute("employee", employee);

            req.getRequestDispatcher("editEmployee.jsp")
                    .forward(req, resp);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            int employeeId =
                    Integer.parseInt(req.getParameter("employeeId"));

            Employee employee =
                    employeeDAO.findById(employeeId);

            employee.setFullName(
                    req.getParameter("fullName")
            );

            employee.setEmail(
                    req.getParameter("email")
            );

            employee.setDepartment(
                    req.getParameter("department")
            );

            employeeDAO.update(employee);

            resp.sendRedirect("employees");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}