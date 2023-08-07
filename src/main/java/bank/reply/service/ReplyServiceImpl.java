package bank.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bank.reply.dao.ReplyDAO;
import bank.reply.vo.ReplyVO;

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
