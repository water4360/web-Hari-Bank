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
			//사용자입력 거래정보 등록
			
			String senderBank = request.getParameter("senderBankCode");
			String senderAccountNo = request.getParameter("senderAccountNo");
			String receiverBank = request.getParameter("receiverBankCode");
			String receiverAccountNo = request.getParameter("receiverAccountNo");
			String senderMemo = request.getParameter("toMemo");
			String receiverMemo = request.getParameter("fromMemo");
			
			AccountVO account = daoService.getAccountInfo(senderAccountNo);
			
			//현재 계좌 잔고
			String balance = String.valueOf(account.getBalance());
			String amount = request.getParameter("transferAmount");
			
			System.out.printf("보내는은행 : %s, 보내는계좌 : %s, 받는은행 : %s, 받는계좌 : %s, 금액 : %s,\n"
					+ " 현재잔고 : %s, 보내는메모 : %s, 내통장메모 : %s",
					senderBank, senderAccountNo, receiverBank, receiverAccountNo, amount, 
					balance, senderMemo, receiverMemo);
			
			TransactionVO vo = new TransactionVO();
			vo.setSenderBank(senderBank);
			vo.setSenderAccountNo(senderAccountNo);
			vo.setReceiverBank(receiverBank);
			vo.setReceiverAccountNo(receiverAccountNo);
			vo.setAmount(amount);
			vo.setBalance(balance);
			vo.setToMemo(senderMemo);
			vo.setFromMemo(receiverMemo);
			

			boolean checkReceiver = daoService.isCorrectReceiver(vo.getReceiverBank(), vo.getReceiverAccountNo()); 
			String result = daoService.insertTransactionInfo(vo);
			
			System.out.println("계좌 유효성 체크 : " + checkReceiver);

			request.setAttribute("receiverAccount", checkReceiver);
			request.setAttribute("account", account);
			request.setAttribute("result", result);
			
        	return "/jsp/transaction/transactionResult.jsp";
	}

}
