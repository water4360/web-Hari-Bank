package bank.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import common.ConnectionFactory;

public class PostDAO {

	// 게시글 등록
//	INSERT INTO B_BOARD(NO, WRITER, TITLE, CONTENT, CATEGORY) VALUES(SEQ_QNA_NO.NEXTVAL, 'aaaa', '문의합니다', '내용이 많습니다', 'QNA');
	public int writePost(PostVO vo) {
		int result = 0;
		StringBuilder sql = new StringBuilder();

		int idx = 1;
		sql.append("INSERT INTO B_BOARD(NO, WRITER, TITLE, CONTENT, CATEGORY) ");
		sql.append("	 VALUES(SEQ_QNA_NO.NEXTVAL, ?, ?, ?, ?) ");

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(idx++, vo.getWriter());
			pstmt.setString(idx++, vo.getTitle());
			pstmt.setString(idx++, vo.getContents());
			pstmt.setString(idx++, vo.getCategory());

			result = pstmt.executeUpdate();
			return result; // 1이면 성공

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	// 공지글 등록 - 이거 시퀀스 형식을 별개로.
//	INSERT INTO B_BOARD(NO, WRITER, TITLE, CONTENT) VALUES(SEQ_NOTICE_NO.NEXTVAL, 'aaaa', '문의합니다', '내용이 많습니다');
	public int writeNotice(PostVO vo) {
		int result = 0;
		StringBuilder sql = new StringBuilder();
		
		sql.append("INSERT INTO B_BOARD(NO, WRITER, TITLE, CONTENT) ");
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

		sql.append("SELECT * FROM B_BOARD ORDER BY NO DESC ");

		try (Connection conn = new ConnectionFactory().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {

			 ResultSet rs = pstmt.executeQuery();

			while(rs.next()) {
				int no = rs.getInt("NO");
				String writer = rs.getString("WRITER");
				String title = rs.getString("TITLE");
				String content = rs.getString("CONTENT");
				String regDate = rs.getString("REG_DATE");
				int viewCnt  = rs.getInt("VIEW_CNT");
				
				PostVO vo = new PostVO(no, writer, title, content, regDate, viewCnt);
				
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
		sql.append("SELECT * FROM B_BOARD WHERE NO = ? ");
		PostVO post = null;

		int idx = 1;
		try (Connection conn = new ConnectionFactory().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			
			 pstmt.setInt(idx++, qno);
			 
			 ResultSet rs = pstmt.executeQuery();
			 
			if(rs.next()) {
				int no = rs.getInt("NO");
				String writer = rs.getString("WRITER");
				String title = rs.getString("TITLE");
				String content = rs.getString("CONTENT");
				String regDate = rs.getString("REG_DATE");
				int viewCnt  = rs.getInt("VIEW_CNT")+1;
				
				post = new PostVO(no, writer, title, content, regDate, viewCnt);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		modifyPost(post);
		return post;
	}

	//Q&A 업데이트
	public void modifyPost(PostVO post) {
		StringBuilder sql = new StringBuilder();
		sql.append("UPDATE B_BOARD SET TITLE = ?, CONTENT = ?, VIEW_CNT = ? WHERE NO = ? ");
		
		int idx = 1;
		try(Connection conn = new ConnectionFactory().getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			
			pstmt.setString(idx++, post.getTitle());
			pstmt.setString(idx++, post.getContents());
			pstmt.setInt(idx++, post.getViewCnt());
			pstmt.setInt(idx++, post.getNo());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//Q&A 삭제
	public void deletePost(int no) {
		StringBuilder sql = new StringBuilder();
		sql.append("DELETE B_BOARD WHERE NO = ? ");
		
		int idx = 1;
		try(Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			
			pstmt.setInt(idx++, no);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	//개인별 QNA
	public List<PostVO> getQnaListById(String id) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM B_BOARD WHERE WRITER = ? ORDER BY NO DESC ");
		
		PostVO post = null;
		List<PostVO> qnaList = new ArrayList<>();

		try (Connection conn = new ConnectionFactory().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			
			 pstmt.setString(1, id);
			 
			 ResultSet rs = pstmt.executeQuery();
			 
			while(rs.next()) {
				int no = rs.getInt("NO");
				String writer = rs.getString("WRITER");
				String title = rs.getString("TITLE");
				String content = rs.getString("CONTENT");
				String regDate = rs.getString("REG_DATE");
				int viewCnt  = rs.getInt("VIEW_CNT");
				
				post = new PostVO(no, writer, title, content, regDate, viewCnt);
				qnaList.add(post);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return qnaList;
	}


}
