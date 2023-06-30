package controller;

import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.account.AccountVO;
import bank.user.UserVO;

public class InquiryOpenbankController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		session = request.getSession();
		System.out.println("오픈뱅킹조회Ctrl 진입");
		
		// 로그인 안된 경우
		if(session.getAttribute("loginUser") == null) {
        	String prevBtn = "inquiry";
        	session.setAttribute("prevBtn", prevBtn);
        	
            // 로그인 페이지로 포워딩
            return "login.do";
		} else {
			
			String id = ((UserVO)session.getAttribute("loginUser")).getId();
        	List<AccountVO> accountList = daoService.getAccountListById(id);
        	 
        	//보유계좌 총합계
        	long totalBalance = 0;
        	for(AccountVO vo: accountList) {
        		totalBalance += vo.getBalance();
        	}
        	//자릿수 표기 + 원 붙이기
        	NumberFormat numFormat = NumberFormat.getInstance(Locale.KOREA);
        	String formattedTotalBalance = numFormat.format(totalBalance) + "원";
        	
        	//조회기준일시 표기
        	LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter datetimeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedNow = now.format(datetimeFormat);
        	
        	session.setAttribute("accountList", accountList);
        	session.setAttribute("accountCount", accountList.size());
        	session.setAttribute("formattedTotalBalance", formattedTotalBalance);
        	session.setAttribute("formattedNow", formattedNow);
        	
        	System.out.println("현재 로그인: " + (UserVO) session.getAttribute("loginUser"));
		}
		
		return "/jsp/transaction/inquiry-op.jsp";
	}

}
