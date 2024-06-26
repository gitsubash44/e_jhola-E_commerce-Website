<%@page import="com.e_jhola.model.User"%>
<%@page import="com.e_jhola.controller.CategoryController"%>
<%@page import="com.e_jhola.model.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.e_jhola.dbcontroller.Connection"%>
<%@page import="com.e_jhola.controller.ProductController"%>
<%
User u = (User) session.getAttribute("activeUser");

String searchKey = request.getParameter("search");
String catId = request.getParameter("category");
CategoryController categoryController = new CategoryController(Connection.getConnection());
String message = "";

ProductController productController = new ProductController(Connection.getConnection());
List<Product> prodList = null;
if (searchKey != null) {
	if (!searchKey.isEmpty()) {
		message = "Showing results for \"" + searchKey + "\"";
	}else{
		message = "No product found!";
	}
	prodList = productController.getAllProductsBySearchKey(searchKey);

} else if (catId != null && !(catId.trim().equals("0"))) {
	prodList = productController.getAllProductsByCategoryId(Integer.parseInt(catId.trim()));
	message = "Showing results for \"" + categoryController.getCategoryName(Integer.parseInt(catId.trim())) + "\"";
} else {
	prodList = productController.getAllProducts();
	message = "All Products";
}

if (prodList != null && prodList.size() == 0) {

	message = "No items are available for \""
	+ (searchKey != null ? searchKey : categoryController.getCategoryName(Integer.parseInt(catId.trim()))) + "\"";

	prodList = productController.getAllProducts();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Products</title>
<%@include file="Elements/css._js.jsp"%>
<style>
.real-price {
	font-size: 22px !important;
	font-weight: 600;
}

.product-price {
	font-size: 17px !important;
	text-decoration: line-through;
}

.product-discount {
	font-size: 15px !important;
	color: #027a3e;
}

 
.button {
    border: none;
    outline: 0;
    padding: 10px;
    margin: 2rem;
    font-size: 1rem;
    color: white;
    background-color: #40b736;
    text-align: center;
    cursor: pointer;
    width: 15rem;
    border-radius: 4px;
}
 
.button:hover {
    background-color: #1f9405;
    color: white;
    text-decoration: none;
}

</style>
</head>
<body style="background-color: #f0f0f0;">
	<!--navbar -->
	<%@include file="Elements/navbar.jsp"%>

	<!--show products-->
	<h4 class="text-center mt-2"><%=message%></h4>
	<div class="container-fluid my-3 px-5">

		<div class="row row-cols-1 row-cols-md-4 g-3">
			<%
			for (Product p : prodList) {
			%>
			<div class="col">

				<div class="card h-100 px-2 py-2">
					<div class="container text-center">
						<img src="Product_imgs/<%=p.getProductImages()%>"
							class="card-img-top m-2"
							style="max-width: 100%; max-height: 200px; width: auto;">
						<h5 class="card-title text-center"><%=p.getProductName()%></h5>

						<div class="container text-center">
							<span class="real-price">NPR:<%=p.getProductPriceAfterDiscount()%></span>&ensp;
							<span class="product-price">NPR:<%=p.getProductPrice()%></span>&ensp;
							<span class="product-discount"><%=p.getProductDiscount()%>&#37;off</span>
						</div>
						<div class="container text-center mb-2 mt-2">
							<button type="button"
								onclick="window.open('viewProduct.jsp?pid=<%=p.getProductId()%>', '_self')"
								class="button">View Details</button>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>
	
	<%@include file="Elements/Footer.jsp"%>
</body>
</html>