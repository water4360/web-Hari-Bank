package controller.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.PostDAO;
import board.PostVO;
import controller.BasicController;
import controller.Controller;

public class QnADetailsController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		
		int no = Integer.parseInt(request.getParameter("no"));
		
		PostDAO dao = new PostDAO();
		PostVO vo = dao.getPost(no);
		
		System.out.println("글번호 : " + no);
		
		request.setAttribute("post", vo);
		return "./jsp/board/qna-details.jsp";
	}

}
