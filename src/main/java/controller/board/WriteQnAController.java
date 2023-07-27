package controller.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import controller.BasicController;

@Controller
public class WriteQnAController extends BasicController {

	@GetMapping("/write-qna")
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		return "/board/write-qna";
	}

}
