package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.ConnectionFactory;

public class UserDAO {

	// 1.신규 웹 회원가입
	public void addUser(UserVO vo) {
		StringBuilder sql = new StringBuilder();
		sql.append("INSERT INTO B_USER_INFO(USER_ID, USER_PASSWORD, KOR_NAME,"
				+ " BIRTHDATE, GENDER, TELECOM, PHONE_NO, EMAIL, SIGNUP_TYPE, REG_DATE) ");
		sql.append("  VALUES(?, ?, ?, ?, ?, ?, ?, ?, 'web', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')) ");

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPw());
			pstmt.setString(3, vo.getKorName());
			pstmt.setString(4, vo.getBirthdate());
			pstmt.setString(5, vo.getGender());
			pstmt.setString(6, vo.getTelecom());
			pstmt.setString(7, vo.getPhone());
			pstmt.setString(8, vo.getEmail());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	// 0. ID 중복 검색하는 메소드.
	//SELECT COUNT(*) FROM B_USER_INFO WHERE USER_ID='aaaa';
	public boolean isDuplicated(String userInfo) {

		StringBuilder sql = new StringBuilder();
		sql.append("SELECT COUNT(*) FROM B_USER_INFO WHERE USER_INFO=? ");

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {

			pstmt.setString(1, userInfo);
			ResultSet rs = pstmt.executeQuery();

			// 쿼리를 실행한 결과가
			while (rs.next()) {
				// 0이 아니면 중복
				if (rs.getInt("COUNT(*)")!=0)
					return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		// 다르면 false 반환
		return false;
	}
	
	//로그인 정보 확인
	//SELECT * FROM B_USER_INFO WHERE USER_ID = 'test' AND USER_PASSWORD = '1111'; 
	public boolean isCorrectInfo(String id, String pw) {

		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM B_USER_INFO WHERE USER_ID = ? AND USER_PASSWORD = ? ");

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			ResultSet rs = pstmt.executeQuery();
			// 쿼리를 실행하고 정보가 둘 다 일치하면
			while (rs.next()) {
				if (rs.getString("USER_ID").equalsIgnoreCase(id) 
						&& rs.getString("USER_PASSWORD").equals(pw))
					return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		// 다르면 false 반환
		return false;
	}
	
	
	// ID로 회원정보 찾기
	//SELECT * FROM B_USER_INFO WHERE USER_ID = 'test';
		public UserVO getUserById(String userId) {
			StringBuilder sql = new StringBuilder();
			UserVO vo = null;

			sql.append("SELECT * FROM B_USER_INFO WHERE USER_ID = ? ");
			try (Connection conn = new ConnectionFactory().getConnection();
					PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
				pstmt.setString(1, userId);

				ResultSet rs = pstmt.executeQuery();

				// ID가 존재하면 쿼리를 실행하고
				if (rs.next()) {
					String id = rs.getString("USER_ID");
					String pw = rs.getString("USER_PW");
					String name = rs.getString("KOR_NAME");
					String birth = rs.getString("BIRTHDATE");
					String gen = rs.getString("GENDER");
					String tel = rs.getString("TELECOM");
					String phone = rs.getString("PHONE_NO");
					String email = rs.getString("EMAIL");
					String signType = rs.getString("SIGNUP_TYPE");
					String regDate = rs.getString("REG_DATE");

					vo = new UserVO(id, pw, name, birth, gen, tel, phone, email, signType, regDate);
					
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

			return vo;
		}
	
	
	
	

}// end of class
