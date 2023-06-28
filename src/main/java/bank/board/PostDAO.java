package bank.board;

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
//	INSERT INTO B_BOARD(P_NO, P_WRITER, P_TITLE, P_CONTENTS) VALUES(SEQ_QNA_NO.NEXTVAL, 'aaaa', '문의합니다', '내용이 많습니다');
	public int writePost(PostVO vo) {
		int result = 0;
		StringBuilder sql = new StringBuilder();

		sql.append("INSERT INTO B_BOARD(P_NO, P_WRITER, P_TITLE, P_CONTENTS) ");
		sql.append("	 VALUES(SEQ_QNA_NO.NEXTVAL, ?, ?, ?) ");

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
	
	// 공지글 등록 - 이거 시퀀스 형식을 별개로.
//	INSERT INTO B_BOARD(P_NO, P_WRITER, P_TITLE, P_CONTENTS) VALUES(SEQ_NOTICE_NO.NEXTVAL, 'aaaa', '문의합니다', '내용이 많습니다');
	public int writeNotice(PostVO vo) {
		int result = 0;
		StringBuilder sql = new StringBuilder();
		
		sql.append("INSERT INTO B_BOARD(P_NO, P_WRITER, P_TITLE, P_CONTENTS) ");
		sql.append("	 VALUES(SEQ_NOTICE_NO.NEXTVAL, ?, ?, ?) ");
		
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

	//모든 Q&A 리스트
	public List<PostVO> getAllQnas() {
		StringBuilder sql = new StringBuilder();
		List<PostVO> postList = new ArrayList<>();

		sql.append("SELECT * FROM B_BOARD ORDER BY P_NO DESC ");

		try (Connection conn = new ConnectionFactory().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {

			 ResultSet rs = pstmt.executeQuery();

			while(rs.next()) {
				int no = rs.getInt("P_NO");
				String writer = rs.getString("P_WRITER");
				String title = rs.getString("P_TITLE");
				String contents = rs.getString("P_CONTENTS");
				String regDate = rs.getString("P_REG_DATE");
				int viewCnt  = rs.getInt("P_HIT");
				
				PostVO vo = new PostVO(no, writer, title, contents, regDate, viewCnt);
				
				postList.add(vo);
			}
			

		} catch (Exception e) {
			e.printStackTrace();
		}
		return postList;
	}

	//Q&A 상세보기?
	public PostVO getPost(int qno) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM B_BOARD WHERE P_NO = ? ");
		PostVO post = null;

		try (Connection conn = new ConnectionFactory().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			
			 pstmt.setInt(1, qno);
			 
			 ResultSet rs = pstmt.executeQuery();
			 
			if(rs.next()) {
				int no = rs.getInt("P_NO");
				String writer = rs.getString("P_WRITER");
				String title = rs.getString("P_TITLE");
				String contents = rs.getString("P_CONTENTS");
				String regDate = rs.getString("P_REG_DATE");
				int viewCnt  = rs.getInt("P_HIT");
				
				post = new PostVO(no, writer, title, contents, regDate, viewCnt);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return post;
	}

	//개인별 QNA
	public List<PostVO> getQnaListById(String id) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM B_BOARD WHERE P_WRITER = ? ");
		
		PostVO post = null;
		List<PostVO> qnaList = new ArrayList<>();

		try (Connection conn = new ConnectionFactory().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			
			 pstmt.setString(1, id);
			 
			 ResultSet rs = pstmt.executeQuery();
			 
			if(rs.next()) {
				int no = rs.getInt("P_NO");
				String writer = rs.getString("P_WRITER");
				String title = rs.getString("P_TITLE");
				String contents = rs.getString("P_CONTENTS");
				String regDate = rs.getString("P_REG_DATE");
				int viewCnt  = rs.getInt("P_HIT");
				
				post = new PostVO(no, writer, title, contents, regDate, viewCnt);
				qnaList.add(post);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return qnaList;
	}
}
