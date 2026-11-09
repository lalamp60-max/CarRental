package com.carrental.controller;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.util.DBConnection;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null ||
           !"USER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.html");
            return;
        }

        int userId = (Integer)session.getAttribute("userId");

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT user_id,roll_no FROM Users WHERE user_id=?")) {

            ps.setInt(1,userId);

            try(ResultSet rs = ps.executeQuery()) {

                if(rs.next()) {
                    request.setAttribute("userId",rs.getInt("user_id"));
                    request.setAttribute("rollNo",rs.getString("roll_no"));

                    request.getRequestDispatcher("profile.jsp")
                           .forward(request,response);
                } else {
                    response.sendRedirect("login.html");
                }
            }

        } catch(Exception e) {
            throw new ServletException(e);
        }
    }
}