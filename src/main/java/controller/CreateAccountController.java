package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;

public class CreateAccountController extends BasicController{
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		//세션에 등록된 사용자 정보를 가지고 오기
		request.getParameter("id");
		
		
		
		System.out.println("계좌생성Ctrl 진입");
		return "/jsp/create-account.jsp";
	}

}
