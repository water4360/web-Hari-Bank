package controller.transaction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.BasicController;
import tranjaction.TransactionVO;

public class TransactionProcessController extends BasicController {
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
			String senderAccountNo = request.getParameter("senderAccountNo");
			String accountPw = request.getParameter("accountPassword");
			String receiverBankCode = request.getParameter("receiverBankCode");
			String receiverAccountNo = request.getParameter("receiverAccountNo");
			long amount = Long.valueOf(request.getParameter("transferAmount"));
        	
			//헐 비밀번호도 집어넣어야지!
			daoService.transferMoney(senderAccountNo, receiverAccountNo, amount);
			String result = daoService.insertTransactionInfo("0758", senderAccountNo, receiverBankCode, receiverAccountNo, amount);
			
			
        	return "/jsp/이체완료결과.jsp";
	}

}
