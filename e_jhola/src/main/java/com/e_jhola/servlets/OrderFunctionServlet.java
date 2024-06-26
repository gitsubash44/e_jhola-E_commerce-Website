package com.e_jhola.servlets;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.e_jhola.controller.CartController;
import com.e_jhola.controller.OrderController;
import com.e_jhola.controller.OrderedProductController;
import com.e_jhola.controller.ProductController;
import com.e_jhola.model.Cart;
import com.e_jhola.model.Order;
import com.e_jhola.model.OrderedProduct;
import com.e_jhola.model.Product;
import com.e_jhola.model.User;
import com.e_jhola.dbcontroller.Connection;
import com.e_jhola.dbcontroller.OrderIdGenerator;

public class OrderFunctionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String from = (String) session.getAttribute("from");
		String paymentType = request.getParameter("payementMode");
		User user = (User) session.getAttribute("activeUser");
		String orderId = OrderIdGenerator.getOrderId();
		String status = "Order Placed";

		if (from.trim().equals("cart")) {
			try {

				Order order = new Order(orderId, status, paymentType, user.getUserId());
				OrderController orderController = new OrderController(Connection.getConnection());
				int id = orderController.insertOrder(order);

				CartController cartController = new CartController(Connection.getConnection());
				List<Cart> listOfCart = cartController.getCartListByUserId(user.getUserId());
				OrderedProductController orderedProductController = new OrderedProductController(Connection.getConnection());
				ProductController productController = new ProductController(Connection.getConnection());
				for (Cart item : listOfCart) {

					Product prod = productController.getProductsByProductId(item.getProductId());
					String prodName = prod.getProductName();
					int prodQty = item.getQuantity();
					float price = prod.getProductPriceAfterDiscount();
					String image = prod.getProductImages();

					OrderedProduct orderedProduct = new OrderedProduct(prodName, prodQty, price, image, id);
					orderedProductController.insertOrderedProduct(orderedProduct);
				}
				session.removeAttribute("from");
				session.removeAttribute("totalPrice");
				
				//removing all product from cart after successful order
				cartController.removeAllProduct();

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (from.trim().equals("buy")) {

			try {

				int pid = (int) session.getAttribute("pid");
				Order order = new Order(orderId, status, paymentType, user.getUserId());
				OrderController orderController = new OrderController(Connection.getConnection());
				int id = orderController.insertOrder(order);
				OrderedProductController orderedProductController = new OrderedProductController(Connection.getConnection());
				ProductController productController = new ProductController(Connection.getConnection());

				Product prod = productController.getProductsByProductId(pid);
				String prodName = prod.getProductName();
				int prodQty = 1;
				float price = prod.getProductPriceAfterDiscount();
				String image = prod.getProductImages();

				OrderedProduct orderedProduct = new OrderedProduct(prodName, prodQty, price, image, id);
				orderedProductController.insertOrderedProduct(orderedProduct);
				
				//updating(decreasing) quantity of product in database
				productController.updateQuantity(pid, productController.getProductQuantityById(pid) - 1);
				
				session.removeAttribute("from");
				session.removeAttribute("pid");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	    session.setAttribute("order", "success");

	    response.sendRedirect("index.jsp");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

}