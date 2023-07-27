package bank.board;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAOImpl implements ReplyDAO{

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public void insertReply(ReplyVO vo) {
		session.insert("bank.board.ReplyDAO.insert", vo);
	}

	@Override
	public List<ReplyVO> selectAllReply(int boardNo) {
		List<ReplyVO> list = session.selectList("bank.board.ReplyDAO.selectAll", boardNo);
		return list;
	}

}



