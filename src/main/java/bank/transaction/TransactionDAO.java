package bank.transaction;

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

import bank.account.AccountVO;
import bank.user.UserVO;
import common.ConnectionFactory;

public class TransactionDAO {

	// 이체 함수
	public int transferMoney(String senderAccountNo, String accountPw, String receiverAccountNo, long amount) throws Exception {
		Connection conn = null;
		CallableStatement callableStatement = null;
		int result = 0;
		int idx = 1;
		
		StringBuilder sql = new StringBuilder();

		// 밑에서 conn을 또 써야 해서 향상된 try~catch가 아닌 것으로 수정함. 20:13
		try {
			conn = new ConnectionFactory().getConnection();

			// 오토커밋 안되도록!
			conn.setAutoCommit(false);

			sql.append("{CALL TRANSFER(?, ?, ?)} ");
			callableStatement = conn.prepareCall(sql.toString());

			callableStatement.setString(idx++, senderAccountNo);
			callableStatement.setString(idx++, receiverAccountNo);
			callableStatement.setLong(idx++, amount);

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
	
	
	
	
	//계좌내역의 아이디를 통해 유저의 이름 가져오기
//	SELECT UI.KOR_NAME, UA.ACCOUNT_NO
//	FROM B_USER_ACCOUNT UA
//	JOIN B_USER_INFO UI ON UA.USER_ID = UI.USER_ID
//	WHERE ACCOUNT_NO = '0758-53920545';
	public String getUserNameByAccountNo(String no) throws Exception {
		StringBuilder sql = new StringBuilder();
		String userName = null;

		sql.append("SELECT UI.KOR_NAME, UA.ACCOUNT_NO ");
		sql.append("FROM B_USER_ACCOUNT UA ");
		sql.append("JOIN B_USER_INFO UI ON UA.USER_ID = UI.USER_ID ");
		sql.append("WHERE ACCOUNT_NO = ? ");

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {

			pstmt.setString(1, no);
			ResultSet rs = pstmt.executeQuery();

			if(rs.next()) {
				userName = rs.getString("KOR_NAME");
			}
			System.out.println("계좌로 이름찾기 성공(DAO)");
			return userName;

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("계좌로 이름찾기 실패(DAO)");
		}
		return null;
	}
	
	
	
	
	
	
	

	// 이체시 거래 내역 등록
	public String insertTransactionInfo(String senderBankCode, String senderAccountNo, String accountPw, String receiverBankCode, String receiverAccountNo, long amount, long currentBalance) throws Exception {
		TransactionVO transaction = new TransactionVO();
		
		StringBuilder sql = new StringBuilder();
		String transactionNo = generateTransactionNo();
		String senderName = getUserNameByAccountNo(senderAccountNo);
		String receiverName = getUserNameByAccountNo(receiverAccountNo);
		
		
		int idx = 1;
		int result = transferMoney(senderAccountNo, accountPw, receiverAccountNo, amount);
		String resultMsg = null;
		
		sql.append("INSERT INTO B_TRANSACTION (T_TRANSACTION_NO, B_BANK_CODE, T_ACCOUNT_NO, T_RECEIVER_ACCOUNT, ");
		sql.append("T_AMOUNT, T_TYPE, T_TO_RECEIVER, T_FROM_MEMO, T_STATUS, T_PREVIOUS_BALANCE) ");
		sql.append(" VALUES(?, ?, ?, ?,  ?, ?, ?, ?, ?, ?) ");

		try (Connection conn = new ConnectionFactory().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			
			
			pstmt.setString(idx++, transactionNo);
			pstmt.setString(idx++, receiverBankCode);
			pstmt.setString(idx++, senderAccountNo);
			pstmt.setString(idx++, receiverAccountNo);
			pstmt.setDouble(idx++, amount);
			
			//당행이체 : 하리은행->하리은행
			//타행이체 : 하리은행->룽지은행
			//오픈뱅킹 : 다른은행->다른은행(하리은행 포함)
			if(senderBankCode.equals("0758")) {
				if(receiverBankCode.equals("0758")) {
					pstmt.setString(idx++, "당행이체");
				} else {
					pstmt.setString(idx++, "타행이체");
				}
			} else {
				pstmt.setString(idx++, "오픈뱅킹");
			}
			
			//보내는 메모
			if(transaction.getToMemo() == null) {
				//메모가 따로 없으면 계좌주의 이름.
				pstmt.setString(idx++, senderName);
			} else {
				pstmt.setString(idx++, transaction.getToMemo());
			}
			
			//남기는 메모
			if(transaction.getFromMemo() == null) {
				//메모가 따로 없으면 받는 사람의 이름.
				pstmt.setString(idx++, receiverName);
			} else {
				//메모가 있으면 그 이름.
				pstmt.setString(idx++, transaction.getFromMemo());
			}
			
			//이체 성공했을때
			if(result == 1) {
				pstmt.setString(idx++, "이체완료");
				resultMsg = "이체가 완료되었습니다.";
			} else {
			//실패했을때
				pstmt.setString(idx++, "이체실패");
				resultMsg = "이체에 실패했습니다.";
			}
			//230628 19:31 기존잔액추가 
			pstmt.setDouble(idx++, currentBalance);
			
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("거래내역추가실패(DAO)");
		}
		return resultMsg;
	}
	
	//거래내역리스트 조회
		//입금 또는 출금내역에 계좌가 있는 경우.
		//최신순으로 정렬
		//SELECT * FROM B_TRANSACTION WHERE T_ACCOUNT_NO = '0758-53920545'
		//OR T_RECEIVER_ACCOUNT='0758-53920545' ORDER BY T_DATE DESC, T_TIME DESC;
		public List<TransactionVO> getTransactionList(String no) {
			StringBuilder sql = new StringBuilder();
			TransactionVO vo = null;
			List<TransactionVO> transList = new ArrayList<TransactionVO>();

			sql.append("SELECT * FROM B_TRANSACTION WHERE T_ACCOUNT_NO = ? OR T_RECEIVER_ACCOUNT= ? ");
			sql.append("ORDER BY T_DATE DESC, T_TIME DESC ");
			
			try (Connection conn = new ConnectionFactory().getConnection();
					PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
				pstmt.setString(1, no);
				pstmt.setString(2, no);

				ResultSet rs = pstmt.executeQuery();

				// ID가 존재하면 쿼리를 실행하고
				//거래번호, 날짜, 시간, 구분(타행,OP...), 입출금액, 내용 + 잔액?
				//JSP에서 보내는계좌가 null이면 입금이니까 +금액으로 넣고
				//받는계좌가 null이면 출금이니까 -금액으로 넣는걸로.
				//내용에는 내통장메모
				while(rs.next()) {
					String transactionNo = rs.getString("T_TRANSACTION_NO");
					String date = rs.getString("T_DATE");
					String time = rs.getString("T_TIME");
					String type = rs.getString("T_TYPE");

					//금액은 자릿수 표기
					NumberFormat numFormat = NumberFormat.getInstance(Locale.KOREA);
					
					long amount = rs.getLong("T_AMOUNT");
					String formatedAmount = numFormat.format(amount);
					
					//조회하려는 계좌가 출금계좌인 경우
					if(rs.getString("T_ACCOUNT_NO").equals(no)) {
						formatedAmount = "- " + formatedAmount;
					} else {
						formatedAmount = "+ " + formatedAmount;
					}
//					String receiver = rs.getString("T_RECEIVER_ACCOUNT");
					String memo = rs.getString("T_FROM_MEMO");
					long balance = rs.getLong("T_PREVIOUS_BALANCE");
					
					//자릿수 표기 + 원 붙이기
		        	String formattedBalance = numFormat.format(balance);
					
					vo = new TransactionVO(transactionNo, date, time, type, formatedAmount, memo, formattedBalance);
					transList.add(vo);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

			return transList;
		}
	
	

}// end of class
