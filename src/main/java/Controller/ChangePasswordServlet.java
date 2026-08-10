package Controller;

import Service.EmployeeService;
import Util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Employee;

import java.io.IOException;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {

    private EmployeeService employeeService = new EmployeeService();

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("loggingemployee") == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        Employee employee = (Employee) session.getAttribute("loggingemployee");

        if (employee.getPassword_changed()) {
            resp.sendRedirect("dashboard");
            return;
        }

        req.getRequestDispatcher("changePassword.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        Employee employee = (Employee) session.getAttribute("loggingemployee");

        if (employee == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        if (employee.getPassword_changed()) {
            resp.sendRedirect("dashboard");
            return;
        }

        String newpassword = req.getParameter("newPassword");
        String confirmpassword = req.getParameter("confirmPassword");

        if (!PasswordUtil.isStrongPassword(newpassword)) {
            req.setAttribute("error", "Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number and one special character.");
            req.getRequestDispatcher("changePassword.jsp").forward(req, resp);
            return;
        }
        if (!newpassword.equals(confirmpassword)) {
            req.setAttribute("error", "Passwords do not match.");
            req.getRequestDispatcher("changePassword.jsp").forward(req, resp);
            return;
        }

        try {

            boolean updated = employeeService.updatePassword(
                    employee.getEmployeeId(),
                    newpassword
            );

            if (updated) {

                employee.setPassword(newpassword);
                employee.setPassword_changed(true);

                //session.setAttribute("loggingemployee", employee);

                resp.sendRedirect("dashboard");

            } else {

                req.setAttribute("error", "Password update failed.");
                req.getRequestDispatcher("changePassword.jsp").forward(req, resp);

            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}