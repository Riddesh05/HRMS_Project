package Controller;

import DAO.LeaveDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.*;
import model.Employee;
import model.EmployeeRole;
import model.LeaveRequest;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private LeaveDAO leaveDAO = new LeaveDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Dashboard Servlet Called");

        HttpSession session=request.getSession(false);

        if(session==null || session.getAttribute("loggingemployee")==null){

            response.sendRedirect("login.jsp");

            return;

        }
        Employee employee = (Employee) session.getAttribute("loggingemployee");

        try{

            List<LeaveRequest> leaveList;

            if (employee.getRole() == EmployeeRole.ADMIN) {

                leaveList = leaveDAO.findAll();

            } else {

                leaveList = leaveDAO.findByEmployee(employee.getEmployeeId());

            }
            System.out.println("Total Leaves = " + leaveList.size());


            request.setAttribute(
                    "recentLeaves",
                    leaveList
            );

            request.getRequestDispatcher("dashboard.jsp")
                    .forward(request,response);

        }catch(Exception e){

            throw new ServletException(e);

        }

    }
}
