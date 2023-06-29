package controller.transaction;

import java.text.NumberFormat;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.account.AccountVO;
import controller.BasicController;

public class CheckCurrentBalanceController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		session = request.getSession();

		// ajax에서 넘겨주는 정보
		String accountNo = request.getParameter("accountNo");
		System.out.println("계좌번호 넘어오니?" + accountNo);

		// dao에서 찾아온 정보
		AccountVO account = daoService.getAccountInfo(accountNo);

		// 있는 계좌 정보라면 계좌조회
		if (account != null) {
			long balance = Long.valueOf(account.getBalance());
			
        	//자릿수 표기 + 원 붙이기
        	NumberFormat numFormat = NumberFormat.getInstance(Locale.KOREA);
        	String formattedTotalBalance = numFormat.format(balance) + "원";
			
			System.out.println("얼마? " + formattedTotalBalance);
			
			session.setAttribute("currentBalance", balance);
			session.setAttribute("balance", formattedTotalBalance);
//			request.setAttribute("account", account);
			
		} else {
			request.setAttribute("msg", "존재하지 않는 계좌번호입니다");
		}

//		return "/jsp/transaction.jsp";
		return "/jsp/check-jsp/currentBalance.jsp";
	}

}
