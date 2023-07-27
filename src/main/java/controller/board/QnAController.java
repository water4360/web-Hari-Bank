package controller.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

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
		return "board/qna";
	}

	@GetMapping("/qna/{no}")
	public ModelAndView detail(@PathVariable("no") int no, HttpServletRequest request) {
		System.out.println("qnaDetail 진입" + no);
		PostVO vo = postService.getPostByNo(no);
		
		//보여줄 view는 board/qna-detail.jsp
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/qna-detail");
		mav.addObject("post", vo);
		
		return mav;
	}
}
