package com.carrental.controller;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.util.DBConnection;

@WebServlet("/UpdateBookingStatusServlet")
public class UpdateBookingStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null ||
           !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        int bookingId = Integer.parseInt(
            request.getParameter("bookingId"));

        String status = request.getParameter("status");

        if(!"APPROVED".equals(status) &&
           !"REJECTED".equals(status)) {
            response.sendError(400);
            return;
        }

        try(Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            try {

                int carId = -1;

                try(PreparedStatement ps = con.prepareStatement(
                    "SELECT car_id FROM Bookings WHERE booking_id=? AND booking_status='PENDING' FOR UPDATE")) {

                    ps.setInt(1,bookingId);

                    try(ResultSet rs = ps.executeQuery()) {
                        if(rs.next()) {
                            carId = rs.getInt("car_id");
                        }
                    }
                }

                if(carId != -1) {

                    try(PreparedStatement ps = con.prepareStatement(
                        "UPDATE Bookings SET booking_status=? WHERE booking_id=?")) {

                        ps.setString(1,status);
                        ps.setInt(2,bookingId);
                        ps.executeUpdate();
                    }

                    if("REJECTED".equals(status)) {

                        try(PreparedStatement ps = con.prepareStatement(
                            "UPDATE Car SET availability_status='Available' WHERE car_id=?")) {

                            ps.setInt(1,carId);
                            ps.executeUpdate();
                        }
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

        response.sendRedirect("ManageBookingsServlet");
    }
}