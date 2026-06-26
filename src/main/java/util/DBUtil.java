package util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * DBUtil — centralised JDBC connection factory.
 * Reads db.properties from the classpath (src/main/resources/).
 */
public class DBUtil {

    private static String URL;
    private static String USERNAME;
    private static String PASSWORD;
    private static String DRIVER;

    static {
        try {
            Properties props = new Properties();
            InputStream is = DBUtil.class
                    .getClassLoader()
                    .getResourceAsStream("db.properties");
            if (is == null) {
                throw new RuntimeException(
                    "db.properties not found in classpath. " +
                    "Make sure it is in src/main/resources/");
            }
            props.load(is);
            URL      = props.getProperty("db.url");
            USERNAME = props.getProperty("db.username");
            PASSWORD = props.getProperty("db.password");
            DRIVER   = props.getProperty("db.driver");
            Class.forName(DRIVER);
        } catch (Exception e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    /** Returns a new JDBC Connection. Caller must close it. */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    /** Silently close a connection (null-safe). */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try { conn.close(); } catch (SQLException ignored) {}
        }
    }
}
