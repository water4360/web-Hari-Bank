package controller.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import bank.board.PostVO;
import service.board.PostService;

@Controller
public class QnAController {
	
	@Autowired
	private PostService postService;

	@GetMapping("/qna")
	public String list(HttpServletRequest request, HttpServletResponse response) {
		List<PostVO> postList = postService.getAllQnas();
		
		System.out.println("포스트길이 : " + postList.size());
		request.setAttribute("qnas", postList);
		return "/board/qna";
	}

	@GetMapping("/qna/detail")
	public String detail(HttpServletRequest request, @RequestParam("no") int no) {
		PostVO vo = postService.getPost(no);
		request.setAttribute("post", vo);
		return "/board/qna/detail";
	}
}
