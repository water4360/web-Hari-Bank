package controller.transaction;

import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.account.AccountVO;
import bank.product.DepositVO;
import bank.transaction.TransactionVO;
import bank.user.UserVO;
import controller.BasicController;

public class InquiryDetailController extends BasicController {
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		session = request.getSession();
		System.out.println("계좌상세조회 진입");
		
		String no = request.getParameter("accountNo");
//		String code = request.getParameter("productCode");
		
		
		// 로그인 안된 경우
        if (session.getAttribute("loginUser") == null) {
        	String prevBtn = "inquiryDetail";
        	session.setAttribute("prevBtn", prevBtn);
        	
            // 로그인 페이지로 리다이렉션
//            return request.getContextPath()+"login.do";
        	return "login.do";
        } else {
        	AccountVO account = daoService.getAccountInfo(no);
        	DepositVO deposit = daoService.getDepositInfo(no);
        	
        	//자릿수 표기 + 원 붙이기
        	long totalBalance = Long.valueOf(account.getBalance());
        	NumberFormat numFormat = NumberFormat.getInstance(Locale.KOREA);
        	String formattedTotalBalance = numFormat.format(totalBalance) + "원";
        	
        	System.out.println(formattedTotalBalance);
        	
        	//조회시각
        	LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter datetimeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedNow = now.format(datetimeFormat);
            
            //거래내역
            List<TransactionVO> transList = daoService.getTransactionList(no);
        	
            //계좌객체, 자릿수표기된 잔액, 조회시각, 거래내역 등록 
        	request.setAttribute("account", account);
        	request.setAttribute("deposit", deposit);
        	request.setAttribute("formattedTotalBalance", formattedTotalBalance);
        	request.setAttribute("formattedNow", formattedNow);
        	request.setAttribute("transactionList", transList);
		}
		return "/jsp/transaction/inquiryDetail.jsp";
	}

}
