package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreateAccountController extends BasicController{
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("계좌생성Ctrl 진입");
		return "/jsp/create-account.jsp";
	}

}
