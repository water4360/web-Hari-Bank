package controller.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.BasicController;
import controller.Controller;

public class LoginController extends BasicController {
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("로긴Ctrl 진입");
		return "/jsp/login.jsp";
	}

}
