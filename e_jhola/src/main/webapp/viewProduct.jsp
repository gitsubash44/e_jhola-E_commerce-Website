<%@page import="com.e_jhola.controller.ProductController"%>
<%@page import="com.e_jhola.model.Product"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
int productId = Integer.parseInt(request.getParameter("pid"));
ProductController productController = new ProductController(Connection.getConnection());
Product product = (Product) productController.getProductsByProductId(productId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Product</title>
<%@include file="Elements/css._js.jsp"%>
<style type="text/css">
.real-price {
	font-size: 26px!important;
	font-weight: 600;
}

.product-price {
	font-size: 18px!important;
	text-decoration: line-through;
}

.product-discount {
	font-size: 16px!important;
	color: #027a3e;
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

	<div class="container mt-5">
			<%@include file="Elements/alert_message.jsp"%>
		<div class="row border border-3">
			<div class="col-md-6">
				<div class="container-fluid text-end my-3">
					<img src="Product_imgs\<%=product.getProductImages()%>"
						class="card-img-top"
						style="max-width: 100%; max-height: 500px; width: auto;">
				</div>
			</div>
			<div class="col-md-6">
				<div class="container-fluid my-5">
					<h4><%=product.getProductName()%></h4>
					<span class="fs-5"><b>Description</b></span><br> <span><%=product.getProductDescription()%></span><br>
					<span class="real-price">NPR:<%=product.getProductPriceAfterDiscount()%></span>&ensp;
					<span class="product-price">NPR:<%=product.getProductPrice()%></span>&ensp;
					<span class="product-discount"><%=product.getProductDiscount()%>&#37;off</span><br>
					<span class="fs-5"><b>Status : </b></span> <span id="availability">
						<%
						if (product.getProductQunatity() > 0) {
							out.println("Available");
						} else {
							out.println("Currently Out of stock");
						}
						%>
					</span><br> <span class="fs-5"><b>Category : </b></span> <span><%=catDao.getCategoryName(product.getCategoryId())%></span>
					<form method="post">
						<div class="container-fluid text-center mt-3">
							<%
							if (user == null) {
							%>
							<button type="button" onclick="window.open('login.jsp', '_self')"
								class="btn btn-primary text-white btn-lg">Add to Cart</button>
							&emsp;
							<button type="button" onclick="window.open('login.jsp', '_self')"
								class="btn btn-info text-white btn-lg">Buy Now</button>
							<%
							} else {
							%>
							<button type="submit"
								formaction="./AddToCartServlet?uid=<%=user.getUserId()%>&pid=<%=product.getProductId()%>"
								class="btn btn-primary text-white btn-lg">Add to Cart</button>
							&emsp; <a
								href="checkout.jsp" id="buy-btn"
								class="btn btn-info text-white btn-lg" role="button"
								aria-disabled="true">Buy Now</a> 
							<%
							}
							%>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			if ($('#availability').text().trim() == "Currently Out of stock") {
				$('#availability').css('color', 'red');
				$('.btn').addClass('disabled');
			}
			$('#buy-btn').click(function(){
				<%
				session.setAttribute("pid", productId);
				session.setAttribute("from", "buy");
				%>	
				});
		});
	</script>
</body>
</html>