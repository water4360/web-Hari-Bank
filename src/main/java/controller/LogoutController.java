package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LogoutController extends BasicController {
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		session = request.getSession();
		session.invalidate();
		
		return "./jsp/logout.jsp";
	}

}
