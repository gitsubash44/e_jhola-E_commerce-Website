<%@page import="com.e_jhola.model.Message"%>
<%@page import="com.e_jhola.model.Product"%>
<%@page import="com.e_jhola.controller.ProductController"%>
<%@page import="com.e_jhola.model.Cart"%>
<%@page import="com.e_jhola.controller.CartController"%>
<%@page errorPage="error_exception.jsp"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
User activeUser = (User) session.getAttribute("activeUser");
if (activeUser == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("login.jsp");
	return;  
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Shopping cart</title>
<%@include file="Elements/css._js.jsp"%>
<style type="text/css">
.qty {
	display: inline-block;
	padding: 3px 6px;
	width: 46px;
	height: 32px;
	border-radius: 2px;
	background-color: #fff;
	border: 1px solid #c2c2c2;
	margin: 0 5px;
}

.btn{
    border: none;
    color: white;
    background-color: #40b736;
    text-align: center;
    cursor: pointer;
    border-radius: 4px;
}
 
.btn:hover {
    background-color: #1f9405;
    color: white;
    text-decoration: none;
}
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Elements/navbar.jsp"%>

	<%
	float totalPrice = 0;
	CartController cartController = new CartController(Connection.getConnection());
	List<Cart> listOfCart = cartController.getCartListByUserId(user.getUserId());
	if (listOfCart == null || listOfCart.size() == 0) {
	%>
	<div class="container text-center py-5 px-5">
		<img src="images/empty-cart.png" style="max-width: 250px;"
			class="img-fluid">
		<h4 class="mt-5">Your cart is empty!</h4>
		<p>Add items to it now.</p>
		<a href="products.jsp" class="btn btn-primary btn-lg" role="button"
			aria-disabled="true">Shop Now</a>
	</div>
	<%
	} else {
	%>
	
	<div class="container mt-5">
		<%@include file="Elements/alert_message.jsp"%>
		<div class="card px-3 py-3">
			<table class="table table-hover">
				<thead>
					<tr class="table-primary text-center" style="font-size: 18px;">
						<th>Item</th>
						<th>Item Name</th>
						<th>Price</th>
						<th>Quantity</th>
						<th>Total price</th>
						<th>Remove</th>
					</tr>
				</thead>
				<tbody>
					<%
					ProductController productController = new ProductController(Connection.getConnection());
					for (Cart c : listOfCart) {
						Product prod = productController.getProductsByProductId(c.getProductId());						
					%>
					<tr class="text-center">
						<td><img src="Product_imgs\<%=prod.getProductImages()%>"
							style="width: 50px; height: 50px; width: auto;"></td>
						<td class="text-start"><%=prod.getProductName()%></td>
						<td>NPR:<%=prod.getProductPriceAfterDiscount()%></td>
						<td><a
							href="CartFunctionServlet?cid=<%=c.getCartId()%>&opt=1"
							role="button" class="btn btn-light"
							style="border-radius: 50%; font-size: 8px;"> <i
								class="fa-regular fa-plus fa-2xl"></i>
						</a>
						<div class="qty"><%=c.getQuantity()%></div>
							<%if(c.getQuantity() > 1){ %>
							<a href="CartFunctionServlet?cid=<%=c.getCartId()%>&opt=2"
							role="button" class="btn btn-light" id="qtyDesc"
							style="border-radius: 50%; font-size: 8px;"> <i
								class="fa-solid fa-minus fa-2xl"></i></a>
							<%}else{ %>
							<a href="CartFunctionServlet?cid=<%=c.getCartId()%>&opt=2"
							role="button" class="btn btn-light disabled" id="qtyDesc"
							style="border-radius: 50%; font-size: 8px;"> <i
								class="fa-solid fa-minus fa-2xl"></i></a>
							<%} %>
						</td>

						<td>NPR:<%=c.getQuantity() * prod.getProductPriceAfterDiscount()%></td>
						<td><a
							href="CartFunctionServlet?cid=<%=c.getCartId()%>&opt=3"
							class="btn btn-secondary" role="button">Remove</a></td>
					</tr>
					<%
					totalPrice += c.getQuantity() * prod.getProductPriceAfterDiscount();
					}
					%>
					<tr>
						<td class="text-end" colspan="8"><h4 class='pe-5'>
								Total Amount :NPR:
								<%=totalPrice%></h4></td>
					</tr>
				</tbody>
			</table>
			<div class="text-end">
				<a href="products.jsp" class="btn btn-outline-primary" role="button"
					aria-disabled="true">Continue Shopping</a>&nbsp; 
					<a href="checkout.jsp" id="checkout-btn"
					class="btn btn-outline-primary" role="button" aria-disabled="true">Checkout</a>
			</div>

		</div>
	</div>
	<%
	}
	%>
	<script>
		$(document).ready(function(){
			$('#checkout-btn').click(function(){
			<%
			session.setAttribute("totalPrice", totalPrice);
			session.setAttribute("from", "cart");
			%>	
			});
		});
	</script>
	
</body>
</html>