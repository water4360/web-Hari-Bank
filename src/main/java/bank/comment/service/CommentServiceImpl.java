package bank.comment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bank.comment.dao.CommentDAO;
import bank.comment.vo.CommentVO;

@Service
public class CommentServiceImpl implements CommentService{

	@Autowired
	private CommentDAO dao;
	
	@Override
	public void addComment(CommentVO vo) {
		dao.insertComment(vo);
	}

	@Override
	public List<CommentVO> getCommentList(int boardNo) {
		return dao.selectAllComment(boardNo);
	}

}
