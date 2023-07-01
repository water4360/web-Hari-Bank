package controller.account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.BasicController;

public class CreateAccountController extends BasicController{
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		session = request.getSession();
		
		// 로그인 안된 경우
        if (session.getAttribute("loginUser") == null) {
        	String prevBtn = "create-account";
        	session.setAttribute("prevBtn", prevBtn);
        	
            // 로그인 페이지로 포워딩
            return "login.do";
        } else {
        	System.out.println("계좌생성Ctrl 진입");
        	return "/jsp/create-account.jsp";
        }
	}

}
