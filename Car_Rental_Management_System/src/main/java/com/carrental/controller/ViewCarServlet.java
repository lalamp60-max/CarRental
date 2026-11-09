package com.carrental.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.carrental.model.Car;
import com.carrental.util.DBConnection;

@WebServlet("/ViewCarServlet")
public class ViewCarServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Session Validation
        if (session == null ||
                session.getAttribute("role") == null) {

            response.sendRedirect("index.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");

        if (!"ADMIN".equals(role) && !"USER".equals(role)) {

            response.sendRedirect("index.jsp");
            return;
        }

        List<Car> cars = new ArrayList<>();

        String sql;

        // Admin sees all cars; User sees available cars only
        if ("ADMIN".equals(role)) {

            sql = "SELECT * FROM Car ORDER BY car_id DESC";

        } else {

            sql = "SELECT * FROM Car WHERE LOWER(availability_status) = 'available' ORDER BY car_id DESC";
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Car car = new Car();

                car.setCarId(rs.getInt("car_id"));
                car.setMake(rs.getString("make"));
                car.setModel(rs.getString("model"));
                car.setYear(rs.getInt("year"));

                car.setRentalRatePerDay(
                        rs.getDouble("rental_rate_per_day"));

                car.setAvailabilityStatus(
                        rs.getString("availability_status"));

                cars.add(car);
            }

            request.setAttribute("cars", cars);

            request.getRequestDispatcher("viewCar.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                    "Unable to retrieve car records.", e);
        }
    }
}