package bank;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

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
				String productCode = rs.getString("CREATED_DATE");
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
	//아이디로 전체계좌리스트 확인
	//아이디로 전체계좌리스트 확인
	//아이디로 전체계좌리스트 확인
	//아이디로 전체계좌리스트 확인
	public List<AccountVO> getAllAccountsById(String userId) {
		List<AccountVO> list = new ArrayList<>();
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
				String productCode = rs.getString("CREATED_DATE");
				String id = rs.getString(userId);
				String bankCode = rs.getString("B_BANK_CODE");
				
				vo = new AccountVO(no, pw, date, balance, nickname, productCode, id, bankCode);
				list.add(vo);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
}
