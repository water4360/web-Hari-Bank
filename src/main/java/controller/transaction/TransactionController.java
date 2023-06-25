package controller.transaction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.BasicController;
import user.UserVO;

public class TransactionController extends BasicController {
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("이체Ctrl 진입");
		
		// 로그인 안된 경우
        if (session.getAttribute("loginUser") == null) {
        	String prevBtn = "transaction";
        	session.setAttribute("prevBtn", prevBtn);
        	
            // 로그인 페이지로 리다이렉션
            return "login.do";
        } else {
        	System.out.println("현재 로그인: " + (UserVO) request.getAttribute("loginUser"));
		}
		
		return "/jsp/transaction.jsp";
	}

}
