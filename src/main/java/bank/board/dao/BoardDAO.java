package bank.board.dao;

import java.util.List;

import bank.board.vo.BoardVO;

/**
 * Database에서 게시판과 관련된 CRUD 표준 인터페이스
 * @author User
 */


public interface BoardDAO {

	/**
	 * 전체게시글 조회
	 * @return 조회된 게시글
	 */
	List<BoardVO> selectAllBoard();

	/**
	 * 상세게시글 조회
	 * @return 조회된 게시글
	 */
	BoardVO selectBoardByNo(int no);
	
	/**
	 * 게시글 등록
	 * @param 등록할 게시글
	 */
	void insertBoard(BoardVO vo);
}
