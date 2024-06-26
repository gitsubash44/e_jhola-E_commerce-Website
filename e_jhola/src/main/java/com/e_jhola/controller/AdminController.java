package com.e_jhola.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import com.e_jhola.model.Admin;

public class AdminController {
	
	private Connection con;
	
	// Constructor to initialize the AdminController with a database connection
	public AdminController(Connection con) {
		super();
		this.con = con;
	}
	// Method to save an admin to the database
	public boolean saveAdmin(Admin admin) {
		boolean flag = false;

		try {
			// SQL query to insert admin data into the 'admin' table
			String query = "insert into admin(name, email, password, phone) values(?, ?, ?, ?)";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, admin.getName());
			psmt.setString(2, admin.getEmail());
			psmt.setString(3, admin.getPassword());
			psmt.setString(4, admin.getPhone());
			
			// Execute the SQL query
			psmt.executeUpdate();
			flag = true;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	// Method to retrieve an admin from the database based on email and password
	public Admin getAdminByEmailPassword(String email, String password) {
		Admin admin = null;
		try {
			
			// SQL query to select admin data based on email and password
			String query = "select * from admin where email = ? and password = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, email);
			psmt.setString(2, password);

			ResultSet set = psmt.executeQuery();
			while (set.next()) {
				
				// Create an Admin object and populate it with retrieved data
				admin = new Admin();
				admin.setId(set.getInt("id"));
				admin.setName(set.getString("name"));
				admin.setEmail(set.getString("email"));
				admin.setPassword(set.getString("password"));
				admin.setPhone(set.getString("phone"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return admin;
	}

	// Method to retrieve all admins from the database
	public List<Admin> getAllAdmin(){
		List<Admin> list = new ArrayList<Admin>();
		try {
			// SQL query to select all admins from the 'admin' table
			String query = "select * from admin";
			Statement statement = this.con.createStatement();
			ResultSet rs = statement.executeQuery(query);
			while (rs.next()) {
				
				// Create Admin objects for each retrieved row and add them to the list
				Admin admin = new Admin();
				admin.setId(rs.getInt("id"));
				admin.setName(rs.getString("name"));
				admin.setEmail(rs.getString("email"));
				admin.setPhone(rs.getString("phone"));
				admin.setPassword(rs.getString("password"));
				
				list.add(admin);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	// Method to delete an admin from the database based on ID
	public boolean deleteAdmin(int id) {
		boolean flag = false;
		try {
			// SQL query to delete an admin from the 'admin' table based on ID
			String query = "delete from admin where id = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, id);
			// Execute the SQL query
			psmt.executeUpdate();
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
}