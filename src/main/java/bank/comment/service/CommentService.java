package bank.comment.service;

import java.util.List;

import bank.comment.vo.CommentVO;

public interface CommentService {

	public void addComment(CommentVO vo);
	public List<CommentVO> getCommentList(int boardNo);
}
