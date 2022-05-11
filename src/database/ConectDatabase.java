package database;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class ConectDatabase {
	public static Connection con = null;
	private static ConectDatabase instance = new ConectDatabase();	
	
	public static ConectDatabase getInstance() {
		return instance;
	}
	
	public void connect() throws SQLException {				
			String url = "jdbc:sqlserver://localhost:1433;databasename=QLyLaoDong";
			String user = "sa";
			String password = "909109";
			con = DriverManager.getConnection(url, user, password);		
	}	
	
	public void disconnect() {
		if (con != null)
			try {
				con.close();
			} catch (SQLException e) {	e.printStackTrace();			}
	}
	
	public static Connection getConnection() {
		return con;
	}
}
