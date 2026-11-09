package com.carrental.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.carrental.util.DBConnection;

@WebServlet("/DeleteCarServlet")

public class DeleteCarServlet extends HttpServlet {

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
                    request.getParameter("id"));

            String sql = "DELETE FROM Car WHERE car_id=?";

            try(Connection con = DBConnection.getConnection()) {

                if(con == null) {
                    throw new Exception("Database connection failed");
                }

                try(PreparedStatement ps = con.prepareStatement(sql)) {

                    ps.setInt(1, id);

                    int result = ps.executeUpdate();

                    if(result > 0) {

                        response.sendRedirect("ViewCarServlet?deleted=1");

                    } else {

                        response.sendRedirect("ViewCarServlet?deleted=0");

                    }

                }

            }

        } catch(Exception e) {

            e.printStackTrace();

            response.sendError(500, "Unable to delete car.");

        }

    }

}