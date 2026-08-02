package DAO;

import Connectionss.DBConnections;
import model.Employee;
import model.EmployeeRole;

import java.sql.*;

public class EmployeeDAO {


    public Employee findbyemailpassword(String email,String password) throws Exception {
        String s="select * from employees where email=? and password=?";
        try (Connection connection= DBConnections.getConnection();
             PreparedStatement ps=connection.prepareStatement(s)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet resultSet = ps.executeQuery()) {
                return resultSet.next() ? map(resultSet) : null;
            }

        }
    }

    public Employee map(ResultSet rs) throws SQLException {

        Timestamp created_at = rs.getTimestamp("created_at");
        return new Employee(rs.getInt("employee_id"),
                rs.getString("full_name"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getBoolean("password_changed"),
                rs.getString("department"),
                EmployeeRole.valueOf(rs.getString("role")),      // Enum
                created_at.toLocalDateTime()
                );
    }
}
