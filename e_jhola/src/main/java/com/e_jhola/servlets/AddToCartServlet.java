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
import com.e_jhola.model.Cart;
import com.e_jhola.model.Message;
import com.e_jhola.dbcontroller.Connection;

public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int uid = Integer.parseInt(req.getParameter("uid"));
		int pid = Integer.parseInt(req.getParameter("pid"));

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
		int qty = cartController.getQuantity(uid, pid);
		HttpSession session = req.getSession();
		Message message = null;
		
		if (qty == 0) {
			Cart cart = new Cart(uid, pid, qty + 1);
			cartController.addToCart(cart);
			message = new Message("Product is added to cart successfully!", "success", "alert-success");
			
		}else {
			int cid = cartController.getIdByUserIdAndProductId(uid, pid);
			cartController.updateQuantity(cid, qty+1);
			message = new Message("Product quantity is increased!", "success", "alert-success");
		}
		//updating quantity of product in database
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
		productController.updateQuantity(pid, productController.getProductQuantityById(pid) - 1);
		session.setAttribute("message", message);
		resp.sendRedirect("viewProduct.jsp?pid="+pid);
	}

}