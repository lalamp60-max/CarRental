package com.carrental.controller;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.util.DBConnection;

@WebServlet("/ManageBookingsServlet")
public class ManageBookingsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null ||
           !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String sql = "SELECT b.*,u.roll_no,c.make,c.model " +
            "FROM Bookings b " +
            "JOIN Users u ON b.user_id=u.user_id " +
            "JOIN Car c ON b.car_id=c.car_id " +
            "ORDER BY b.booking_id DESC";

        List<Map<String,Object>> list = new ArrayList<>();

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()) {

            while(rs.next()) {

                Map<String,Object> b = new HashMap<>();

                b.put("id",rs.getInt("booking_id"));
                b.put("user",rs.getString("roll_no"));
                b.put("car",rs.getString("make")+" "+rs.getString("model"));
                b.put("pickup",rs.getDate("pickup_date"));
                b.put("return",rs.getDate("return_date"));
                b.put("amount",rs.getDouble("total_amount"));
                b.put("status",rs.getString("booking_status"));

                list.add(b);
            }

            request.setAttribute("bookings",list);

            request.getRequestDispatcher("manageBookings.jsp")
                   .forward(request,response);

        } catch(Exception e) {
            throw new ServletException(e);
        }
    }
}