
package com.cybermonday.dao;

import java.sql.*;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/cyber_monday";

    // Keep your existing MySQL credentials here.
    private static final String USER = "root";
    private static final String PASSWORD = "Hardik@4bd8";

    public static Connection getConnection() throws SQLException {
        try {
            // Explicitly load the MySQL JDBC driver.
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "MySQL JDBC driver is missing from the deployed application. "
                            + "Check WEB-INF/lib and the IntelliJ artifact configuration.",
                    e
            );
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
