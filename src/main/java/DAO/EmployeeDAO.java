package DAO;

import Connectionss.DBConnections;
import Util.PasswordUtil;
import model.Employee;
import model.EmployeeRole;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    public Employee Create(Employee employee) throws Exception {
        String s="insert into employees(full_name, email, password, department, role) VALUES (?, ?, ?, ?, ?)";
        try(Connection connection=DBConnections.getConnection();
            PreparedStatement ps=connection.prepareStatement(s,PreparedStatement.RETURN_GENERATED_KEYS))
        {
            ps.setString(1, employee.getFullName());
            ps.setString(2,employee.getEmail());
            ps.setString(3, employee.getPassword());
            ps.setString(4,employee.getDepartment());
            ps.setString(5, employee.getRole().name());
            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                keys.next();
                return findById(keys.getLong(1));
            }
        }
    }

    public List<Employee> getallemployee() throws Exception {
        List<Employee> employeeList = new ArrayList<>();
        String s = """
            select * from employees where role <> 'ADMIN' order by employee_id desc """;
        try(Connection connection = DBConnections.getConnection();
            PreparedStatement ps = connection.prepareStatement(s)) {
            try(ResultSet rs = ps.executeQuery()) {
                while(rs.next()) {
                    employeeList.add(map(rs));
                }
            }
        }
        return employeeList;
    }

    public boolean update(Employee employee) throws Exception {
        String sql = "update employees set full_name=?, email=?, department=?, role=? where employee_id=?";

        try(Connection con = DBConnections.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setString(1, employee.getFullName());
            ps.setString(2, employee.getEmail());
            ps.setString(3, employee.getDepartment());
            ps.setString(4, employee.getRole().name());
            ps.setInt(5, employee.getEmployeeId());

            return ps.executeUpdate() > 0;
        }
    }

    public Employee findById(long aLong) throws Exception {
        String s="select * from employees where employee_id=?";
        try(Connection connection=DBConnections.getConnection();
            PreparedStatement ps=connection.prepareStatement(s)) {
            ps.setLong(1,aLong);
            try (ResultSet resultSet = ps.executeQuery()) {
                return resultSet.next() ? map(resultSet) : null;
            }

        }

    }

    public Employee findbyemail(String email) throws Exception {
        String s="select * from employees where email=?";
        try (Connection connection= DBConnections.getConnection();
             PreparedStatement ps=connection.prepareStatement(s)) {
            ps.setString(1,email);
            try (ResultSet resultSet = ps.executeQuery()) {
                return resultSet.next() ? map(resultSet) : null;
            }

        }

    }



    public Boolean updatePassword(int employeeid,String newhashpwd) throws Exception {
        String s= """
                update employees 
                set password=?,
                password_changed=?
                where employee_id=?;
                """;
        try (Connection connection=DBConnections.getConnection();
             PreparedStatement ps=connection.prepareStatement(s)){
            ps.setString(1,newhashpwd);
            ps.setBoolean(2,true);
            ps.setInt(3,employeeid);
            return ps.executeUpdate()>0;

        }

    }

   /* public Employee findbyemailpassword(String email,String password) throws Exception {
        String s="select * from employees where email=? and password=?";
        try (Connection connection= DBConnections.getConnection();
             PreparedStatement ps=connection.prepareStatement(s)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet resultSet = ps.executeQuery()) {
                return resultSet.next() ? map(resultSet) : null;
            }

        }
    }*/

    public Employee map(ResultSet rs) throws SQLException {

        Timestamp created_at = rs.getTimestamp("created_at");
        return new Employee(rs.getInt("employee_id"),
                rs.getString("full_name"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getBoolean("password_changed"),
                rs.getString("department"),
                EmployeeRole.valueOf(rs.getString("role")),      // Enum
                created_at
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
            ps.setString(1, PasswordUtil.hash(newPassword));
            ps.setInt(2,employeeId);
            return ps.executeUpdate()>0;
        }
    }
}
