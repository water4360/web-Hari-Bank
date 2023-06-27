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
import user.AccountVO;
import user.UserVO;

public class TransactionDAO {

	// 이체 함수
	public int transferMoney(String senderAccountNo, String receiverAccountNo, long amount) throws Exception {
		Connection conn = null;
		CallableStatement callableStatement = null;
		int result = 0;
		
		StringBuilder sql = new StringBuilder();

		// 밑에서 conn을 또 써야 해서 향상된 try~catch가 아닌 것으로 수정함. 20:13
		try {
			conn = new ConnectionFactory().getConnection();

			// 오토커밋 안되도록!
			conn.setAutoCommit(false);

			sql.append("{CALL TRANSFER(?, ?, ?)} ");
			callableStatement = conn.prepareCall(sql.toString());

			callableStatement.setString(1, senderAccountNo);
			callableStatement.setString(2, receiverAccountNo);
			callableStatement.setLong(3, amount);

			result = callableStatement.executeUpdate();
			conn.commit();

			return result;

		} catch (SQLException e) {
			conn.rollback();
			System.out.println("이체에러(DAO) : " + e.getMessage());
			return 0;

		} finally {
			if (callableStatement != null) {
				callableStatement.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	// 거래번호 생성
	public String generateTransactionNo() throws Exception {
		StringBuilder sql = new StringBuilder();
		String transactionNo = null;

		sql.append("SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') || TO_CHAR(SYSDATE, 'HH24MISS') ");
		sql.append(" ||'-'|| LPAD(seq_transaction_no.nextval, 3, '0')");
		sql.append("  AS TRANSACTION_NO FROM dual ");

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				transactionNo = rs.getString("TRANSACTION_NO");

			}
			System.out.println("거래번호(DAO) 생성완료");
			return transactionNo;

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("거래번호생성에러(DAO)");
		}
		return null;
	}

	// 이체시 거래 내역 등록
	public String insertTransactionInfo(String senderBankCode, String senderAccountNo, String receiverBankCode, String receiverAccountNo, long amount) throws Exception {
		TransactionVO transaction = new TransactionVO();
		
		StringBuilder sql = new StringBuilder();
		String transactionNo = generateTransactionNo();
		
		int result = transferMoney(senderAccountNo, receiverAccountNo, amount);
		String resultMsg = null;
		
		sql.append("  INSERT INTO B_TRANSACTION (T_TRANSACTION_NO, B_BANK_CODE, ACCOUNT_NO, ");
		sql.append("T_RECEIVER_ACCOUNT, T_AMOUNT, T_TO_RECEIVER, T_FROM_MEMO, T_STATUS) ");
		sql.append(" VALUES(?, ?, ?, ?, ?, ?, ?, ?) ");

		try (Connection conn = new ConnectionFactory().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			
			
			pstmt.setString(1, transactionNo);
			pstmt.setString(2, receiverBankCode);
			pstmt.setString(3, senderAccountNo);
			
			pstmt.setString(4, receiverAccountNo);
			pstmt.setDouble(5, amount);
			pstmt.setString(6, transaction.getToMemo());
			pstmt.setString(7, transaction.getFromMemo());
			
			//이체 성공했을때
			if(result == 1) {
				pstmt.setString(8, "이체완료");
				pstmt.executeUpdate();
				
				resultMsg = "이체가 완료되었습니다.";
				return resultMsg;
			} else {
			//실패했을때
				pstmt.setString(8, "이체실패");
				pstmt.executeUpdate();
				
				resultMsg = "이체에 실패했습니다.";
				return resultMsg;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("거래내역추가실패(DAO)");
		}
		return resultMsg;
	}

}// end of class
