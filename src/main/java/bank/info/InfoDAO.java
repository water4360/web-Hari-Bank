package bank.info;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import common.ConnectionFactory;

public class InfoDAO {
	
	//모든 은행정보 확인
	public List<InfoVO> getBankList() {
			StringBuilder sql = new StringBuilder();
			InfoVO bank = null;
			List<InfoVO> bankList = new ArrayList<>();

			sql.append("SELECT * FROM B_BANK_INFO ");
			
			try (Connection conn = new ConnectionFactory().getConnection();
					PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {

				ResultSet rs = pstmt.executeQuery();

				// ID가 존재하면 쿼리를 실행하고
				while (rs.next()) {
					String code = rs.getString("B_BANK_CODE");
					String name = rs.getString("B_BANK_NAME");
					
					bank = new InfoVO(code, name);
					bankList.add(bank);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

			return bankList;
		}
	
	
}


