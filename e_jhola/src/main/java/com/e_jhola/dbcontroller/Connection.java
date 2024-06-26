package com.e_jhola.dbcontroller;

import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.http.HttpServlet;


public class Connection extends HttpServlet{
	
	private static final long serialVersionUID = 1L;


public static java.sql.Connection getConnection() throws SQLException, ClassNotFoundException {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/e_jhola";
        String user = "root";
        String pass = "";
        java.sql.Connection connection = DriverManager.getConnection(url, user, pass);
        System.out.println("Database connection established successfully.");
        return connection;
    } catch (SQLException | ClassNotFoundException e) {
        System.err.println("Error establishing database connection: " + e.getMessage());
        throw e; // re-throw the exception to handle it at a higher level if needed
    }
}
}