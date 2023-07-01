package controller.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.user.UserVO;
import controller.BasicController;

public class UpdateMyInfoController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("내정보 변경Ctrl 진입");
		session = request.getSession();
		
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		
		// 로그인 안된 경우
		if (session.getAttribute("loginUser") == null) {
		
        	String prevBtn = "mypage";
        	session.setAttribute("prevBtn", prevBtn);
        	
            // 로그인 페이지로 리다이렉션
            return "login.do";
        } else {
        	String id = request.getParameter("id");
        	UserVO user = new UserVO();
        	user.setId(id);
        	user.setPhone(phone);
        	user.setEmail(email);
        	
        	System.out.println("입력받은 user 정보 : " + user);
        	
        	if(daoService.updateMyInfo(user)==1) {
        		System.out.println("개인정보변경 성공(DAO)");
        		
        		//등록에 성공하고 나면 새로운 유저정보를 다시 session에 덮어쓰기.
        		user = daoService.getUserById(id);
        		session.setAttribute("loginUser", user);
        	}
        	
        	System.out.println("개인정보변경 실패(DAO)");
        	
		}
		
		return "redirect:/mypage.do";
	}
}
