package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;
import user.UserVO;

public class LoginProcessController extends BasicController {
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		// 사용자가 로그인할때 입력한 값을 VO에 담아주기
		UserVO vo = new UserVO();
		vo.setId(id);
		vo.setPw(pw);

		UserDAO dao = new UserDAO();
		UserVO user = null;
		session = request.getSession();

		
		// VO에 담아준 걸로 DAO에서 비교해서 일치하는 사용자 정보 가져온게 mem
		if (dao.isCorrectInfo(id, pw)) {
			user = dao.getUserById(id);

			// 그리고 이 user를 session에 UserVO형태 고대로 넘겨줌.
			session.setAttribute("loginUser", user);
			
			System.out.println("회원정보 존재. by LoginController");
			System.out.printf("%s 회원 접속by LoginController\n", id);
			return "main.do";
		} else if (dao.isDuplicated(id)) {
			// 아이디는 존재, 비밀번호가 틀린 경우.
			if (!dao.isCorrectInfo(id, pw)) {
				request.setAttribute("loginFeedback", "비밀번호가 일치하지 않아요");
				return "login.do";
			}
		} else {
			// 아이디없고, 비번도 안맞겠지...
			request.setAttribute("loginFeedback", "일치하는 회원이 없어요");
			return "login.do";
		}
		
		return "main.do";
	}

}
