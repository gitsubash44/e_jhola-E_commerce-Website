package com.e_jhola.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.e_jhola.controller.CartController;
import com.e_jhola.controller.ProductController;
import com.e_jhola.model.Message;
import com.e_jhola.dbcontroller.Connection;

public class CartFunctionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		CartController cartController = null;
		try {
			cartController = new CartController(Connection.getConnection());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ProductController productController = null;
		try {
			productController = new ProductController(Connection.getConnection());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int cid =Integer.parseInt(request.getParameter("cid"));
		int opt =Integer.parseInt(request.getParameter("opt"));
		
		int qty = cartController.getQuantityById(cid);
		int pid = cartController.getProductId(cid);
		int quantity = productController.getProductQuantityById(pid);	
		
		if(opt == 1) {
			if(quantity > 0) {
				cartController.updateQuantity(cid, qty+1);
				//updating(decreasing) quantity of product in database
				productController.updateQuantity(pid, productController.getProductQuantityById(pid) - 1);
				response.sendRedirect("cart.jsp");
				
			}else {
				HttpSession session = request.getSession();
				Message message = new Message("Product out of stock!", "error", "alert-danger");
				session.setAttribute("message", message);
				response.sendRedirect("cart.jsp");
			}
			
		}else if(opt == 2) {
			cartController.updateQuantity(cid, qty-1);
			
			//updating(increasing) quantity of product in database
			productController.updateQuantity(pid, productController.getProductQuantityById(pid) + 1);
			response.sendRedirect("cart.jsp");
			
		}else if(opt == 3) {
			cartController.removeProduct(cid);
			HttpSession session = request.getSession();
			Message message = new Message("Product removed from cart!", "success", "alert-success");
			session.setAttribute("message", message);
			
			//updating quantity of product in database
			//adding all the product qty back to database
			productController.updateQuantity(pid, productController.getProductQuantityById(pid) + qty);
			response.sendRedirect("cart.jsp");
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}