package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.ConnectionFactory;

public class UserDAO {

	// 1.신규 웹 회원가입
//	INSERT ALL
//	  INTO B_USER_INFO(USER_ID, USER_PASSWORD, KOR_NAME, BIRTHDATE, GENDER, TELECOM, PHONE_NO, EMAIL, SIGNUP_TYPE, ROLE_CODE)
//	                VALUES('aaaa', '1111', '김테스트', '901208', '2', 'SKT', '01083499438', 'aaaa@naver.com', 'web', 'H3')
//	  INTO B_USER_ADDRESS(USER_ID, ADDRESS_TYPE, POSTCODE, ROAD_ADDRESS, DETAIL_ADDRESS)
//	          VALUES('aaaa', '자택', '13073', '경기도 성남시 수정로', '한울관B309')
//	SELECT 1 FROM DUAL;
	
	
//	SELECT UI.USER_ID, UI.USER_PASSWORD, UI.KOR_NAME, UI.BIRTHDATE, UI.GENDER, UI.TELECOM, UI.PHONE_NO, UI.EMAIL,
//    UA.POSTCODE, UA.ROAD_ADDRESS, UA.DETAIL_ADDRESS
//FROM B_USER_INFO UI
//LEFT JOIN B_USER_ADDRESS UA ON UI.USER_ID = UA.USER_ID
//WHERE UI.USER_ID = 'aaaa';
	
	public void addUser(UserVO vo) {
		StringBuilder sql = new StringBuilder();

		sql.append("INSERT ALL ");
			sql.append("INTO B_USER_INFO(USER_ID, USER_PASSWORD, KOR_NAME, BIRTHDATE, GENDER, "
					+ "TELECOM, PHONE_NO, EMAIL, SIGNUP_TYPE, ROLE_CODE) ");
			sql.append("  VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");
		    sql.append("INTO B_USER_ADDRESS(USER_ID, ADDRESS_TYPE, POSTCODE, ROAD_ADDRESS, DETAIL_ADDRESS)");
		    sql.append(" VALUES(?, ?, ?, ?, ?) ");
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
			pstmt.setString(9, "web"); //vo.getSignupType()
			pstmt.setString(10, "H3"); //vo.getRole()

			// for B_USER_ADDRESS
	        pstmt.setString(11, vo.getId());
	        pstmt.setString(12, "자택"); //vo.getAddressType()
	        pstmt.setString(13, vo.getPostcode());
	        pstmt.setString(14, vo.getRoadAddress());
	        pstmt.setString(15, vo.getDetailAddress());
			
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
//	SELECT * FROM B_USER_INFO UI
//	  LEFT JOIN B_USER_AUTHORITY UA ON UI.ROLE_CODE = UA.ROLE_CODE
//	  WHERE UI.USER_ID = 'aaaa';

		public UserVO getUserById(String userId) {
			StringBuilder sql = new StringBuilder();
			UserVO vo = null;

			sql.append("SELECT * FROM B_USER_INFO UI ");
			sql.append(" LEFT JOIN B_USER_AUTHORITY UA ON UI.ROLE_CODE = UA.ROLE_CODE ");
			sql.append("  WHERE UI.USER_ID = ? ");
			
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
