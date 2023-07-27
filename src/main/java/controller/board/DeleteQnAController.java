package controller.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import controller.BasicController;

@Controller
public class DeleteQnAController extends BasicController {

	@PostMapping("/qna")
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		session = request.getSession();

		int no = Integer.parseInt(request.getParameter("no"));
		
		daoService.deletePost(no);
		return "redirect:/mypage";
	}

}
