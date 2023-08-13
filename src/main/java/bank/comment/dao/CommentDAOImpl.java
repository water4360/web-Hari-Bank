package bank.comment.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import bank.comment.vo.CommentVO;

@Repository
public class CommentDAOImpl implements CommentDAO{

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public void insertComment(CommentVO vo) {
		session.insert("comment.dao.CommentDAO.insert", vo);
	}

	@Override
	public List<CommentVO> selectAllComment(int boardNo) {
		List<CommentVO> list = session.selectList("comment.dao.CommentDAO.selectAll", boardNo);
		return list;
	}

}



