package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
			return "main.jsp";
	}
}
