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
import common.DAOService;

public class TransactionDAO {

	/*
	 * 고민을 해보자. 계좌이체 시, 출금은행과 입금은행의 은행코드를 각각 전달받는다. 출금은행코드가 하리은행0758일 경우 TRANSFER
	 * 함수를 실행하면 되고
	 * 
	 * 
	 */

	////////////////////// 프로시저로 실행하고 거래내역까지 등록하는 함수
	public int transferMoney(TransactionVO vo) throws Exception {
		Connection conn = null;
		CallableStatement cstmt = null;
		
		
		String senderBankCode = vo.getSenderBank();
		String senderAccountNo = vo.getSenderAccountNo();
		String receiverBankCode = vo.getReceiverBank();
		String receiverAccountNo = vo.getReceiverAccountNo();
		String senderName = getUserNameByAccountNo(senderBankCode, senderAccountNo); //받는이름은 별개로
		String receiverName = getUserNameByAccountNo(receiverBankCode, receiverAccountNo); //보내는이름은 별개로
		long amount = Long.valueOf(vo.getAmount());
		
		
		
		int result = 0;
		int idx = 1;

		StringBuilder sql = new StringBuilder();
		sql.append("{call OP_BANK_TRANSFER(?, ?, ?, ?, ?, ?, ?, ?) }");


		// 밑에서 conn을 또 써야 해서 향상된 try~catch가 아닌 것으로 수정함. 20:13
		// from은행코드,계좌,이름, to코드,계좌,이름,금액 / 결과는 출력값
		try {
			conn = new ConnectionFactory().getConnection();
			// 오토커밋 안되도록!
			conn.setAutoCommit(false);

			cstmt = conn.prepareCall(sql.toString());
			
			cstmt.setString(idx++, senderBankCode);
			cstmt.setString(idx++, senderAccountNo);
			cstmt.setString(idx++, senderName);
			cstmt.setString(idx++, receiverBankCode);
			cstmt.setString(idx++, receiverAccountNo);
			cstmt.setString(idx++, receiverName);
			cstmt.setLong(idx++, amount);
            cstmt.registerOutParameter(idx++, Types.INTEGER);
			
			result = cstmt.executeUpdate();
			conn.commit();


		} catch (SQLException e) {
			conn.rollback();
			System.out.println("이체에러(DAO) : " + e.getMessage());
			return 0;

		} finally {
			if (cstmt != null) {
				cstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return result;
	}




//	// 이체 함수 원본!!!!!!!!!!!!!!!!!!!
//	public int transferMoney(String senderBankCode, String senderAccountNo, String receiverBankCode,
//			String receiverAccountNo, long amount) throws Exception {
//		Connection conn = null;
//		CallableStatement callableStatement = null;
//		int result = 0;
//		int idx = 1;
//		
//		StringBuilder sql = new StringBuilder();
//		
//		// 밑에서 conn을 또 써야 해서 향상된 try~catch가 아닌 것으로 수정함. 20:13
//		try {
//			conn = new ConnectionFactory().getConnection();
//			
//			// 오토커밋 안되도록!
//			conn.setAutoCommit(false);
//			switch (receiverBankCode) {
//			case "0758":
//				sql.append("{CALL TRANSFER(?, ?, ?)} "); // 완료
//				break;
//			case "JH":
//				sql.append("{CALL TRANSFER_TO_JHBANK(?, ?, ?)} "); // 완료
//				break;
//			case "BGH":
//				sql.append("{CALL TRANSFER_TO_BGHBANK(?, ?, ?)} ");
//				break;
//			case "H.J":
//				sql.append("{CALL TRANSFER_TO_HJBANK(?, ?, ?)} ");
//				break;
//			default:
//				System.out.println(receiverBankCode + " << 받는 은행코드가 스위치에 없나본데?");
//				break;
//			}
//			
//			callableStatement = conn.prepareCall(sql.toString());
//			
//			callableStatement.setString(idx++, senderAccountNo);
//			callableStatement.setString(idx++, receiverAccountNo);
//			callableStatement.setLong(idx++, amount);
//			
//			result = callableStatement.executeUpdate();
//			conn.commit();
//			
//			return result;
//			
//		} catch (SQLException e) {
//			conn.rollback();
//			System.out.println("이체에러(DAO) : " + e.getMessage());
//			return 0;
//			
//		} finally {
//			if (callableStatement != null) {
//				callableStatement.close();
//			}
//			if (conn != null) {
//				conn.close();
//			}
//		}
//	}

	// 계좌내역의 아이디를 통해 유저의 이름 가져오기
//	SELECT UI.KOR_NAME, UA.ACCOUNT_NO
//	FROM B_USER_ACCOUNT UA
//	JOIN B_USER_INFO UI ON UA.USER_ID = UI.USER_ID
//	WHERE ACCOUNT_NO = '0758-53920545';
	public String getUserNameByAccountNo(String bankCode, String no) throws Exception {
		StringBuilder sql = new StringBuilder();
		String userName = null;

		switch (bankCode) {
		case "0758":
			sql.append("SELECT UI.KOR_NAME, UA.ACCOUNT_NO ");
			sql.append("FROM B_USER_ACCOUNT UA ");
			sql.append("JOIN B_USER_INFO UI ON UA.USER_ID = UI.USER_ID ");
			sql.append("WHERE ACCOUNT_NO = ? ");
			break;
		case "JH":
			sql.append("SELECT BA.ACCOUNT_NO, BU.USER_NAME ");
			sql.append("FROM BANK_ACCOUNT@JHBank BA ");
			sql.append("JOIN BANK_USER@JHBank BU ON BA.USER_ID = BU.USER_ID ");
			sql.append("WHERE BA.ACCOUNT_NO = ? ");
			break;
		case "BGH":
			sql.append("SELECT ACCOUNT_NO, USER_NAME FROM B_ACCOUNT @BGHBank ");
			sql.append("WHERE ACCOUNT_NO = ? ");
			break;
		case "H.J":
			sql.append("SELECT BA.ACCOUNT_NO, BM.USERNAME ");
			sql.append("FROM B_ACCOUNT @HJBank BA ");
			sql.append("JOIN B_MEMBER @HJBank BM ON BA.MEMBERID = BM.MEMBERID ");
			sql.append("WHERE BA.ACCOUNT_NO = ? ");
			break;
		default:
			System.out.println(bankCode + " << 받는 은행코드가 스위치에 없나본데?");
			break;
		}

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {

			pstmt.setString(1, no);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				switch (bankCode) {
				case "0758":
					userName = rs.getString("KOR_NAME");
					break;
				case "JH":
					userName = rs.getString("USER_NAME");
					break;
				case "BGH":
					userName = rs.getString("USER_NAME");
					break;
				case "H.J":
					userName = rs.getString("USERNAME");
					break;
				default:
					System.out.println(bankCode + " << 받는 은행코드가 스위치에 없나본데?");
					break;
				}
			}
			System.out.println("계좌로 이름찾기 성공(DAO)");
			return userName;

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("계좌로 이름찾기 실패(DAO)");
		}
		return null;
	}

	/*
	 * 
	 * 자, 지금 출금은행코드랑 입금은행코드가 뒤섞였죠??? 이거 구분하고. 테이블에서 B_BANK_CODE도 T_SENDER_BANK_CODE로
	 * 고쳐서 명확하게 하고 T_RECEIVER_BANK_CODE로 명확하게 하고
	 * 
	 * 
	 */

//	// 당행에 이체거래내역 등록
//	// 입금 출금 둘 다!!!!
//	public String insertTransactionInfo(TransactionVO vo) throws Exception {
//
//		StringBuilder sql = new StringBuilder();
//		String resultMsg = null;
//
//		// 넘어오는 값들.
//		String senderBank = vo.getSenderBank();
//		String senderAccountNo = vo.getSenderAccountNo();
//		String receiverBank = vo.getReceiverBank();
//		String receiverAccountNo = vo.getReceiverAccountNo();
//		long amount = Long.valueOf(vo.getAmount());
//		long balance = Long.valueOf(vo.getBalance());
//		String toMemo = vo.getToMemo();
//		String fromMemo = vo.getFromMemo();
//
//		int result = transferMoney(senderBank, senderAccountNo, receiverBank, receiverAccountNo, amount);
//
//		// 출금계좌용 기록!!!!!!!!!!!!!!!!!!
//		int idx = 1;
//		// 보내는은행, 보내는계쫘, 받는은행, 받는계좌, 금액, 구분, 보내는메모, 남기는메모, 처리상태, 잔고
//		sql.append("INSERT INTO B_TRANSACTION (T_SENDER_BANK_CODE, T_SENDER_ACCOUNT_NO, ");
//		sql.append(" T_RECEIVER_BANK_CODE, T_RECEIVER_ACCOUNT_NO, ");
//		sql.append(" T_AMOUNT, T_TYPE, T_TO_MEMO, T_FROM_MEMO, T_STATUS, T_PREVIOUS_BALANCE, T_IN_OUT) ");
//		sql.append(" VALUES(?, ?,  ?, ?,  ?, ?, ?, ?, ?, ?, ?) ");
//
//		try (Connection conn = new ConnectionFactory().getConnection();
//				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
//
//			pstmt.setString(idx++, senderBank);
//			pstmt.setString(idx++, senderAccountNo);
//			pstmt.setString(idx++, receiverBank);
//			pstmt.setString(idx++, receiverAccountNo);
//			pstmt.setDouble(idx++, amount);
//
//			// 당행이체 : 하리은행->하리은행
//			// 타행이체 : 하리은행->룽지은행
//			// 오픈뱅킹 : 다른은행->다른은행(하리은행 포함)
//			if (senderBank.equals("0758")) {
//				if (receiverBank.equals("0758")) {
//					pstmt.setString(idx++, "당행이체");
//				} else {
//					pstmt.setString(idx++, "타행이체");
//				}
//			} else {
//				pstmt.setString(idx++, "오픈뱅킹");
//			}
//
//			String senderName = getUserNameByAccountNo(senderBank, senderAccountNo);
//			String receiverName = getUserNameByAccountNo(receiverBank, receiverAccountNo);
//
//			// 보내는 메모
//			if (toMemo.equals("")) {
//				// 메모가 따로 없으면 계좌주의 이름.
//				pstmt.setString(idx++, senderName);
//			} else {
//				pstmt.setString(idx++, toMemo);
//			}
//
//			// 남기는 메모
//			if (fromMemo.equals("")) {
//				// 메모가 따로 없으면 받는 사람의 이름.
//				pstmt.setString(idx++, receiverName);
//			} else {
//				// 메모가 있으면 그 이름.
//				pstmt.setString(idx++, fromMemo);
//			}
//
//			System.out.println("트랜잭션DAO 메모테스트 보내는 메모: " + toMemo);
//			System.out.println("트랜잭션DAO 메모테스트 내통장 메모: " + fromMemo);
//
//			// 이체 성공했을때
//			if (result == 1) {
//				pstmt.setString(idx++, "이체완료");
//				pstmt.setDouble(idx++, balance - amount);
//				pstmt.setString(idx++, "출금");
//				resultMsg = "이체가 완료되었습니다.";
//			} else {
//				// 실패했을때
//				pstmt.setString(idx++, "이체실패");
//				pstmt.setDouble(idx++, balance);
//				pstmt.setString(idx++, "출금");
//				resultMsg = "이체에 실패하였습니다. 거래내역을 다시 확인해주세요.";
//			}
//
//			pstmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//			System.out.println("거래내역추가실패(DAO)");
//		}
//
//		///////////////////////// 입금용 기록!!!!!!!!!!
//		// 여기서는 위의 정보 다시 리셋.
//		sql = new StringBuilder();
//		idx = 1;
//		// 보내는은행, 보내는계쫘, 받는은행, 받는계좌, 금액, 구분, 보내는메모, 남기는메모, 처리상태, 잔고
//		sql.append("INSERT INTO B_TRANSACTION (T_SENDER_BANK_CODE, T_SENDER_ACCOUNT_NO, ");
//		sql.append(" T_RECEIVER_BANK_CODE, T_RECEIVER_ACCOUNT_NO, ");
//		sql.append(" T_AMOUNT, T_TYPE, T_TO_MEMO, T_FROM_MEMO, T_STATUS, T_PREVIOUS_BALANCE, T_IN_OUT) ");
//		sql.append(" VALUES(?, ?,  ?, ?,  ?, ?, ?, ?, ?, ?, ?) ");
//
//		try (Connection conn = new ConnectionFactory().getConnection();
//				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
//
//			pstmt.setString(idx++, receiverBank);
//			pstmt.setString(idx++, receiverAccountNo);
//			pstmt.setString(idx++, senderBank);
//			pstmt.setString(idx++, senderAccountNo);
//			pstmt.setDouble(idx++, amount);
//
//			if (senderBank.equals("0758")) {
//				if (receiverBank.equals("0758")) {
//					pstmt.setString(idx++, "당행이체");
//				} else {
//					pstmt.setString(idx++, "타행이체");
//				}
//			} else {
//				pstmt.setString(idx++, "오픈뱅킹");
//			}
//
//			String senderName = getUserNameByAccountNo(senderBank, senderAccountNo);
//			String receiverName = getUserNameByAccountNo(receiverBank, receiverAccountNo);
//
//			// 보내는 메모
//			if (toMemo.equals("")) {
//				pstmt.setString(idx++, receiverName);
//			} else {
//				pstmt.setString(idx++, toMemo);
//			}
//
//			// 남기는 메모
//			if (fromMemo.equals("")) {
//				// 메모가 따로 없으면 받는 사람의 이름.
//				pstmt.setString(idx++, senderName);
//			} else {
//				// 메모가 있으면 그 이름.
//				pstmt.setString(idx++, fromMemo);
//			}
//
//			// 이체 성공했을때
//			if (result == 1) {
//				pstmt.setString(idx++, "이체완료");
//				pstmt.setDouble(idx++, balance + amount);
//				pstmt.setString(idx++, "입금");
//				System.out.println("(입금)이체거래내역추가성공(DAO)");
//			} else {
//				// 실패했을때
//				pstmt.setString(idx++, "이체실패");
//				pstmt.setDouble(idx++, balance);
//				pstmt.setString(idx++, "입금");
//				System.out.println("(입금)이체거래내역추가실패(DAO)");
//			}
//
//			pstmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//			System.out.println("거래내역추가실패(DAO)");
//		}
//
//		return resultMsg;
//
//	}



//	// 타행에 이체거래내역 등록해주기
//	public String insertTransactionInfoToOthers(String senderBankCode, String senderAccountNo, String receiverBankCode,
//			String receiverAccountNo, long amount, long currentBalance) throws Exception {
//		TransactionVO transaction = new TransactionVO();
//
//		StringBuilder sql = new StringBuilder();
////		String transactionNo = generateTransactionNo();
//		String senderName = getUserNameByAccountNo(senderBankCode, senderAccountNo);
//		String receiverName = getUserNameByAccountNo(receiverBankCode, receiverAccountNo);
//
//		int idx = 1;
//		int result = transferMoney(senderBankCode, senderAccountNo, receiverBankCode, receiverAccountNo, amount);
//		String resultMsg = null;
//
//		// 거래번호, 보내는은행, 보내는계쫘, 받는은행, 받는계좌, 금액, 구분, 보내는메모, 남기는메모, 처리상태, 잔고
//		sql.append("INSERT INTO B_TRANSACTION (T_SENDER_BANK_CODE, T_SENDER_ACCOUNT_NO, ");
//		sql.append(" T_RECEIVER_BANK_CODE, T_RECEIVER_ACCOUNT_NO, ");
//		sql.append(" T_AMOUNT, T_TYPE, T_TO_MEMO, T_FROM_MEMO, T_STATUS, T_PREVIOUS_BALANCE) ");
//		sql.append(" VALUES(?, ?, ?,  ?, ?,  ?, ?, ?, ?, ?, ?) ");
//
//		try (Connection conn = new ConnectionFactory().getConnection();
//				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
//
//			pstmt.setString(idx++, senderBankCode);
//			pstmt.setString(idx++, senderAccountNo);
//
//			pstmt.setString(idx++, receiverBankCode);
//			pstmt.setString(idx++, receiverAccountNo);
//
//			pstmt.setDouble(idx++, amount);
//			// 당행이체 : 하리은행->하리은행
//			// 타행이체 : 하리은행->룽지은행
//			// 오픈뱅킹 : 다른은행->다른은행(하리은행 포함)
//			if (senderBankCode.equals("0758")) {
//				if (receiverBankCode.equals("0758")) {
//					pstmt.setString(idx++, "당행이체");
//				} else {
//					pstmt.setString(idx++, "타행이체");
//				}
//			} else {
//				pstmt.setString(idx++, "오픈뱅킹");
//			}
//
//			// 보내는 메모
//			if (transaction.getToMemo() == null) {
//				// 메모가 따로 없으면 계좌주의 이름.
//				pstmt.setString(idx++, senderName);
//			} else {
//				pstmt.setString(idx++, transaction.getToMemo());
//			}
//
//			// 남기는 메모
//			if (transaction.getFromMemo() == null) {
//				// 메모가 따로 없으면 받는 사람의 이름.
//				pstmt.setString(idx++, receiverName);
//			} else {
//				// 메모가 있으면 그 이름.
//				pstmt.setString(idx++, transaction.getFromMemo());
//			}
//
//			// 이체 성공했을때
//			if (result == 1) {
//				pstmt.setString(idx++, "이체완료");
//				pstmt.setDouble(idx++, currentBalance - amount);
//				resultMsg = "이체가 완료되었습니다.";
//			} else {
//				// 실패했을때
//				pstmt.setString(idx++, "이체실패");
//				pstmt.setDouble(idx++, currentBalance);
//				resultMsg = "이체에 실패했습니다.";
//			}
//
//			pstmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//			System.out.println("거래내역추가실패(DAO)");
//		}
//		return resultMsg;
//	}

	// 0630 다시하자!!!!! 거래내역리스트 조회
	// sender 계좌에 내계좌는 기본. receiver = 상대계좌.
	// 입금 출금 구분을 T_IN_OUT 컬럼에서.
	// 만약 T_IN_OUT에 따라, 금액에 -를 하든, 그대로 두든(+) 하는 것임.
	// 그렇다면 TO 메모, FROM 메모는 어떻게 할것인가? 순서를 바꿔서 넣어야지.

	// SELECT * FROM B_TRANSACTION WHERE T_ACCOUNT_NO = '0758-53920545'
	// OR T_RECEIVER_ACCOUNT='0758-53920545' ORDER BY T_DATE DESC, T_TIME DESC;
	public List<TransactionVO> getTransactionList(String no) {
		StringBuilder sql = new StringBuilder();
		TransactionVO vo = null;
		List<TransactionVO> transList = new ArrayList<TransactionVO>();

		sql.append("SELECT * FROM B_TRANSACTION WHERE T_SENDER_ACCOUNT_NO = ?");
		sql.append("ORDER BY T_DATE DESC, T_TIME DESC ");

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(1, no);

			ResultSet rs = pstmt.executeQuery();

			// no가 존재하면 쿼리를 실행하고
			// 거래번호, 날짜, 시간, 구분(타행,OP...), 입출금액, 내용 + 잔액?
			while (rs.next()) {
				String transactionNo = rs.getString("T_TRANSACTION_NO");
				String date = rs.getString("T_DATE");
				String time = rs.getString("T_TIME");
				String type = rs.getString("T_TYPE");

				// 금액은 자릿수 표기
				NumberFormat numFormat = NumberFormat.getInstance(Locale.KOREA);

				long amount = rs.getLong("T_AMOUNT");
				String formatedAmount = numFormat.format(amount);
				String memo = "내용없음";

				// 내계좌 출금인 경우.
				// TO_MEMO=받는통장, FROM_MEMO=내통장
				// 0630 자꾸 null 에러때문에 일단 if문 감싸줌.
				if (rs.getString("T_IN_OUT") != null) {

					if (rs.getString("T_IN_OUT").equals("출금")) {
						formatedAmount = "- " + formatedAmount;
						memo = rs.getString("T_FROM_MEMO");
					} else {
						formatedAmount = "+ " + formatedAmount;
						memo = rs.getString("T_TO_MEMO");
					}
				}

				long balance = rs.getLong("T_PREVIOUS_BALANCE");

				// 자릿수 표기 + 원 붙이기
				String formattedBalance = numFormat.format(balance);

				vo = new TransactionVO(transactionNo, date, time, type, formatedAmount, memo, formattedBalance);
				transList.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return transList;
	}

//	// 거래내역리스트 조회
//	// 입금 또는 출금내역에 계좌가 있는 경우.
//	// 최신순으로 정렬
//	// SELECT * FROM B_TRANSACTION WHERE T_ACCOUNT_NO = '0758-53920545'
//	// OR T_RECEIVER_ACCOUNT='0758-53920545' ORDER BY T_DATE DESC, T_TIME DESC;
//	public List<TransactionVO> getTransactionList(String no) {
//		StringBuilder sql = new StringBuilder();
//		TransactionVO vo = null;
//		List<TransactionVO> transList = new ArrayList<TransactionVO>();
//
//		sql.append("SELECT * FROM B_TRANSACTION WHERE T_SENDER_ACCOUNT_NO = ?");
//		sql.append("ORDER BY T_DATE DESC, T_TIME DESC ");
//
//		try (Connection conn = new ConnectionFactory().getConnection();
//				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
//			pstmt.setString(1, no);
//			pstmt.setString(2, no);
//
//			ResultSet rs = pstmt.executeQuery();
//
//			// ID가 존재하면 쿼리를 실행하고
//			// 거래번호, 날짜, 시간, 구분(타행,OP...), 입출금액, 내용 + 잔액?
//			// JSP에서 보내는계좌가 null이면 입금이니까 +금액으로 넣고
//			// 받는계좌가 null이면 출금이니까 -금액으로 넣는걸로.
//			// 내용에는 내통장메모
//			while (rs.next()) {
//				String transactionNo = rs.getString("T_TRANSACTION_NO");
//				String date = rs.getString("T_DATE");
//				String time = rs.getString("T_TIME");
//				String type = rs.getString("T_TYPE");
//
//				// 금액은 자릿수 표기
//				NumberFormat numFormat = NumberFormat.getInstance(Locale.KOREA);
//
//				long amount = rs.getLong("T_AMOUNT");
//				String formatedAmount = numFormat.format(amount);
//				String memo = "내용없음";
//
//				// 조회하려는 계좌가 출금계좌인 경우.
//				// TO_MEMO=TO_RECEIVER, FROM_MEMO=FROM_SENDER
//				if (rs.getString("T_SENDER_ACCOUNT_NO").equals(no)) {
//					formatedAmount = "- " + formatedAmount;
//					memo = rs.getString("T_FROM_MEMO");
//				} else {
//					formatedAmount = "+ " + formatedAmount;
//					memo = rs.getString("T_TO_MEMO");
//				}
//				long balance = rs.getLong("T_PREVIOUS_BALANCE");
//
//				// 자릿수 표기 + 원 붙이기
//				String formattedBalance = numFormat.format(balance);
//
//				vo = new TransactionVO(transactionNo, date, time, type, formatedAmount, memo, formattedBalance);
//				transList.add(vo);
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return transList;
//	}

}// end of class
