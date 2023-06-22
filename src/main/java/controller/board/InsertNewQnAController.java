package controller.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.PostDAO;
import board.PostVO;
import controller.BasicController;
import user.UserVO;

public class InsertNewQnAController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		
		session = request.getSession();
		
		//로긴유저의 정보는 parameter로 넘기는거X 세션에 저장된 정보를 객체 그대로 가져오는 것
		UserVO vo = (UserVO)session.getAttribute("loginUser");
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String msg = null;
		
		System.out.println("현재 사용자VO : " + vo);
		System.out.println("글제목 : " + title);
		System.out.println("글내용 : " + contents);
		
		PostVO post = new PostVO();
		post.setWriter(vo.getKorName());
		post.setTitle(title);
		post.setContents(contents);
		
		PostDAO dao = new PostDAO();
		
		//글 등록
		if(dao.writePost(post)==0) {
			msg = "등록실패";
			System.out.println(msg + " by InsertNewPostCtrl");
			session.setAttribute("msg", msg);
			return "qna.do";
		} else {
			msg = "등록성공!";
			System.out.println(msg + " by InsertNewPostCtrl");
			session.setAttribute("post", post);
			session.setAttribute("msg", msg);
			return "qna.do";
			//request.getContextPath()+
		}
	}

}
