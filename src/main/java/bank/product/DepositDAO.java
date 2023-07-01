package bank.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.ConnectionFactory;

public class DepositDAO {
	
	
	//계좌로 상품정보 확인
	public DepositVO getDepositInfo(String accountNo) {
		StringBuilder sql = new StringBuilder();
		DepositVO deposit = null;

		int idx = 1;
		sql.append("SELECT UA.ACCOUNT_NO, DE.* ");
		sql.append("FROM B_USER_ACCOUNT UA ");
		sql.append("JOIN B_DEPOSIT DE ON UA.D_PRODUCT_CODE = DE.D_PRODUCT_CODE ");
		sql.append("WHERE UA.ACCOUNT_NO = ?");
		
		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(idx++, accountNo);

			ResultSet rs = pstmt.executeQuery();

			// ID가 존재하면 쿼리를 실행하고
			if (rs.next()) {
				String code = rs.getString("D_PRODUCT_CODE");
				String name = rs.getString("D_PRODUCT_NAME");
				double interest = rs.getDouble("D_INTEREST");
				String saleStatus = rs.getString("D_SALE_STATUS");
				String detail = rs.getString("D_DETAIL");
				
				deposit = new DepositVO(code, name, interest, saleStatus, detail);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return deposit;
	}


	
	
}//end of class
