package DAO;

import Connectionss.DBConnections;
import model.LeaveRequest;
import model.LeaveStatus;
import model.LeaveType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LeaveDAO {

    public LeaveRequest create(LeaveRequest leaveRequest) throws Exception {
        String sql = "insert into leave_requests(employee_id,leave_type,start_date,end_date,reason,status) values(?,?,?,?,?,?)";
        try (Connection connection = DBConnections.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS))//retrieval key
        {
            statement.setInt(1, leaveRequest.getEmployeeId());
            statement.setString(2, leaveRequest.getLeaveType().name());
            statement.setDate(3, leaveRequest.getStartDate());
            statement.setDate(4, leaveRequest.getEndDate());
            statement.setString(5,leaveRequest.getReason());
            statement.setString(6, LeaveStatus.PENDING.name());
            int rows = statement.executeUpdate();
            if (rows == 0) {
                throw new Exception("Leave not created");
            }
            try (ResultSet keys = statement.getGeneratedKeys()) {
                if (keys.next()){
                    leaveRequest.setLeaveId(keys.getInt(1));
                }
            }
            return leaveRequest;
        }
    }

 /*   public List<LeaveRequest> findAll() throws Exception {
        String sql = "select * from leave_requests order by applied_at desc";
        List<LeaveRequest> leaveRequests = new ArrayList<>();
        try (Connection connection = DBConnections.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    leaveRequests.add(map(resultSet));
                }
            }
            return leaveRequests;
        }
    }*/
   public List<LeaveRequest> findAll() throws Exception {

       String sql = """
                select
                    l.leave_id,
                    l.employee_id,
                    e.full_name,
                    l.leave_type,
                    l.start_date,
                    l.end_date,
                    l.reason,
                    l.status,
                    l.applied_at
                from leave_requests l
                inner join employees e
                on l.employee_id = e.employee_id
                order by l.applied_at desc
            """;

       List<LeaveRequest> leaveRequests = new ArrayList<>();

       try (Connection connection = DBConnections.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery()) {

           while (resultSet.next()) {
               leaveRequests.add(map(resultSet));
           }
       }

       return leaveRequests;
   }
   /* public List<LeaveRequest> findByEmployee(int employeeId) throws Exception {
        List<LeaveRequest> leaves = new ArrayList<>();
        String sql = "select * from leave_requests where employee_id=? ORDER BY applied_at DESC";
        try (Connection connection = DBConnections.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, employeeId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    leaves.add(map(resultSet));
                }
            }
        }
        return leaves;
    }*/

    public List<LeaveRequest> findByEmployee(int employeeId) throws Exception {

        List<LeaveRequest> leaves = new ArrayList<>();

        String sql = """
            select
                l.leave_id,
                l.employee_id,
                e.full_name,
                l.leave_type,
                l.start_date,
                l.end_date,
                l.reason,
                l.status,
                l.applied_at
            from leave_requests l
            inner join employees e
            on l.employee_id = e.employee_id
            where l.employee_id=?
            order by l.applied_at desc
            """;

        try (Connection connection = DBConnections.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, employeeId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    leaves.add(map(resultSet));
                }
            }
        }

        return leaves;
    }

    public LeaveRequest findById(int leaveId) throws Exception {
        String sql = "select * from leave_requests where leave_id=?";
        try (Connection connection = DBConnections.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, leaveId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return map(resultSet);
                }
            }
        }
        return null;
    }

    public boolean approve(int leaveId) throws Exception {
        String sql = "update leave_requests set status='APPROVED' where leave_id=? and status='PENDING'";
        try (Connection connection = DBConnections.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, leaveId);
            return statement.executeUpdate() > 0;
        }
    }

    public boolean reject(int leaveId) throws Exception {
        String sql = "update leave_requests set status='REJECTED' where leave_id=? and status='PENDING'";
        try (Connection connection = DBConnections.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, leaveId);
            return statement.executeUpdate() > 0;
        }
    }

    public boolean delete(int leaveId) throws Exception {
        String sql = "delete from leave_requests where leave_id=?";
        try (Connection connection = DBConnections.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, leaveId);
            return statement.executeUpdate() > 0;
        }
    }

    public boolean update(LeaveRequest leaveRequest) throws Exception {

        String sql = "update leave_requests set leave_type=?,start_date=?,end_date=?, reason=? where leave_id=?";

        try (Connection connection = DBConnections.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, leaveRequest.getLeaveType().name());
            statement.setDate(2, leaveRequest.getStartDate());
            statement.setDate(3, leaveRequest.getEndDate());
            statement.setString(4, leaveRequest.getReason());
            statement.setInt(5, leaveRequest.getLeaveId());

            return statement.executeUpdate() > 0;
        }
    }

    private LeaveRequest map(ResultSet resultSet) throws SQLException {
        Timestamp applied_at = resultSet.getTimestamp("applied_at");
        return new LeaveRequest(
                resultSet.getInt("leave_id"),
                resultSet.getInt("employee_id"),
                resultSet.getString("full_name"),
                LeaveType.valueOf(resultSet.getString("leave_type")),
                resultSet.getDate("start_date"),
                resultSet.getDate("end_date"),
                resultSet.getString("reason"),
                LeaveStatus.valueOf(resultSet.getString("status")),
                applied_at.toLocalDateTime()
        );
    }

}
