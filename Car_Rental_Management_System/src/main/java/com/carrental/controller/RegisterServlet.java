package com.carrental.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.util.DBConnection;

@WebServlet("/RegisterServlet")

public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String rollNo = request.getParameter("roll_no");

        String password = request.getParameter("password");

        String confirmPassword =
                request.getParameter("confirm_password");

        // Validation

        if(rollNo == null || password == null ||
           confirmPassword == null ||
           rollNo.trim().isEmpty() ||
           password.length() < 6 ||
           password.length() > 100 ||
           !password.equals(confirmPassword)) {

            response.sendRedirect("register.jsp?error=invalid");

            return;
        }

        rollNo = rollNo.trim();

        String sql = "INSERT INTO Users (roll_no, password) VALUES (?, ?)";

        try(Connection con = DBConnection.getConnection()) {

            if(con == null) {

                throw new SQLException("Database connection failed");

            }

            try(PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, rollNo);

                ps.setString(2, password);

                int result = ps.executeUpdate();

                if(result > 0) {

                    response.sendRedirect("login.html?registered=1");

                } else {

                    response.sendRedirect("register.jsp?error=failed");

                }

            }

        } catch(SQLException e) {

            if(e.getErrorCode() == 1062) {

                response.sendRedirect("register.jsp?error=exists");

            } else {

                e.printStackTrace();

                response.sendRedirect("register.jsp?error=failed");

            }

        }

    }

}