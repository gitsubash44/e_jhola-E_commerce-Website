<%@ page import="com.e_jhola.model.Message" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_exception.jsp"%>
<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("adminlogin.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Page</title>
<%@include file="Elements/css._js.jsp"%>
<style type="text/css">
.cus-active {
	background-color: #e6eefa !important;
	width: 100%;
}

.list-btn {
	font-size: 18px !important;
}

.list-btn:hover {
	color: #2874f0 !important;
}

.no-border {
	border: 0;
	box-shadow: none;
}

a {
	text-decoration: none;
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

/* Custom styles for admin dashboard */

/* Container styles */
.container-fluid {
     background: rgb(224, 251, 222);
    background: linear-gradient(360deg, rgb(245, 255, 245) 0%, rgb(173, 252, 163) 100%);
    padding: 100px 0 20px 0;
    text-align: center;
}

/* Card styles */
.card {
    border: none; /* Remove border */
    border-radius: 10px; /* Add border radius */
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); /* Add shadow */
}

.card-body {
    padding: 20px; /* Adjust padding */
}

.card-title {
    margin-top: 15px; /* Adjust margin */
    font-size: 18px; /* Increase font size */
}

/* Image styles */
.img-fluid {
    max-width: 100%; /* Ensure responsiveness */
    height: auto; /* Maintain aspect ratio */
}

/* Link styles */
a {
    text-decoration: none; /* Remove underline */
    color: inherit; /* Inherit color */
}

/* Center align text */
.text-center {
    text-align: center;
}

/* Responsive image styles */
@media (max-width: 768px) {
    .img-fluid {
        max-width: 70%; /* Adjust image width for smaller screens */
    }
}

/* Responsive card styles */
@media (max-width: 576px) {
    .card {
        margin-bottom: 20px; /* Add margin to separate cards */
    }
}


</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Elements/navbar.jsp"%>

	<!--admin dashboard -->
	<div class="container-fluid py-4 px-3">
		<%@include file="Elements/alert_message.jsp"%>
		<div class="row">
			<div class="container text-center" id="details">
				<img src="images/admin.png" style="max-width: 180px;"
					class="img-fluid">
				<h3>
					Welcome "<%=activeAdmin.getName()%>"
				</h3>
			</div>
		</div>
		<div class="container">
			<div class="row px-3 py-3">
				<div class="col-md-4">
					<a href="display_category.jsp">
						<div class="card text-bg-light mb-3 text-center">
							<div class="card-body">
								<img src="images/categorie.png" style="max-width: 200px; height: 100px;"
									class="img-fluid">
								<h4 class="card-title mt-3">Category</h4>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4">
					<a href="display_products.jsp">
						<div class="card text-bg-light mb-3 text-center">
							<div class="card-body">
								<img src="images/Product_sec.png" style="max-width: 200px; height: 100px;"
									class="img-fluid">
								<h4 class="card-title mt-3">Products</h4>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4">
					<a href="display_orders.jsp">
						<div class="card text-bg-light mb-3 text-center">
							<div class="card-body">
								<img src="images/order.png" style="max-width: 200px;height: 100px;"
									class="img-fluid">
								<h4 class="card-title mt-3">Order</h4>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row px-3">
				<div class="col-md-4 offset-md-2">
					<a href="display_users.jsp">
						<div class="card text-bg-light mb-3 text-center">
							<div class="card-body">
								<img src="images/User.png" style="max-width: 200px;height: 100px;"
									class="img-fluid">
								<h4 class="card-title mt-3">User's</h4>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4">
					<a href="display_admin.jsp">
						<div class="card text-bg-light mb-3 text-center">
							<div class="card-body">
								<img src="images/AdminA.png" style="max-width: 200px;height: 100px;"
									class="img-fluid">
								<h4 class="card-title mt-3">Admin</h4>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
	<!--end-->

	<!-- add category modal-->
	<div class="modal fade" id="add-category" tabindex="-1"
		aria-labelledby="addCategoryModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="addCategoryModalLabel">Add
						Category Here</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form action="AddFunctionServlet" method="post"
					enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="operation" value="addCategory">

						<div class="mb-3">
							<label class="form-label"><b>Category Name</b></label> <input
								type="text" name="category_name"
								placeholder="Enter category here" class="form-control" required>
						</div>
						<div class="mb-3">
							<label for="formFile" class="form-label"><b>Category
									Image</b></label> <input class="form-control" type="file"
								name="category_img" id="formFile">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary me-3">Add
							Category</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- end of modal -->

	<!-- add product modal-->
	<div class="modal fade" id="add-product" tabindex="-1"
		aria-labelledby="addProductModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="addProductModalLabel">Add
						Product Here</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form action="AddFunctionServlet" method="post"
					name="addProductForm" enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="operation" value="addProduct">
						<div>
							<label class="form-label"><b>Product Name</b></label> <input
								type="text" name="name" placeholder="Enter product name"
								class="form-control" required>
						</div>
						<div class="mb-2">
							<label class="form-label"><b>Product Description</b></label>
							<textarea class="form-control" name="description" rows="4"
								placeholder="Enter product description"></textarea>
						</div>
						<div class="row">
							<div class="col-md-6 mb-2">
								<label class="form-label"><b>Unit Price</b></label> <input
									type="number" name="price" placeholder="Enter price"
									class="form-control" required>
							</div>
							<div class="col-md-6 mb-2">
								<label class="form-label"><b>Discount Percentage</b></label> <input
									type="number" name="discount" onblur="validate()"
									placeholder="Enter discount if any!" class="form-control">
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-2">
								<label class="form-label"><b>Product Quantity</b></label> <input
									type="number" name="quantity"
									placeholder="Enter product quantity" class="form-control">
							</div>
							<div class="col-md-6 mb-2">
								<label class="form-label"><b>Select Category Type</b></label> <select
									name="categoryType" class="form-control">
									<option value="0">Select Category</option>
									<%
									for (Category c : categoryList) {
									%>
									<option value="<%=c.getCategoryId()%>">
										<%=c.getCategoryName()%></option>
									<%
									}
									%>
								</select>
							</div>
						</div>
						<div class="mb-2">
							<label class="form-label"><b>Product Image</b></label> <input
								type="file" name="photo" class="form-control" required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary me-3">Add
							Product</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- end of modal -->

	<script type="text/javascript">
		function validate() {
			var dis = document.addProductForm.discount.value;
			if (dis > 100 || dis < 0) {
				alert("Discount need tobe between 0-100 !");
				//document.addProductForm.discount.focus();
				return false;
			}
		}
	</script>
</body>
</html>