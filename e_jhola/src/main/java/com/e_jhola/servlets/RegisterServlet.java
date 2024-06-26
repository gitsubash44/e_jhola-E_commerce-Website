package com.e_jhola.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.e_jhola.controller.RegisterController;
import com.e_jhola.model.Message;
import com.e_jhola.model.User;
import com.e_jhola.dbcontroller.Connection;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String userName = request.getParameter("user_name");
            String userEmail = request.getParameter("user_email");
            String userPassword = request.getParameter("user_password");
            String userPhone = request.getParameter("user_mobile_no");
            String userGender = request.getParameter("gender");
            String userAddress = request.getParameter("user_address");
            String userCity = request.getParameter("city");

            User user = new User(userName, userEmail, userPassword, userPhone, userGender, userAddress, userCity);
            RegisterController RegisterController = new RegisterController(Connection.getConnection());
            boolean flag = RegisterController.saveUser(user);

            HttpSession session = request.getSession();
            Message message;
            if (flag) {
                message = new Message("Registration Successful !!", "success", "alert-success");
                response.sendRedirect("login.jsp"); // Redirect to the login page
                return;
            } else {
                message = new Message("Something went wrong! Try again!!", "error", "alert-danger");
            }
            session.setAttribute("message", message);
            response.sendRedirect("register.jsp");
            return;

        } catch (Exception e) {
            e.printStackTrace();
            // Handle the exception properly, maybe log it and inform the user
            Message message = new Message("Something went wrong! Try again!!", "error", "alert-danger");
            HttpSession session = request.getSession();
            session.setAttribute("message", message);
            response.sendRedirect("register.jsp");
        }
    }
}
