package com.e_jhola.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.e_jhola.controller.RegisterController;
import com.e_jhola.model.Message;
import com.e_jhola.dbcontroller.Connection;

public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String referrer = request.getHeader("referer");
        RegisterController registerController = null;
        try {
            registerController = new RegisterController(Connection.getConnection());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        HttpSession session = request.getSession();

        if(referrer.contains("forgot_password")) {
            String email = request.getParameter("email").trim();
            List<String> list = registerController.getAllEmail();
            if(list.contains(email)) {
                session.setAttribute("email", email);
                Message message = new Message("Change Password of "+email, "success", "alert-success");
                session.setAttribute("message", message);
                response.sendRedirect("change_password.jsp");
            }else {
                Message message = new Message("Email not found! Try with another email!", "error", "alert-danger");
                session.setAttribute("message", message);
                response.sendRedirect("forgot_password.jsp");
                return;
            }
        }else if(referrer.contains("change_password")) {
            String password = request.getParameter("password");
            String email =(String)session.getAttribute("email");
            registerController.updateUserPasswordByEmail(password, email);
            session.removeAttribute("email");

            Message message = new Message("Password updated successfully!", "error", "alert-success");
            session.setAttribute("message", message);
            response.sendRedirect("login.jsp");
        }
    }
}