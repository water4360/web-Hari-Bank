package controller.transaction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.account.AccountVO;
import bank.transaction.TransactionVO;
import controller.BasicController;

public class TransactionProcessController extends BasicController {
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
			session = request.getSession();
			String senderAccountNo = request.getParameter("senderAccountNo");
			String accountPw = request.getParameter("accountPassword");
			String receiverBankCode = request.getParameter("receiverBankCode");
			String receiverAccountNo = request.getParameter("receiverAccountNo");
			
			AccountVO account = daoService.getAccountInfo(senderAccountNo);

			// 있는 계좌 정보라면 계좌조회
			long currentBalance = account.getTotalBalance();
			
			long amount = Long.valueOf(request.getParameter("transferAmount"));
        	
			
			System.out.printf("보내는계좌 : %s, 계좌비번 : %s, 받는은행 : %s, 받는계좌 : %s, 금액 : %d\n",
					senderAccountNo, accountPw, receiverBankCode, receiverAccountNo, amount);
			
			//헐 비밀번호도 집어넣어야지!
			String result = daoService.insertTransactionInfo("0758", senderAccountNo, accountPw, 
					receiverBankCode, receiverAccountNo, amount, currentBalance);
//			daoService.transferMoney(senderAccountNo, accountPw, receiverAccountNo, amount);
			request.setAttribute("account", account);
			request.setAttribute("result", result);
			
        	return "/jsp/transaction/transactionResult.jsp";
	}

}
