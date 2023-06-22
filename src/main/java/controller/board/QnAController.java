package controller.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.PostDAO;
import board.PostVO;
import controller.BasicController;

public class QnAController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		PostDAO dao = new PostDAO();
		
		List<PostVO> postList = dao.getAllQnas();
		
		System.out.println("포스트길이 : " + postList.size());
		request.setAttribute("qnas", postList);
		return "./jsp/board/qna.jsp";
	}

}
