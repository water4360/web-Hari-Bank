package service.board;

import java.util.List;

import bank.board.ReplyVO;

public interface ReplyService {

	public void addReply(ReplyVO vo);
	public List<ReplyVO> getReplyList(int boardNo);
}
