package com.carrental.controller;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.util.DBConnection;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null ||
           !"USER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.html");
            return;
        }

        int userId = (Integer)session.getAttribute("userId");
        int bookingId = Integer.parseInt(
            request.getParameter("bookingId"));

        try(Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            try {

                int carId = -1;

                String sql = "SELECT car_id FROM Bookings " +
                    "WHERE booking_id=? AND user_id=? " +
                    "AND booking_status='PENDING' FOR UPDATE";

                try(PreparedStatement ps = con.prepareStatement(sql)) {

                    ps.setInt(1,bookingId);
                    ps.setInt(2,userId);

                    try(ResultSet rs = ps.executeQuery()) {
                        if(rs.next()) {
                            carId = rs.getInt("car_id");
                        }
                    }
                }

                if(carId != -1) {

                    try(PreparedStatement ps = con.prepareStatement(
                        "UPDATE Bookings SET booking_status='CANCELLED' WHERE booking_id=?")) {

                        ps.setInt(1,bookingId);
                        ps.executeUpdate();
                    }

                    try(PreparedStatement ps = con.prepareStatement(
                        "UPDATE Car SET availability_status='Available' WHERE car_id=?")) {

                        ps.setInt(1,carId);
                        ps.executeUpdate();
                    }
                }

                con.commit();

            } catch(Exception e) {
                con.rollback();
                throw e;
            }

        } catch(Exception e) {
            throw new ServletException(e);
        }

        response.sendRedirect("MyBookingsServlet");
    }
}