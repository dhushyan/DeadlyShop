package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBUtil - Centralized JDBC connection factory.
 *
 * Database configuration is read from environment variables:
 * DB_URL
 * DB_USERNAME
 * DB_PASSWORD
 * DB_DRIVER
 */
public class DBUtil {

    private static final String URL =
            System.getenv().getOrDefault(
                    "DB_URL",
                    "jdbc:mysql://localhost:3306/deadlyshop"
                            + "?useSSL=false"
                            + "&serverTimezone=Asia/Kolkata"
                            + "&allowPublicKeyRetrieval=true"
            );

    private static final String USERNAME =
            System.getenv().getOrDefault("DB_USERNAME", "root");

    private static final String PASSWORD =
            System.getenv().getOrDefault("DB_PASSWORD", "");

    private static final String DRIVER =
            System.getenv().getOrDefault(
                    "DB_DRIVER",
                    "com.mysql.cj.jdbc.Driver"
            );

    static {
        try {
            Class.forName(DRIVER);
        } catch (Exception e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    /**
     * Returns a new JDBC connection.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
                URL,
                USERNAME,
                PASSWORD
        );
    }

    /**
     * Safely closes database connection.
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ignored) {
            }
        }
    }
}