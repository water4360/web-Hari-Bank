package bank.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bank.board.dao.BoardDAO;
import bank.board.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO dao;
	
	@Override
	public List<BoardVO> getAllBoardList() {
		List<BoardVO> list = dao.selectAllBoard();
		return list;
	}

	@Override
	public BoardVO getOneBoard(int no) {
		BoardVO vo = dao.selectBoardByNo(no);
		return vo;
	}

	@Override
	public void addBoard(BoardVO vo) {
		dao.insertBoard(vo);
	}

}
