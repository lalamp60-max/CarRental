package com.carrental.controller;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.model.Car;
import com.carrental.util.DBConnection;

@WebServlet("/SearchCarServlet")
public class SearchCarServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            !"USER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.html");
            return;
        }

        String keyword = request.getParameter("keyword");

        List<Car> cars = new ArrayList<>();

        String sql = "SELECT * FROM Car WHERE availability_status='Available'";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (make LIKE ? OR model LIKE ?)";
        }

        sql += " ORDER BY car_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(1, "%" + keyword.trim() + "%");
                ps.setString(2, "%" + keyword.trim() + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {

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
            }

            request.setAttribute("cars", cars);
            request.setAttribute("keyword", keyword);

            request.getRequestDispatcher("searchCar.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}