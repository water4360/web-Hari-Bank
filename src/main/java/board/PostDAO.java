package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import common.ConnectionFactory;

public class PostDAO {
	// DB연결용
	private Connection conn;
	// 쿼리 실행용
	private PreparedStatement stmt;
	// 쿼리 결과받아오기
	private ResultSet rs;

	// 게시글 등록
	// INSERT INTO B_QNA(Q_NO, USER_ID, Q_TITLE, Q_CONTENTS)
	// VALUES(SEQ_QNA_NO.NEXTVAL, 'aaaa', '제목자리', '내용자리');
	public int writePost(PostVO vo) {
		int result = 0;
		StringBuilder sql = new StringBuilder();

		sql.append("INSERT INTO B_QNA(Q_NO, USER_NAME, Q_TITLE, Q_CONTENTS) ");
		sql.append("	VALUES(SEQ_QNA_NO.NEXTVAL, ?, ?, ?) ");

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(1, vo.getWriter());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getContents());

			result = pstmt.executeUpdate();
			return result; // 1이면 성공

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public List<PostVO> getAllQnas() {
		StringBuilder sql = new StringBuilder();
		List<PostVO> postList = new ArrayList<>();

		sql.append("SELECT * FROM B_QNA ORDER BY Q_NO DESC ");

		try (Connection conn = new ConnectionFactory().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {

			 ResultSet rs = pstmt.executeQuery();

			while(rs.next()) {
				int no = rs.getInt("Q_NO");
				String writer = rs.getString("USER_NAME");
				String title = rs.getString("Q_TITLE");
				String contents = rs.getString("Q_CONTENTS");
				String regDate = rs.getString("Q_REG_DATE");
				int viewCnt  = rs.getInt("Q_HIT");
				
				PostVO vo = new PostVO(no, writer, title, contents, regDate, viewCnt);
				
				postList.add(vo);
			}
			

		} catch (Exception e) {
			e.printStackTrace();
		}
		return postList;
	}

	public PostVO getPost(int qno) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM B_QNA WHERE NO = ? ");
		PostVO post = null;

		try (Connection conn = new ConnectionFactory().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			
			 pstmt.setInt(1, qno);
			 
			 ResultSet rs = pstmt.executeQuery();
			 
			if(rs.next()) {
				int no = rs.getInt("Q_NO");
				String writer = rs.getString("USER_ID");
				String title = rs.getString("Q_TITLE");
				String contents = rs.getString("Q_CONTENTS");
				String regDate = rs.getString("Q_REG_DATE");
				int viewCnt  = rs.getInt("Q_HIT");
				
				post = new PostVO(no, writer, title, contents, regDate, viewCnt);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return post;
	}
}
