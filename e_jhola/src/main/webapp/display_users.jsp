<%@page import="com.e_jhola.model.Message"%>
<%@page import="com.e_jhola.controller.RegisterController"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<title>View User's</title>
<%@include file="Elements/css._js.jsp"%>
</head>
<body>
	<!--navbar -->
	<%@include file="Elements/navbar.jsp"%>

	<div class="container-fluid px-5 py-3">
		<table class="table table-hover">
			<tr class="text-center table-primary" style="font-size: 18px;">
				<th>User Name</th>
				<th>Email</th>
				<th>Phone No.</th>
				<th>Gender</th>
				<th>Address</th>
				<th>Register Date</th>
				<th>Action</th>
			</tr>
			<%
			RegisterController registerController = new RegisterController(Connection.getConnection());
			List<User> userList = registerController.getAllUser();
			for (User u : userList) {
			%>
			<tr>
				<td><%=u.getUserName()%></td>
				<td><%=u.getUserEmail()%></td>
				<td><%=u.getUserPhone()%></td>
				<td><%=u.getUserGender()%></td>
				<td><%=registerController.getUserAddress(u.getUserId())%></td>
				<td><%=u.getDateTime()%></td>
				<td><a href="UserUpdatesServlet?operation=deleteUser&uid=<%=u.getUserId()%>" role="button" class="btn btn-danger">Remove</a></td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
</body>
</html>