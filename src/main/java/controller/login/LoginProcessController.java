package controller.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.user.UserVO;
import controller.BasicController;

public class LoginProcessController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		// 사용자가 로그인할때 입력한 값을 VO에 담아주기
		UserVO vo = new UserVO();
		vo.setId(id);
		vo.setPw(pw);

		UserVO user = null;
		UserVO addr = null;
		session = request.getSession();

		// 회원이 있는 경우
		if (daoService.isCorrectInfo(id, pw)) {
			user = daoService.getUserById(id);
			addr = daoService.getUserAddressById(id);

			// 그리고 이 user를 session에 UserVO형태 고대로 넘겨줌.
			session.setAttribute("loginUser", user);
			session.setAttribute("userAddr", addr);
			System.out.printf("%s 회원 접속. by LoginController\n", id);

			String prevBtn = null;
			// 이전 버튼 정보 가져오기
			if (session.getAttribute("prevBtn") != null) {
				prevBtn = (String) session.getAttribute("prevBtn");
				System.out.println("prevBtn : " + prevBtn);
			} else {
				// 직전버튼 없으면 걍 메인 가는거지.
				return "main.do";
			}

			// 직전메뉴로 리다이렉션
			if (prevBtn.equals("inquiry")) {
				return "redirect:/inquiry.do";
			} else if (prevBtn.equals("transaction")) {
				return "redirect:/transaction.do";
			} else if (prevBtn.equals("mypage")) {
				return "redirect:/mypage.do";
			} else if (prevBtn.equals("inquiryDetail")) {
				return "redirect:/inquiry.do";
			} else if (prevBtn.equals("create-account")) {
				return "redirect:/create-account.do";
			}
			
			
		} else if (daoService.isDuplicated(id)) {
			// 아이디는 존재, 비밀번호가 틀린 경우.
			if (!daoService.isCorrectInfo(id, pw)) {
				request.setAttribute("loginFeedback", "비밀번호가 일치하지 않아요");
				return "login.do";
			}
		} else {
			// 아이디없고, 비번도 안맞겠지...
			request.setAttribute("loginFeedback", "일치하는 회원이 없어요");
			return "login.do";
		}
		
		return "redirect:/login.do";
	}

}
