package bank.account;

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

import bank.transaction.TransactionVO;
import common.ConnectionFactory;

public class AccountDAO {
	
	
	// Oracle Stored Procedure를 호출하여 계좌 번호를 생성하는 함수
	public String generateAccountNumber() throws Exception {
	    String accountNo = null;

	    String callProc = "{ CALL PRCD_GENERATE_UNIQUE_ACCOUNT_NO(?) }";

	    try (Connection conn = new ConnectionFactory().getConnection();
	         CallableStatement cs = conn.prepareCall(callProc)) {

	        cs.registerOutParameter(1, Types.VARCHAR);
	        cs.execute();

	        accountNo = cs.getString(1);

	    } catch (SQLException e) {
	        e.printStackTrace();
	        System.out.println("계좌번호 생성 프로시저 에러(DAO)");
	    }

		System.out.println("생성된 계좌 : " + accountNo);
	    return accountNo;
	}
	
	
	
	//계좌 개설
	public void addAccount(AccountVO vo) throws Exception {
		StringBuilder sql = new StringBuilder();
		String accountNo = generateAccountNumber(); //위의 함수에서 생성된 것으로.

		sql.append("INSERT INTO B_USER_ACCOUNT(ACCOUNT_NO, ACCOUNT_PASSWORD, TOTAL_BALANCE,"
											+ " ACCOUNT_NICKNAME, D_PRODUCT_CODE, USER_ID, B_BANK_CODE) ");
		sql.append("  VALUES(?, ?, ?, ?, ?, ?, ?) ");
//		sql.append("  VALUES('0758-' || LPAD(DBMS_RANDOM.VALUE(1000000, 99999999), 8, '0'), ?, ?, ?, ?, ?, ?) ");

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(1, accountNo);
			pstmt.setString(2, vo.getAccountPw());
			pstmt.setString(3, "50000000"); //vo.getTotalBalance()
			pstmt.setString(4, vo.getAccountNickname());
			pstmt.setString(5, "D-202301"); //vo.getProductCode()
			pstmt.setString(6, vo.getUserId());
			pstmt.setString(7, "0758"); //vo.getBankCode()
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("계좌생성에러(DAO)");
		}
	}
	
	//아이디로 신규 계좌정보 확인
	public AccountVO getAccountById(String userId) {
		StringBuilder sql = new StringBuilder();
		AccountVO vo = null;

		sql.append("SELECT * FROM (SELECT * FROM B_USER_ACCOUNT WHERE USER_ID=? ORDER BY CREATED_DATE DESC)");
		sql.append(" WHERE ROWNUM = 1 ");
		
		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(1, userId);

			ResultSet rs = pstmt.executeQuery();

			// ID가 존재하면 쿼리를 실행하고
			if (rs.next()) {
				String no = rs.getString("ACCOUNT_NO");
				String pw = rs.getString("ACCOUNT_PASSWORD");
				String date = rs.getString("CREATED_DATE");
				long balance = rs.getLong("TOTAL_BALANCE");
				String nickname = rs.getString("ACCOUNT_NICKNAME");
				String productCode = rs.getString("D_PRODUCT_CODE");
				String id = rs.getString("USER_ID");
				String bankCode = rs.getString("B_BANK_CODE");
				
				vo = new AccountVO(no, pw, date, balance, nickname, productCode, id, bankCode);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return vo;
	}
	
	//아이디로 전체계좌리스트 확인
	//은행코드가 0758이면 당행. 
	//오픈뱅킹일때는 0758 외의 계좌를 출력할것
	//은행코드로 은행명까지 가져오기.
//	SELECT 
//	  UA.*, 
//	  BI.B_BANK_NAME,
//	  BD.D_PRODUCT_NAME
//	FROM B_USER_ACCOUNT UA
//	JOIN B_DEPOSIT BD
//	ON UA.D_PRODUCT_CODE = BD.D_PRODUCT_CODE
//	JOIN B_BANK_INFO BI 
//	ON UA.B_BANK_CODE = BI.B_BANK_CODE
//	WHERE UA.USER_ID = 'aaaa';
	public List<AccountVO> getAccountListById(String userId) {
		List<AccountVO> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		AccountVO vo = null;
		
		sql.append("SELECT UA.*, BI.B_BANK_NAME, BD.D_PRODUCT_NAME ");
		sql.append("FROM B_USER_ACCOUNT UA ");
		sql.append("JOIN B_DEPOSIT BD ");
		sql.append("ON UA.D_PRODUCT_CODE = BD.D_PRODUCT_CODE ");
		sql.append("JOIN B_BANK_INFO BI ");
		sql.append("ON UA.B_BANK_CODE = BI.B_BANK_CODE ");
		sql.append("WHERE UA.USER_ID = ? ");
		
		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(1, userId);
			
			ResultSet rs = pstmt.executeQuery();
			
			// ID가 존재하면 쿼리를 실행하고
			while (rs.next()) {
				String no = rs.getString("ACCOUNT_NO");
				String pw = rs.getString("ACCOUNT_PASSWORD");
				String date = rs.getString("CREATED_DATE");
				long balance = rs.getLong("TOTAL_BALANCE");
				String nickname = rs.getString("ACCOUNT_NICKNAME");
				String productCode = rs.getString("D_PRODUCT_CODE");
				String id = rs.getString("USER_ID");
				String bankCode = rs.getString("B_BANK_CODE");
				String productName = rs.getString("D_PRODUCT_NAME");
				
//				NumberFormat numFormat = NumberFormat.getInstance(Locale.KOREA);
//		    	String formattedTotalBalance = numFormat.format(balance);
				
				vo = new AccountVO(no, pw, date, balance, nickname, productCode, id, bankCode, productName);
				list.add(vo);
			}
			System.out.println("accountDAO 체크 : " + list.size());
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}


	//단일계좌 상세조회
	public AccountVO getAccountInfo(String no) {
		StringBuilder sql = new StringBuilder();
		AccountVO vo = null;

		sql.append("SELECT * FROM B_USER_ACCOUNT WHERE ACCOUNT_NO=? ");
		
		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(1, no);

			ResultSet rs = pstmt.executeQuery();

			// ID가 존재하면 쿼리를 실행하고
			if(rs.next()) {
				String pw = rs.getString("ACCOUNT_PASSWORD");
				String date = rs.getString("CREATED_DATE");
				long balance = rs.getLong("TOTAL_BALANCE");
				String nickname = rs.getString("ACCOUNT_NICKNAME");
				String productCode = rs.getString("D_PRODUCT_CODE");
				String id = rs.getString("USER_ID");
				String bankCode = rs.getString("B_BANK_CODE");
				
				vo = new AccountVO(no, pw, date, balance, nickname, productCode, id, bankCode);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return vo;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}//end of class
