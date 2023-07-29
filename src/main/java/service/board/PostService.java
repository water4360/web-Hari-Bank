package service.board;

import java.util.List;

import bank.board.PostVO;

public interface PostService {

	public List<PostVO> getAllQnas();
	
	public PostVO getPostByNo(int no);

	public void addPost(PostVO post);
}
