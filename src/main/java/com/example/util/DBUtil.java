package com.example.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * 数据库连接工具类
 */
public class DBUtil {
    private static String jdbcDriver;
    private static String jdbcUrl;
    private static String jdbcUsername;
    private static String jdbcPassword;
    
    static {
        try {
            Properties props = new Properties();
            InputStream is = DBUtil.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(is);
            
            jdbcDriver = props.getProperty("jdbc.driver");
            jdbcUrl = props.getProperty("jdbc.url");
            jdbcUsername = props.getProperty("jdbc.username");
            jdbcPassword = props.getProperty("jdbc.password");
            
            // 加载JDBC驱动
            Class.forName(jdbcDriver);
            
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 获取数据库连接
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
    }
    
    /**
     * 关闭数据库连接
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
} 