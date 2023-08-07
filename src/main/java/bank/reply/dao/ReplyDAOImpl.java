package bank.reply.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import bank.reply.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public void insertReply(ReplyVO vo) {
		session.insert("reply.dao.ReplyDAO.insert", vo);
	}

	@Override
	public List<ReplyVO> selectAllReply(int boardNo) {
		List<ReplyVO> list = session.selectList("reply.dao.ReplyDAO.selectAll", boardNo);
		return list;
	}

}



