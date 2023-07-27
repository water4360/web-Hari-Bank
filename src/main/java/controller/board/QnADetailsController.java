package controller.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;

import bank.board.PostDAO;
import bank.board.PostVO;
import controller.BasicController;

@Controller
public class QnADetailsController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		
		int no = Integer.parseInt(request.getParameter("no"));
		
		PostDAO dao = new PostDAO();
		PostVO vo = dao.selectPostByNo(no);
		
		System.out.println("글번호 : " + vo);
		
		request.setAttribute("post", vo);
		return "./jsp/board/qna-details.jsp";
	}

}
