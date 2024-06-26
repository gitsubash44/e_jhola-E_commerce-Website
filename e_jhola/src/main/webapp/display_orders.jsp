<%@page import="com.e_jhola.model.Message"%>
<%@page import="com.e_jhola.controller.RegisterController"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.e_jhola.model.OrderedProduct"%>
<%@page import="com.e_jhola.model.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.e_jhola.controller.OrderedProductController"%>
<%@page import="com.e_jhola.dbcontroller.Connection"%>
<%@page import="com.e_jhola.controller.OrderController"%>

<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("adminlogin.jsp");
	return;
}
OrderController orderController = new OrderController(Connection.getConnection());
OrderedProductController ordProdController = new OrderedProductController(Connection.getConnection());
List<Order> orderList = orderController.getAllOrder();
RegisterController registerController = new RegisterController(Connection.getConnection());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Order's</title>
<%@include file="Elements/css._js.jsp"%>
</head>
<body>
	<!--navbar -->
	<%@include file="Elements/navbar.jsp"%>

	<!-- order details -->

	<div class="container-fluid px-3 py-3">
		<%
		if (orderList == null || orderList.size() == 0) {
		%>
		<div class="container mt-5 mb-5 text-center">
			<img src="images/empty-cart.png" style="max-width: 200px;"
				class="img-fluid">
			<h4 class="mt-3">Zero Order found</h4>
		</div>
		<%
		} else {
		%>
		<div class="container-fluid">
			<table class="table table-hover">
				<tr class="table-primary" style="font-size: 18px;">
					<th class="text-center">Product</th>
					<th>Order ID</th>
					<th>Product Details</th>
					<th>Delivery Address</th>
					<th>Date & Time</th>
					<th>Payment Type</th>
					<th>Status</th>
					<th colspan="2" class="text-center">Action</th>
				</tr>
				<%
				for (Order order : orderList) {
					List<OrderedProduct> ordProdList = ordProdController.getAllOrderedProduct(order.getId());
					for (OrderedProduct orderProduct : ordProdList) {
				%>
				<form action="UpdateOrderServlet?oid=<%=order.getId()%>"
					method="post">
				<tr>
					<td class="text-center"><img
						src="Product_imgs\<%=orderProduct.getImage()%>"
						style="width: 50px; height: 50px; width: auto;"></td>
					<td><%=order.getOrderId()%></td>
					<td><%=orderProduct.getName()%><br>Quantity: <%=orderProduct.getQuantity()%><br>Total
						Price:NPR:<%=orderProduct.getPrice() * orderProduct.getQuantity()%></td>
					<td><%=registerController.getUserName(order.getUserId())%><br>Mobile No. <%=registerController.getUserPhone(order.getUserId())%><br><%=registerController.getUserAddress(order.getUserId())%></td>
					<td><%=order.getDate()%></td>
					<td><%=order.getPayementType()%></td>
					<td><%=order.getStatus()%></td>
					<td><select id="operation" name="status" class="form-select">
							<option>--Select Operation--</option>
							<option value="Order Confirmed">Order Confirmed</option>
							<option value="Shipped">Shipped</option>
							<option value="Out For Delivery">Out For Delivery</option>
							<option value="Delivered">Delivered</option>
					</select></td>
					<td>
						<%
						if (order.getStatus().equals("Delivered")) {
						%>
						<button type="submit" class="btn btn-success disabled">Update</button>
						<%
						} else {
						%>
						<button type="submit" class="btn btn-secondary">Update</button> 
						<%
						 }
						 %>
					</td>
				</tr>
				</form>
				<%
				}
				}
				%>
			</table>

		</div>
		<%
		}
		%>
	</div>
</body>
</html>