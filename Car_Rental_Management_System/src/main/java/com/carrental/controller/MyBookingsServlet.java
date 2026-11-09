package com.carrental.controller;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.util.DBConnection;

@WebServlet("/MyBookingsServlet")
public class MyBookingsServlet extends HttpServlet {

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

        String sql = "SELECT b.*,c.make,c.model FROM Bookings b " +
                     "JOIN Car c ON b.car_id=c.car_id " +
                     "WHERE b.user_id=? ORDER BY b.booking_id DESC";

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1,userId);

            try(ResultSet rs = ps.executeQuery()) {

                java.util.List<java.util.Map<String,Object>> list =
                    new java.util.ArrayList<>();

                while(rs.next()) {

                    java.util.Map<String,Object> b =
                        new java.util.HashMap<>();

                    b.put("id",rs.getInt("booking_id"));
                    b.put("car",rs.getString("make")+" "+rs.getString("model"));
                    b.put("pickup",rs.getDate("pickup_date"));
                    b.put("return",rs.getDate("return_date"));
                    b.put("days",rs.getInt("total_days"));
                    b.put("amount",rs.getDouble("total_amount"));
                    b.put("status",rs.getString("booking_status"));

                    list.add(b);
                }

                request.setAttribute("bookings",list);

                request.getRequestDispatcher("myBookings.jsp")
                       .forward(request,response);
            }

        } catch(Exception e) {
            throw new ServletException(e);
        }
    }
}