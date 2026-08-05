package DAO;

import Connectionss.DBConnections;
import model.Document;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocumentDAO {

    public void save(Document document) throws Exception {
        String sql="""
            insert into documents(employee_id,document_type,file_name,file_path,file_type,file_size)values(?,?,?,?,?,?)""";

        try(Connection con=DBConnections.getConnection();
            PreparedStatement ps=con.prepareStatement(sql))
        {
            ps.setInt(1,document.getEmployeeId());
            ps.setString(2,document.getDocumentType());
            ps.setString(3,document.getFileName());
            ps.setString(4,document.getFilePath());
            ps.setString(5,document.getFileType());
            ps.setLong(6,document.getFileSize());
            ps.executeUpdate();
        }
    }

    public List<Document> findByEmployee(int employeeId)throws Exception {
        List<Document> list=new ArrayList<>();
        String sql="""
                select * from documents where employee_id=? order by uploaded_at desc""";
        try(Connection con=DBConnections.getConnection();
            PreparedStatement ps=con.prepareStatement(sql))
        {
            ps.setInt(1,employeeId);
            ResultSet rs=ps.executeQuery();
            while(rs.next())
            {
                Document d=new Document();
                d.setDocumentId(rs.getInt("document_id"));
                d.setEmployeeId(rs.getInt("employee_id"));
                d.setDocumentType(rs.getString("document_type"));
                d.setFileName(rs.getString("file_name"));
                d.setFilePath(rs.getString("file_path"));
                d.setFileType(rs.getString("file_type"));
                d.setFileSize(rs.getLong("file_size"));
                list.add(d);
            }
        }
        return list;
    }

    public Document findById(int documentId) throws Exception {
        String sql =
                "select * from documents where document_id=?";

        try(Connection con = DBConnections.getConnection();
            PreparedStatement ps = con.prepareStatement(sql))
        {
            ps.setInt(1, documentId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                Document d = new Document();

                d.setDocumentId(rs.getInt("document_id"));
                d.setEmployeeId(rs.getInt("employee_id"));
                d.setDocumentType(rs.getString("document_type"));
                d.setFileName(rs.getString("file_name"));
                d.setFilePath(rs.getString("file_path"));
                d.setFileType(rs.getString("file_type"));
                d.setFileSize(rs.getLong("file_size"));
                return d;
            }
        }
        return null;
    }

    public List<Document> findAll() throws Exception {
        List<Document> list = new ArrayList<>();
        String sql = """
            select * from documents order by uploaded_at desc""";

        try(Connection con = DBConnections.getConnection();
            PreparedStatement ps = con.prepareStatement(sql))
        {
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Document d = new Document();

                d.setDocumentId(rs.getInt("document_id"));
                d.setEmployeeId(rs.getInt("employee_id"));
                d.setDocumentType(rs.getString("document_type"));
                d.setFileName(rs.getString("file_name"));
                d.setFilePath(rs.getString("file_path"));
                d.setFileType(rs.getString("file_type"));
                d.setFileSize(rs.getLong("file_size"));

                list.add(d);
            }
        }
        return list;
    }
}