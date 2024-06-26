package com.e_jhola.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.e_jhola.controller.RegisterController;
import com.e_jhola.model.Message;
import com.e_jhola.model.User;
import com.e_jhola.dbcontroller.Connection;

public class UserUpdatesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("operation");
        HttpSession session = request.getSession();
        User oldUser = (User) session.getAttribute("activeUser");
        RegisterController RegisterController = null;
        try {
            RegisterController = new RegisterController(Connection.getConnection());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (op != null) {
            op = op.trim();
            if (op.equals("changeAddress")) {
                try {
                    String userAddress = request.getParameter("user_address");
                    String userCity = request.getParameter("city");

                    User user = new User();
                    user.setUserId(oldUser.getUserId());
                    user.setUserName(oldUser.getUserName());
                    user.setUserEmail(oldUser.getUserEmail());
                    user.setUserPassword(oldUser.getUserPassword());
                    user.setUserPhone(oldUser.getUserPhone());
                    user.setUserGender(oldUser.getUserGender());
                    user.setDateTime(oldUser.getDateTime());
                    user.setUserAddress(userAddress);
                    user.setUserCity(userCity);

                    RegisterController.updateUserAddresss(user);
                    session.setAttribute("activeUser", user);
                    response.sendRedirect("checkout.jsp");

                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if (op.equals("updateUser")) {
                try {
                    String userName = request.getParameter("name");
                    String userEmail = request.getParameter("email");
                    String userPhone = request.getParameter("mobile_no");
                    String userGender = request.getParameter("gender");
                    String userAddress = request.getParameter("address");
                    String userCity = request.getParameter("city");

                    User user = new User(userName, userEmail, userPhone, userGender, userAddress, userCity);
                    user.setUserId(oldUser.getUserId());
                    user.setUserPassword(oldUser.getUserPassword());
                    user.setDateTime(oldUser.getDateTime());

                    RegisterController.updateUser(user);
                    session.setAttribute("activeUser", user);
                    Message message = new Message("User information updated successfully!!", "success", "alert-success");
                    session.setAttribute("message", message);
                    response.sendRedirect("profile.jsp");

                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if (op.equals("deleteUser")) {
                int uid = Integer.parseInt(request.getParameter("uid"));
                RegisterController.deleteUser(uid);
                response.sendRedirect("display_users.jsp");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doPost(req, resp);
    }

}