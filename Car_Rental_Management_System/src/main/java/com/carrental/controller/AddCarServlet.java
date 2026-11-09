package com.carrental.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.util.DBConnection;

@WebServlet("/AddCarServlet")

public class AddCarServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null ||
           !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect("admin-login.jsp");
            return;
        }

        String make = request.getParameter("make");

        String model = request.getParameter("model");

        String yearValue = request.getParameter("year");

        String rateValue =
                request.getParameter("rental_rate_per_day");

        String status =
                request.getParameter("availability_status");

        try {

            int year = Integer.parseInt(yearValue);

            double rate = Double.parseDouble(rateValue);

            if(year < 1900 || year > 2100 || rate <= 0) {
                response.sendRedirect("addCarForm.html?error=invalid");
                return;
            }

            String sql = "INSERT INTO Car "
                    + "(make, model, year, rental_rate_per_day, availability_status) "
                    + "VALUES (?, ?, ?, ?, ?)";

            try(Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

                if(con == null) {
                    throw new Exception("Database connection failed");
                }

                ps.setString(1, make);

                ps.setString(2, model);

                ps.setInt(3, year);

                ps.setDouble(4, rate);

                ps.setString(5, status);

                int result = ps.executeUpdate();

                if(result > 0) {

                    request.setAttribute(
                            "message",
                            "Car Added Successfully!");

                    request.getRequestDispatcher(
                            "addCar.jsp").forward(request, response);

                }

            }

        } catch(Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to add car. Check server logs.");

        }

    }

}