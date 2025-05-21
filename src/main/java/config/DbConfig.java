
package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import utils.StringUtils;

public class DbConfig {

	public Connection getConnection() throws ClassNotFoundException, SQLException {
		Class.forName(StringUtils.DRIVER_NAME);
		String url = StringUtils.LOCALHOST_URL;
		String user = StringUtils.LOCALHOST_USERNAME;
		String pass = StringUtils.LOCALHOST_PASSWORD;
		Connection connection = DriverManager.getConnection(url, user, pass);
		return connection;

	}

	// Database configuration information
		private static final String URL = StringUtils.LOCALHOST_URL;
		private static final String USERNAME = "root";
		private static final String PASSWORD = "";

		/**
		 * Establishes a connection to the database.
		 *
		 * @return Connection object for the database
		 * @throws SQLException           if a database access error occurs
		 * @throws ClassNotFoundException if the JDBC driver class is not found
		 */
		public static Connection getDbConnection() throws SQLException, ClassNotFoundException {
			Class.forName(StringUtils.DRIVER_NAME);
			return DriverManager.getConnection(URL, USERNAME, PASSWORD);
		

		}
	
	
}