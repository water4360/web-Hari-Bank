package bank.reply.service;

import java.util.List;

import bank.reply.vo.ReplyVO;

public interface ReplyService {

	public void addReply(ReplyVO vo);
	public List<ReplyVO> getReplyList(int boardNo);
}
