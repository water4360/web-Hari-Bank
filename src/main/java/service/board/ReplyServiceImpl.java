package service.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bank.board.ReplyDAO;
import bank.board.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	private ReplyDAO dao;
	
	@Override
	public void addReply(ReplyVO vo) {
		dao.insertReply(vo);
	}

	@Override
	public List<ReplyVO> getReplyList(int boardNo) {
		return dao.selectAllReply(boardNo);
	}

}
