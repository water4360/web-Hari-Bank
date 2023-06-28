package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CheckAccountPasswordController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		session = request.getSession();
		
		String accountNo = request.getParameter("accountNo");
		String accountPw = request.getParameter("accountPassword");
		System.out.println("계좌번호 넘어오나? " + accountNo);
		System.out.println("계좌비번 넘어오나? " + accountPw);
		
		if(daoService.isCorrectAccountPw(accountNo, accountPw)) {
			request.setAttribute("checkAccountPwResult", "true");
		} else {
			request.setAttribute("checkAccountPwResult", "false");
		}
		return "/jsp/check-jsp/checkAccountPw.jsp";
	}

}
