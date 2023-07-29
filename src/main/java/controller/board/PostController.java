package controller.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import bank.board.PostVO;
import bank.user.UserVO;
import service.board.PostService;

@Controller
public class PostController {
	
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
	
	@GetMapping("/qna/write")
	public void writeForm(Model model, HttpSession session) {
		PostVO post = new PostVO();
		UserVO user = (UserVO)session.getAttribute("loginUser");
		if(user!=null) {
			//로그인이 되어 있다면
			post.setWriter(user.getId());
		}
		model.addAttribute("post", post);
	}
	
	@PostMapping("/qna/write")
	public String write(PostVO post, BindingResult result) {
		System.out.println("post 들어오나요? : " + post);
		
		if(result.hasErrors()) {
			System.out.println("입력시 에러발생");
			return "qna/write";
		}
			System.out.println("입력문제 없음!");
			postService.addPost(post);
			
			//redirect 없이 "/qna"로만 리턴하면 url이 계속 write임...
			return "redirect:/qna";
	}
	
}
