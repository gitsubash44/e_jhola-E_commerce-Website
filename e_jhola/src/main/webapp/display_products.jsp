<%@page import="com.e_jhola.model.Message"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page errorPage="error_exception.jsp"%>
<%@page import="com.e_jhola.controller.RegisterController"%>
<%@page import="com.e_jhola.model.Product"%>
<%@page import="com.e_jhola.controller.ProductController"%>
<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("adminlogin.jsp");
	return;
}
RegisterController registerController = new RegisterController(Connection.getConnection());
ProductController productDao = new ProductController(Connection.getConnection());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Product's</title>
<%@include file="Elements/css._js.jsp"%>
</head>
<body>
	<!--navbar -->
	<%@include file="Elements/navbar.jsp"%>

	<!-- update product -->
	<div class="container mt-3">
		<%@include file="Elements/alert_message.jsp"%>
		<table class="table table-hover">
			<tr class="table-primary text-center" style="font-size: 20px;">
				<th>Image</th>
				<th>Name</th>
				<th class="text-start">Category</th>
				<th>Price</th>
				<th class="text-start">Quantity</th>
				<th class="text-start">Discount</th>
				<th>Action</th>
			</tr>
			<%
			List<Product> productList = productDao.getAllProducts();
			for (Product prod : productList) {
				String category = catDao.getCategoryName(prod.getCategoryId());
			%>
			<tr class="text-center">
				<td><img src="Product_imgs/<%=prod.getProductImages()%>"
					style="width: 60px; height: 60px; width: auto;"></td>
				<td class="text-start"><%=prod.getProductName()%></td>
				<td><%=category%></td>
				<td>NPR:<%=prod.getProductPriceAfterDiscount()%></td>
				<td><%=prod.getProductQunatity()%></td>
				<td><%=prod.getProductDiscount()%>%</td>
				<td><a href="update_product.jsp?pid=<%=prod.getProductId()%>" role="button" class="btn btn-secondary">Update</a>&emsp;<a
					href="AddFunctionServlet?pid=<%=prod.getProductId()%>&operation=deleteProduct"
					class="btn btn-danger" role="button">Delete</a></td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
</body>
</html>