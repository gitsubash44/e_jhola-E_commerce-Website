package com.e_jhola.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.e_jhola.model.Message;

public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String user = request.getParameter("user");
		HttpSession session = request.getSession();
		if(user.trim().equals("user")) {
			session.removeAttribute("activeUser");
			Message message = new Message("Logout successfully!!", "success", "alert-success");
			session.setAttribute("message", message);
			response.sendRedirect("login.jsp");
		}else if(user.trim().equals("admin")) {
			session.removeAttribute("activeAdmin");
			Message message = new Message("Logout successfully!!", "success", "alert-success");
			session.setAttribute("message", message);
			response.sendRedirect("adminlogin.jsp");
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}