package com.e_jhola.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.e_jhola.controller.OrderController;
import com.e_jhola.controller.RegisterController;
import com.e_jhola.model.Order;
import com.e_jhola.dbcontroller.Connection;

public class UpdateOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int oid = Integer.parseInt(request.getParameter("oid"));
		String status = request.getParameter("status");
		OrderController orderController = null;
		try {
			orderController = new OrderController(Connection.getConnection());
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		orderController.updateOrderStatus(oid, status);
		if (status.trim().equals("Shipped") || status.trim().equals("Out For Delivery")) {
			Order order = orderController.getOrderById(oid);
			RegisterController RegisterController = null;
			try {
				RegisterController = new RegisterController(Connection.getConnection());
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
//			MailMessenger.orderShipped(userDao.getUserName(order.getUserId()), userDao.getUserEmail(order.getUserId()),
//					order.getOrderId(), order.getDate().toString());
		}
		response.sendRedirect("display_orders.jsp");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

}