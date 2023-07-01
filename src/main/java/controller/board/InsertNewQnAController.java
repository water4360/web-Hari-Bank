package controller.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.board.PostVO;
import bank.user.UserVO;
import controller.BasicController;

public class InsertNewQnAController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {

		session = request.getSession();

		// 로긴유저의 정보는 parameter로 넘기는거X 세션에 저장된 정보를 객체 그대로 가져오는 것
		UserVO vo = (UserVO) session.getAttribute("loginUser");

		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String category = request.getParameter("category");

		String msg = null;

		System.out.println("현재 사용자VO : " + vo);

		System.out.println("글쓴이 : " + writer);
		System.out.println("글제목 : " + title);
		System.out.println("글내용 : " + contents);
		System.out.println("카테고리 : " + category);

		PostVO post = new PostVO();
		post.setWriter(writer);
		post.setTitle(title);
		post.setContents(contents);
		post.setCategory(category);

		String prevBtn = null;
		if (session.getAttribute("prevBtn") != null) {
			prevBtn = (String) session.getAttribute("prevBtn");
			System.out.println("prevBtn : " + prevBtn);
		}
		// 글 등록
		if (daoService.writePost(post) == 0) {
			msg = "등록실패";
			System.out.println(msg + " by InsertNewPostCtrl");
			session.setAttribute("msg", msg);
			return "qna.do";
		} else {
			msg = "등록성공!";
			System.out.println(msg + " by InsertNewPostCtrl");
			session.setAttribute("post", post);
			session.setAttribute("msg", msg);

			if (prevBtn.equals("mypage")) {
				return "redirect:/mypage.do";
			} else {
				return "redirect:/qna.do";
			}
		}
	}

}
