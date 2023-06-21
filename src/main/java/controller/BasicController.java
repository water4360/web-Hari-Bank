package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.ConnectionFactory;
import common.UserService;


public abstract class BasicController implements Controller {

	// controller들 묶어주기 + Service 상속용
	protected HttpSession session;
	protected ConnectionFactory conn;
	protected UserService us;
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		return null;
	}

}
