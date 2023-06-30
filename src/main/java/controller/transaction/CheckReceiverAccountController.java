package controller.transaction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.BasicController;

public class CheckReceiverAccountController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		session = request.getSession();

		// ajax에서 넘겨주는 정보
		String sender = request.getParameter("sender");
		String bankCode = request.getParameter("bankCode");
		String receiver = request.getParameter("accountNo");
		System.out.println("받는 계좌번호 : " + receiver);

		if (daoService.isCorrectReceiver(bankCode, receiver)) {
			
			if(sender.equals(receiver)) {
				request.setAttribute("checkReceiverAccountResult", "duplicated");
			} else {
				request.setAttribute("checkReceiverAccountResult", "correct");
			}
		} else {
			request.setAttribute("checkReceiverAccountResult", "incorrect");
		}

		return "/jsp/check-jsp/checkReceiver.jsp";
	}

}
