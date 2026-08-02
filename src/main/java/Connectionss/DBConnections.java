package Connectionss;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnections {
    public static Connection getConnection() throws Exception{
        String driver="com.mysql.cj.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/hrms";
        String user="root";
        String password="@kshat369";
        Class.forName(driver);
        return DriverManager.getConnection(url,user,password);
    }
}
