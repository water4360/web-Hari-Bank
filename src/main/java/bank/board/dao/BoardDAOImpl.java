package bank.board.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import bank.board.vo.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<BoardVO> selectAllBoard() {
		//DBTest에서 JUnit으로 테스트 완료한 메소드 그대로 복붙해오면 되는 것!
		List<BoardVO> list = session.selectList("board.dao.BoardDAO.selectAllBoard");
		return list;
	}

	@Override
	public BoardVO selectBoardByNo(int no) {
		BoardVO vo = session.selectOne("board.dao.BoardDAO.selectBoardByNo", no);
		return vo;
	}

	@Override
	public void insertBoard(BoardVO vo) {
		session.insert("board.dao.BoardDAO.insertBoard", vo);
		
	}

}
