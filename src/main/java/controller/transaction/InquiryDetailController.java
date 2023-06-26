package controller.transaction;

import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.DepositVO;
import controller.BasicController;
import user.AccountVO;
import user.UserVO;

public class InquiryDetailController extends BasicController {
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		session = request.getSession();
		System.out.println("계좌상세조회 진입");
		
		String no = request.getParameter("accountNo");
		String code = request.getParameter("productCode");
		
		
		// 로그인 안된 경우
        if (session.getAttribute("loginUser") == null) {
        	String prevBtn = "inquiryDetail";
        	session.setAttribute("prevBtn", prevBtn);
        	
            // 로그인 페이지로 리다이렉션
//            return request.getContextPath()+"login.do";
        	return "login.do";
        } else {
        	String id = ((UserVO)session.getAttribute("loginUser")).getId();
        	AccountVO account = daoService.getAccountInfo(no);
        	DepositVO deposit = daoService.getDepositInfo(code);
        	
        	//자릿수 표기 + 원 붙이기
//        	String totalBalance = String.valueOf(account.getTotalBalance());
//        	System.out.println("long 계좌잔액을 스트링.valueof로 " + totalBalance);
        	long totalBalance = account.getTotalBalance();
        	NumberFormat numFormat = NumberFormat.getInstance(Locale.KOREA);
        	String formattedTotalBalance = numFormat.format(totalBalance) + "원";
        	
        	System.out.println(formattedTotalBalance);
        	
        	//조회시각
        	LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter datetimeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedNow = now.format(datetimeFormat);
        	
            //계좌객체, 자릿수표기된 잔액, 조회시각 등록 
        	session.setAttribute("account", account);
        	session.setAttribute("deposit", deposit);
        	session.setAttribute("formattedTotalBalance", formattedTotalBalance);
        	session.setAttribute("formattedNow", formattedNow);
        	
        	System.out.println("현재 로그인: " + (UserVO) request.getAttribute("loginUser"));
		}
		return "/jsp/inquiryDetail.jsp";
	}

}
