package model;

import org.eclipse.tags.shaded.org.apache.xpath.operations.Bool;

import java.sql.Timestamp;

public class Employee {
    private int employeeId;
    private String fullName;
    private String email;
    private String password;
    private Boolean password_changed;
    private String department;
    private String role;
    private Timestamp createdAt;

    public Boolean getPassword_changed() {
        return password_changed;
    }

    public void setPassword_changed(Boolean password_changed) {
        this.password_changed = password_changed;
    }

    public Employee(int employeeId, String fullName, String email, String password, Boolean password_changed, String department, String role, Timestamp createdAt) {
        this.employeeId = employeeId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.password_changed = password_changed;
        this.department = department;
        this.role = role;
        this.createdAt = createdAt;
    }

//    public Employee(int employeeId, String fullName, String email, String password, String department, String role, Timestamp createdAt) {
//        this.employeeId = employeeId;
//        this.fullName = fullName;
//        this.email = email;
//        this.password = password;
//        this.department = department;
//        this.role = role;
//        this.createdAt = createdAt;
//    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }



    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
