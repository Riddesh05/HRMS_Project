package Service;

import DAO.EmployeeDAO;
import model.Employee;
import model.PasswordUtil;

import java.sql.SQLException;
import java.util.List;

public class EmployeeService {
    private final EmployeeDAO employeeDAO = new EmployeeDAO();

    public Employee login(String email, String password) throws Exception {
        //return employeeDAO.findbyemailpassword(email, password);
        Employee employee=employeeDAO.findbyemail(email);
        if (employee==null)
        {
            return null;
        }
        if (!employee.getPassword_changed()){
            if (password.equals(employee.getPassword())){
                return employee;
            }
        }
        else{
            String hashpwd=PasswordUtil.hash(password);
            if (hashpwd.equals(employee.getPassword())){
                return employee;
            }
        }
        return null;
    }

    public Employee addEmployee(Employee employee) throws Exception {
        if (employee == null) {
            return null;
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
}
