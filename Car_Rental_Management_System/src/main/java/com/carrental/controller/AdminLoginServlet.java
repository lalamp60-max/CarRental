package com.carrental.controller;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.util.DBConnection;

@WebServlet("/AdminLoginServlet")

public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");

        String password = request.getParameter("password");

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM Admin WHERE username=? AND password=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, username);

            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                HttpSession session = request.getSession();

                session.setAttribute("adminName", username);

                session.setAttribute("role", "ADMIN");

                response.sendRedirect("admin-dashboard.jsp");

            } else {

                response.sendRedirect("admin-login.jsp?error=1");

            }

            rs.close();
            ps.close();
            con.close();

        } catch(Exception e) {

            e.printStackTrace();

            response.sendRedirect("admin-login.jsp?error=2");

        }

    }

}