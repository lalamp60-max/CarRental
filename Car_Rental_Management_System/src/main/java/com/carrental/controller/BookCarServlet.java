package com.carrental.controller;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.util.DBConnection;

@WebServlet("/BookCarServlet")
public class BookCarServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null ||
           !"USER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.html");
            return;
        }

        try {

            int userId = (Integer)session.getAttribute("userId");
            int carId = Integer.parseInt(request.getParameter("carId"));

            LocalDate pickup = LocalDate.parse(
                request.getParameter("pickup_date"));

            LocalDate returned = LocalDate.parse(
                request.getParameter("return_date"));

            if(pickup.isBefore(LocalDate.now()) ||
               !returned.isAfter(pickup)) {
                response.sendRedirect("booking-error.jsp");
                return;
            }

            long days = java.time.temporal.ChronoUnit.DAYS.between(
                pickup, returned);

            Connection con = DBConnection.getConnection();

            try {
                con.setAutoCommit(false);

                String sql = "SELECT rental_rate_per_day FROM Car " +
                             "WHERE car_id=? AND availability_status='Available' FOR UPDATE";

                double price;

                try(PreparedStatement ps = con.prepareStatement(sql)) {

                    ps.setInt(1,carId);

                    try(ResultSet rs = ps.executeQuery()) {

                        if(!rs.next()) {
                            con.rollback();
                            response.sendRedirect("ViewCarServlet");
                            return;
                        }

                        price = rs.getDouble("rental_rate_per_day");
                    }
                }

                double total = price * days;

                String insert = "INSERT INTO Bookings " +
                    "(user_id,car_id,booking_date,pickup_date,return_date,total_days,total_amount,booking_status) " +
                    "VALUES(?,?,CURDATE(),?,?,?,?, 'PENDING')";

                try(PreparedStatement ps = con.prepareStatement(insert)) {

                    ps.setInt(1,userId);
                    ps.setInt(2,carId);
                    ps.setDate(3,Date.valueOf(pickup));
                    ps.setDate(4,Date.valueOf(returned));
                    ps.setLong(5,days);
                    ps.setDouble(6,total);

                    ps.executeUpdate();
                }

                try(PreparedStatement ps = con.prepareStatement(
                    "UPDATE Car SET availability_status='Rented' WHERE car_id=?")) {

                    ps.setInt(1,carId);
                    ps.executeUpdate();
                }

                con.commit();

                response.sendRedirect("MyBookingsServlet?success=1");

            } catch(Exception e) {

                con.rollback();
                throw e;

            } finally {
                con.setAutoCommit(true);
                con.close();
            }

        } catch(Exception e) {
            throw new ServletException(e);
        }
    }
}