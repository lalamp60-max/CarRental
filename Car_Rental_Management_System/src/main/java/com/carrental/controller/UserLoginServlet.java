package com.carrental.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.util.DBConnection;

@WebServlet("/UserLoginServlet")

public class UserLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String rollNo = request.getParameter("roll_no");

        String password = request.getParameter("password");

        String sql = "SELECT * FROM Users WHERE roll_no=? AND password=?";

        try(Connection con = DBConnection.getConnection()) {

            if(con == null) {

                throw new Exception("Database connection failed");

            }

            try(PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, rollNo);

                ps.setString(2, password);

                try(ResultSet rs = ps.executeQuery()) {

                    if(rs.next()) {

                        HttpSession session = request.getSession();

                        session.setAttribute(
                                "userId",
                                rs.getInt("user_id"));

                        session.setAttribute(
                                "userName",
                                rs.getString("roll_no"));

                        session.setAttribute(
                                "role",
                                "USER");

                        response.sendRedirect("dashboard.jsp");

                    } else {

                        response.sendRedirect("login.html?error=invalid");

                    }

                }

            }

        } catch(Exception e) {

            e.printStackTrace();

            response.sendError(500, "Login failed. Please try again.");

        }

    }

}