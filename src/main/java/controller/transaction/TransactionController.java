package controller.transaction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.BasicController;

public class TransactionController extends BasicController {
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("이체Ctrl 진입");
		return "/jsp/transaction.jsp";
	}

}