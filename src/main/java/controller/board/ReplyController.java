package controller.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import bank.board.ReplyVO;
import service.board.ReplyService;

@RestController
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;

	@PostMapping("/reply")
	public void addReply(ReplyVO vo) {
//		System.out.println(vo); //테스트용
		replyService.addReply(vo);
	}
	
	@GetMapping("/reply/{boardNo}")
	public List<ReplyVO> getReplyList(@PathVariable("boardNo") int boardNo){
		return replyService.getReplyList(boardNo);
	}
}


		
		