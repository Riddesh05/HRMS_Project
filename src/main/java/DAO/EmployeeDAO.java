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


    public  boolean delete(int eid) throws Exception {
        String s="delete from employees where employee_id=?";
        try(Connection connection=DBConnections.getConnection();
            PreparedStatement ps=connection.prepareStatement(s)){
            ps.setInt(1,eid);
            return ps.executeUpdate()>0;
        }
    }

    public boolean changePassword(int employeeId,String newPassword)throws Exception{
        String sql="""
        update employees set password=?,password_changed=true where employee_id=?""";
        try(Connection con=DBConnections.getConnection();
            PreparedStatement ps=con.prepareStatement(sql)){
            ps.setString(1,PasswordUtil.hash(newPassword));
            ps.setInt(2,employeeId);
            return ps.executeUpdate()>0;
        }
    }
}
