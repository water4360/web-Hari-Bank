package bank.comment.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import bank.comment.service.CommentService;
import bank.comment.vo.CommentVO;

@RestController
public class CommentController {
	
	@Autowired
	private CommentService commentService;

	@PostMapping("/comment")
	public void addComment(CommentVO vo) {
//		System.out.println(vo); //테스트용
		commentService.addComment(vo);
	}
	
	@GetMapping("/comment/{boardNo}")
	public List<CommentVO> getCommentList(@PathVariable("boardNo") int boardNo){
		return commentService.getCommentList(boardNo);
	}
}


		
		