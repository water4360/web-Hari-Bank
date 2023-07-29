package service.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bank.board.PostDAO;
import bank.board.PostVO;

@Service
public class PostServiceImpl implements PostService {

	@Autowired
	private PostDAO dao;
	
	@Override
	public List<PostVO> getAllQnas() {
		return dao.selectAllPost();
	}

	@Override
	public PostVO getPostByNo(int no) {
		return dao.selectPostByNo(no);
	}

	@Override
	public void addPost(PostVO post) {
		dao.insertPost(post);
	}

}
