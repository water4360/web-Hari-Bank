package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.ConnectionFactory;

public class UserDAO {

	// 1.신규 웹 회원가입
	public void addUser(UserVO vo) {
		StringBuilder sql = new StringBuilder();
//		sql.append("INSERT INTO B_USER_INFO(USER_ID, USER_PASSWORD, KOR_NAME,"
//				+ " BIRTHDATE, GENDER, TELECOM, PHONE_NO, EMAIL, SIGNUP_TYPE, REG_DATETIME) ");
//		sql.append("  VALUES(?, ?, ?, ?, ?, ?, ?, ?, 'web', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')) ");
		
//		SELECT ui.USER_ID, ui.USER_PASSWORD, ui.KOR_NAME, ui.BIRTHDATE, ui.GENDER, ui.TELECOM, ui.PHONE_NO, ui.EMAIL,
//	       ua.POSTCODE, ua.ROAD_ADDRESS, ua.DETAIL_ADDRESS
//	FROM B_USER_INFO ui
//	LEFT JOIN B_USER_ADDRESS ua ON ui.USER_ID = ua.USER_ID
//	WHERE ui.USER_ID = 'aaaa';
		
		 sql.append("INSERT ALL ");
		    sql.append("INTO B_USER_INFO (USER_ID, USER_PASSWORD, KOR_NAME, BIRTHDATE, GENDER, TELECOM, PHONE_NO, EMAIL, SIGNUP_TYPE) ");
		    sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'web') ");
		    sql.append("INTO B_USER_ADDRESS (USER_ID, ADDRESS_TYPE, POSTCODE, ROAD_ADDRESS, DETAIL_ADDRESS) ");
		    sql.append("VALUES (?, '자택', ?, ?, ?) ");
		    sql.append("INTO B_USER_AUTHORITY (ROLE_CODE, ROLE_NAME, USER_ID) ");
		    sql.append("VALUES ('H1', '브론즈', ?) ");
		    sql.append("SELECT 1 FROM DUAL");
		

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

			
			// for B_USER_ADDRESS
	        pstmt.setString(9, vo.getId());
//	        pstmt.setString(10, vo.getWhere()); //자택,직장
	        pstmt.setString(10, vo.getPostcode());
	        pstmt.setString(11, vo.getRoadAddress());
	        pstmt.setString(12, vo.getDetailAddress());
			
	        // for B_USER_AUTHORITY
	        pstmt.setString(13, vo.getId());
	        
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	// 0. ID 중복 검색하는 메소드.
	//SELECT COUNT(*) FROM B_USER_INFO WHERE USER_ID='aaaa';
	public boolean isDuplicated(String userInfo) {

		StringBuilder sql = new StringBuilder();
		sql.append("SELECT COUNT(*) FROM B_USER_INFO WHERE USER_ID=? ");

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
//	SELECT * 
//	FROM B_USER_INFO
//	LEFT JOIN B_USER_AUTHORITY 
//	ON B_USER_INFO.USER_ID = B_USER_AUTHORITY.USER_ID
//	WHERE B_USER_INFO.USER_ID = 'aaaa';
		public UserVO getUserById(String userId) {
			StringBuilder sql = new StringBuilder();
			UserVO vo = null;

			sql.append("SELECT * ");
			sql.append("FROM B_USER_INFO ");
			sql.append("LEFT JOIN B_USER_AUTHORITY ");
			sql.append("ON B_USER_INFO.USER_ID = B_USER_AUTHORITY.USER_ID ");
			sql.append("WHERE B_USER_INFO.USER_ID = ? ");
			try (Connection conn = new ConnectionFactory().getConnection();
					PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
				pstmt.setString(1, userId);

				ResultSet rs = pstmt.executeQuery();

				// ID가 존재하면 쿼리를 실행하고
				if (rs.next()) {
					String id = rs.getString("USER_ID");
					String pw = rs.getString("USER_PASSWORD");
					String name = rs.getString("KOR_NAME");
					String birth = rs.getString("BIRTHDATE");
					String gen = rs.getString("GENDER");
					String tel = rs.getString("TELECOM");
					String phone = rs.getString("PHONE_NO");
					String email = rs.getString("EMAIL");
					String signType = rs.getString("SIGNUP_TYPE");
					String regDate = rs.getString("REG_DATETIME");
					String roleCode = rs.getString("ROLE_CODE");
					String roleName = rs.getString("ROLE_NAME");
					

					vo = new UserVO(id, pw, name, birth, gen, tel, phone, email, signType, regDate, roleCode, roleName);
					
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

			return vo;
		}
	
	
	
	

}// end of class
