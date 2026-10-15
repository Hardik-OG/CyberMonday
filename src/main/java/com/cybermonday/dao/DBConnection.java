package com.cybermonday.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            System.getenv().getOrDefault(
                    "CYBERMONDAY_DB_URL",
                    "jdbc:mysql://localhost:3306/cyber_monday"
            );

    private static final String USER =
            System.getenv("CYBERMONDAY_DB_USER");

    private static final String PASSWORD =
            System.getenv("CYBERMONDAY_DB_PASSWORD");

    public static Connection getConnection() throws SQLException {

        if (USER == null || USER.isBlank()
                || PASSWORD == null || PASSWORD.isBlank()) {
            throw new SQLException(
                    "Database credentials are missing. Configure "
                            + "CYBERMONDAY_DB_USER and "
                            + "CYBERMONDAY_DB_PASSWORD."
            );
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "MySQL JDBC driver is missing. Check the Maven dependency.",
                    e
            );
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}