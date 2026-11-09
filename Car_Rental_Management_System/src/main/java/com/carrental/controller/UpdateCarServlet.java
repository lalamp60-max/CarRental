package com.carrental.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.model.Car;
import com.carrental.util.DBConnection;

@WebServlet("/UpdateCarServlet")

public class UpdateCarServlet extends HttpServlet {

    // Retrieve Existing Car Details

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null ||
           !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect("admin-login.jsp");
            return;
        }

        String idValue = request.getParameter("id");

        try {

            int id = Integer.parseInt(idValue);

            String sql = "SELECT * FROM Car WHERE car_id=?";

            try(Connection con = DBConnection.getConnection()) {

                if(con == null) {
                    throw new Exception("Database connection failed");
                }

                try(PreparedStatement ps = con.prepareStatement(sql)) {

                    ps.setInt(1, id);

                    try(ResultSet rs = ps.executeQuery()) {

                        if(rs.next()) {

                            Car car = new Car();

                            car.setCarId(rs.getInt("car_id"));

                            car.setMake(rs.getString("make"));

                            car.setModel(rs.getString("model"));

                            car.setYear(rs.getInt("year"));

                            car.setRentalRatePerDay(
                                    rs.getDouble("rental_rate_per_day"));

                            car.setAvailabilityStatus(
                                    rs.getString("availability_status"));

                            request.setAttribute("car", car);

                            request.getRequestDispatcher(
                                    "updateCar.jsp").forward(request, response);

                        } else {

                            response.sendRedirect("ViewCarServlet");

                        }

                    }

                }

            }

        } catch(Exception e) {

            e.printStackTrace();

            response.sendError(500, "Unable to retrieve car details.");

        }

    }


    // Update Car Details

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null ||
           !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect("admin-login.jsp");
            return;
        }

        try {

            int id = Integer.parseInt(
                    request.getParameter("car_id"));

            String make = request.getParameter("make");

            String model = request.getParameter("model");

            int year = Integer.parseInt(
                    request.getParameter("year"));

            double rate = Double.parseDouble(
                    request.getParameter("rental_rate_per_day"));

            String status = request.getParameter(
                    "availability_status");

            if(year < 1900 || year > 2100 || rate <= 0) {
                response.sendError(400, "Invalid car details.");
                return;
            }

            String sql = "UPDATE Car SET make=?, model=?, year=?, "
                    + "rental_rate_per_day=?, availability_status=? "
                    + "WHERE car_id=?";

            try(Connection con = DBConnection.getConnection()) {

                if(con == null) {
                    throw new Exception("Database connection failed");
                }

                try(PreparedStatement ps = con.prepareStatement(sql)) {

                    ps.setString(1, make);

                    ps.setString(2, model);

                    ps.setInt(3, year);

                    ps.setDouble(4, rate);

                    ps.setString(5, status);

                    ps.setInt(6, id);

                    int result = ps.executeUpdate();

                    if(result > 0) {

                        response.sendRedirect("ViewCarServlet?updated=1");

                    } else {

                        response.sendRedirect("ViewCarServlet?updated=0");

                    }

                }

            }

        } catch(Exception e) {

            e.printStackTrace();

            response.sendError(500, "Unable to update car details.");

        }

    }

}