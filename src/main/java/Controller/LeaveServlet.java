package Controller;

import DAO.LeaveDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/leave")
public class LeaveServlet extends HttpServlet {

    private final LeaveDAO leaveDAO = new LeaveDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggingemployee") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Employee employee = (Employee) session.getAttribute("loggingemployee");

        try {
            List<LeaveRequest> leaveList;

            if (employee.getRole() == EmployeeRole.ADMIN) {

                leaveList = leaveDAO.findAll();

            } else {

                leaveList = leaveDAO.findByEmployee(employee.getEmployeeId());

            }

            request.setAttribute("leaveList", leaveList);

            request.getRequestDispatcher("leave.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggingemployee") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Employee employee =
                (Employee) session.getAttribute("loggingemployee");

        String action = request.getParameter("action");


        try {
            switch (action) {

                case "apply":
                    LeaveRequest leave = new LeaveRequest();

                    leave.setEmployeeId(employee.getEmployeeId());

                    leave.setLeaveType(
                            LeaveType.valueOf(request.getParameter("leaveType"))
                    );

                    leave.setStartDate(
                            Date.valueOf(request.getParameter("startDate"))
                    );

                    leave.setEndDate(
                            Date.valueOf(request.getParameter("endDate"))
                    );

                    leave.setReason(
                            request.getParameter("reason")
                    );

                    leave.setStatus(LeaveStatus.PENDING);

                    if (leave.getStartDate().after(leave.getEndDate())) {

                        request.setAttribute(
                                "error",
                                "Start Date cannot be after End Date."
                        );

                        doGet(request, response);

                        return;
                    }

                    leaveDAO.create(leave);

                    session.setAttribute(
                            "success",
                            "Leave request submitted successfully."
                    );

                    break;
                case "approve":

                    if (employee.getRole() == EmployeeRole.ADMIN) {

                        int leaveId =
                                Integer.parseInt(request.getParameter("leaveId"));

                        leaveDAO.approve(leaveId);

                        session.setAttribute(
                                "success",
                                "Leave approved successfully."
                        );
                    }

                    break;

                case "reject":

                    if (employee.getRole() == EmployeeRole.ADMIN) {

                        int leaveId =
                                Integer.parseInt(request.getParameter("leaveId"));

                        leaveDAO.reject(leaveId);

                        session.setAttribute(
                                "success",
                                "Leave rejected successfully."
                        );
                    }

                    break;

                default:

                    session.setAttribute(
                            "error",
                            "Invalid request."
                    );
            }

            response.sendRedirect("leave");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
