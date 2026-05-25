package com.company.task.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
    public static Connection getConnection() throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(
            "jdbc:sqlserver://localhost:1433;databaseName=internal_db;encrypt=false",
            "sa", "123456"
        );
    }
}
