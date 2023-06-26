package bank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.ConnectionFactory;

public class DepositDAO {
	
	
	//코드로 계좌정보 확인
	public DepositVO getDepositInfo(String productCode) {
		StringBuilder sql = new StringBuilder();
		DepositVO vo = null;

		sql.append("SELECT * FROM B_DEPOSIT WHERE D_PRODUCT_CODE = ? ");
		
		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(1, productCode);

			ResultSet rs = pstmt.executeQuery();

			// ID가 존재하면 쿼리를 실행하고
			if (rs.next()) {
				String code = rs.getString("D_PRODUCT_CODE");
				String name = rs.getString("D_PRODUCT_NAME");
				double interest = rs.getDouble("D_INTEREST");
				String saleStatus = rs.getString("D_SALE_STATUS");
				String detail = rs.getString("D_DETAIL");
				
				vo = new DepositVO(code, name, interest, saleStatus, detail);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return vo;
	}


	
	
}//end of class
