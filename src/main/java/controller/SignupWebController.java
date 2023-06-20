package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SignupWebController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		return "/jsp/web-signup.jsp";
	}

}
