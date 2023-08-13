package bank.comment.dao;

import java.util.List;

import bank.comment.vo.CommentVO;

public interface CommentDAO {
	
	/**
	 * 댓글등록
	 * @param vo
	 */
	void insertComment(CommentVO vo);
	
	/**
	 * 해당 게시글의 전체 댓글 불러오기
	 * @param boardNo 게시물번호
	 * @return 전체댓글목록
	 */
	List<CommentVO> selectAllComment(int boardNo);
}
