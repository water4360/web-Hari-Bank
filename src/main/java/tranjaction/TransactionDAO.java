package tranjaction;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import common.ConnectionFactory;
import user.UserVO;

public class TransactionDAO {
	
	
	//이체
	public String transferMoney(String senderAccountNo, String receiverAccountNo, long amount) throws Exception {
		Connection conn = null;
		CallableStatement callableStatement = null;
		
		StringBuilder sql = new StringBuilder();
		
		//밑에서 conn을 또 써야 해서 향상된 try~catch가 아닌 것으로 수정함. 20:13
		try {
			conn = new ConnectionFactory().getConnection();
			
			//오토커밋 안되도록!
			conn.setAutoCommit(false);
			
			sql.append("{CALL TRANSFER(?, ?, ?)} ");
			callableStatement = conn.prepareCall(sql.toString());
			
			callableStatement.setString(1, senderAccountNo);
			callableStatement.setString(2, receiverAccountNo);
			callableStatement.setLong(3, amount);
			
			callableStatement.executeUpdate();
			conn.commit();
			
            return "이체성공(DAO)!!";

			
		} catch (SQLException e) {
			conn.rollback();
			System.out.println("이체에러(DAO) : " + e.getMessage());
			return e.getMessage();
			
		} finally {
			if(callableStatement != null) {
				callableStatement.close();
			}
			if(conn != null) {
				conn.close();
			}
		}
	}

	
	
	
	
	
	
	
	
	
}//end of class
