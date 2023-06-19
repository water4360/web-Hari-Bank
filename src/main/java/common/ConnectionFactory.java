package common;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionFactory {
	
	
	public Connection getConnection() throws Exception {
		
		Connection conn = null;
		//메소드 호출시 예외를 던져주면 호출한 메소드에서 처리해줌. 
//		try {
			//1.
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			//2.
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "hr";
			String password = "hr";
			
			conn = DriverManager.getConnection(url, user, password);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		
		return conn;
	}
	
}
