<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forget Password</title>
<%@include file="Elements/css._js.jsp"%>
<style>
label {
	font-weight: bold;
}
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Elements/navbar.jsp"%>

	<div class="container-fluid ">
		<div class="row mt-5">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body px-5">

						<div class="container text-center">
							<img src="images/forgot-password.png" style="max-width: 100px;"
								class="img-fluid">
						</div>
						<h3 class="text-center mt-3">Change Password</h3>
						<%@include file="Elements/alert_message.jsp"%>

						<!--change password-->
						<form action="ChangePasswordServlet" method="post">
							<div class="mb-3">
								<label class="form-label">Email</label> <input type="email"
									name="email" placeholder="Enter email" class="form-control"
									required>
							</div>
							<div class="container text-center">
								<button type="submit" class="btn btn-outline-primary me-3">Submit</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>