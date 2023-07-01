package controller.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.BasicController;

public class DeleteQnAController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		session = request.getSession();

		int no = Integer.parseInt(request.getParameter("no"));
		
		daoService.deletePost(no);
		return "redirect:/mypage.do";
	}

}
