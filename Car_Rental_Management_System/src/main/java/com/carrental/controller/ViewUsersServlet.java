package com.carrental.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.util.DBConnection;

@WebServlet("/ViewUsersServlet")

public class ViewUsersServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null ||
           !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect("admin-login.jsp");
            return;
        }

        List<HashMap<String, Object>> users = new ArrayList<>();

        String sql = "SELECT user_id, roll_no FROM Users ORDER BY user_id";

        try(Connection con = DBConnection.getConnection()) {

            if(con == null) {
                throw new Exception("Database connection failed");
            }

            try(PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

                while(rs.next()) {

                    HashMap<String, Object> user = new HashMap<>();

                    user.put("user_id", rs.getInt("user_id"));

                    user.put("roll_no", rs.getString("roll_no"));

                    users.add(user);

                }

            }

            request.setAttribute("users", users);

            request.getRequestDispatcher(
                    "viewUsers.jsp").forward(request, response);

        } catch(Exception e) {

            e.printStackTrace();

            response.sendError(500, "Unable to retrieve users.");

        }

    }

}