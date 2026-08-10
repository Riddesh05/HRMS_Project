package Service;

import DAO.EmployeeDAO;
import Util.PasswordUtil;
import model.Employee;

import java.sql.SQLException;
import java.util.List;

public class EmployeeService {
    private final EmployeeDAO employeeDAO = new EmployeeDAO();

    public Employee login(String email,String password) throws Exception {
        Employee employee =employeeDAO.findbyemail(email);
        if(employee == null){
            return null;
        }
        String hashedpwd=PasswordUtil.hash(password);
        if(hashedpwd.equals(employee.getPassword())){
            return employee;
        }
        return null;
    }

    /*public Employee addEmployee(Employee employee) throws Exception {
        if (employee == null) {
            return null;
        }
        return employeeDAO.Create(employee);
    }*/

    public Employee addEmployee(Employee employee) throws Exception {
        Employee existingEmployee=employeeDAO.findbyemail(employee.getEmail());
        if(existingEmployee != null) {
            throw new Exception("EMAIL_ALREADY_EXISTS");
        }
        return employeeDAO.Create(employee);
    }

    public List<Employee> getAllEmployees() throws Exception {
        return employeeDAO.getallemployee();
    }

    public boolean deleteEmployee(int empid) throws Exception {
        return employeeDAO.delete(empid);
    }

    public Employee getEmployeeById(int employeeId) throws Exception {
        return employeeDAO.findById(employeeId);
    }

//    public boolean updateEmployee(Employee employee) throws SQLException {
//        return employeeDAO.update(employee);
//    }
//
    public boolean updatePassword(int employeeId, String password) throws Exception {

        return employeeDAO.updatePassword(employeeId, PasswordUtil.hash(password));
    }

    public Employee findById(int id) throws Exception {
        return employeeDAO.findById(id);
    }
}
