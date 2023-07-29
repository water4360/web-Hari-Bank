package bank.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import common.ConnectionFactory;

@Repository
public class PostDAO {
	
	@Autowired
	private SqlSessionTemplate session;

	// 게시글 등록
//	INSERT INTO B_BOARD(P_NO, P_WRITER, P_TITLE, P_CONTENTS, P_CATEGORY) VALUES(SEQ_QNA_NO.NEXTVAL, 'aaaa', '문의합니다', '내용이 많습니다', 'QNA');
	public int insertPost(PostVO vo) {
		int result = session.insert("bank.board.PostDAO.insertPost", vo);
		return result;
	}
	
	//모든 Q&A 리스트
	public List<PostVO> selectAllPost() {
		System.out.println("session 있니? : " + session);
		List<PostVO> postList = session.selectList("bank.board.PostDAO.selectAllPost");
		return postList;
	}

	//Q&A 상세보기?
	public PostVO selectPostByNo(int qno) {
		PostVO post = session.selectOne("bank.board.PostDAO.selectPostByNo", qno);
//		modifyPost(post); //조회수+1?
		return post;
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



	//Q&A 업데이트
	public void modifyPost(PostVO post) {
		StringBuilder sql = new StringBuilder();
		sql.append("UPDATE B_BOARD SET P_TITLE = ?, P_CONTENTS = ?, P_HIT = ? WHERE P_NO = ? ");
		
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
		sql.append("DELETE B_BOARD WHERE P_NO = ? ");
		
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
		sql.append("SELECT * FROM B_BOARD WHERE P_WRITER = ? ORDER BY P_NO DESC ");
		
		PostVO post = null;
		List<PostVO> qnaList = new ArrayList<>();

		try (Connection conn = new ConnectionFactory().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			
			 pstmt.setString(1, id);
			 
			 ResultSet rs = pstmt.executeQuery();
			 
			while(rs.next()) {
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
