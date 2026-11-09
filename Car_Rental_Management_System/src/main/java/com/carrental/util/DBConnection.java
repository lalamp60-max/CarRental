package com.carrental.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/CarRentalDB";

    private static final String USERNAME = "root";

    // Replace with your MySQL Workbench password
    private static final String PASSWORD = "p@1236";

    // Private constructor
    private DBConnection() {

    }

    // Database Connection Method
    public static Connection getConnection()
            throws SQLException {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch(ClassNotFoundException e) {

            throw new SQLException(
                    "MySQL JDBC Driver not found!", e);

        }

        return DriverManager.getConnection(
                URL,
                USERNAME,
                PASSWORD
        );

    }

}