package bank.board.service;

import java.util.List;

import bank.board.vo.BoardVO;

/**
 * 주문현황
 * 상품테이블, 회원테이블 
 */

public interface BoardService {

	/**
	 * 전체 게시글 조회
	 */
	public List<BoardVO> getAllBoardList();
	
	/**
	 * 게시글 상세조회 
	 */
	public BoardVO getOneBoard(int no);
	
	/**
	 * 게시글 등록
	 */
	public void addBoard(BoardVO vo);
	
	/**
	 * 조회수 증가
	 */
	public void increaseViewCnt(int no);
	
	/**
	 * 답글 등록
	 */
	public void addBoardReply(int no);
}

