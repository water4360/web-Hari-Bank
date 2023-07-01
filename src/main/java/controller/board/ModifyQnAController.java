package controller.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.board.PostVO;
import controller.BasicController;

public class ModifyQnAController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		session = request.getSession();

		int no = Integer.parseInt(request.getParameter("no"));
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String category = request.getParameter("category");

		PostVO post = new PostVO(no, writer, title, contents, category);

		daoService.modifyPost(post);
		return "mypage.do";
	}

}
