package controller.transaction;

import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.account.AccountVO;
import bank.user.UserVO;
import controller.BasicController;

public class InquiryOpenbankController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		session = request.getSession();
		System.out.println("오픈뱅킹조회Ctrl 진입");
		
		// 로그인 안된 경우
		if(session.getAttribute("loginUser") == null) {
        	String prevBtn = "inquiryOpenbank";
        	session.setAttribute("prevBtn", prevBtn);
        	
            // 로그인 페이지로 포워딩
            return "login.do";
		} else {
			
			//사용자 이름,생년월일,폰번호가 일치하는 사용자의
			//각 db에서의 계좌리스트와 잔액정보를 출력해야 함.
			//all리스트에 accountVO
        	List<AccountVO> JHaccountList = daoService.getOpenbankAccountListById("JH","j.hyun123@kakao.comK");
        	List<AccountVO> BGHaccountList = daoService.getOpenbankAccountListById("BGH", "jh111");
        	List<AccountVO> HJaccountList = daoService.getOpenbankAccountListById("H.J", " j.hyun123@kakao.com");
        	
        	//보유계좌 총합계
        	long totalBalance = 0;
        	
        	//총 보유계좌 수
        	int allAccountCnt = 0;
        	
        	if(JHaccountList.size()!=0) {
        		for(AccountVO vo: JHaccountList) {
            		totalBalance += vo.getBalance();
            	}
        		allAccountCnt += JHaccountList.size();
        	} 
        	if(BGHaccountList.size()!=0) {
        		for(AccountVO vo: BGHaccountList) {
            		totalBalance += vo.getBalance();
            	}
        		allAccountCnt += BGHaccountList.size();

        	} 
        	if(HJaccountList.size()!=0) {
        		for(AccountVO vo: HJaccountList) {
            		totalBalance += vo.getBalance();
            	}
        		allAccountCnt += HJaccountList.size();
        	}

        	
        	//자릿수 표기 + 원 붙이기
        	NumberFormat numFormat = NumberFormat.getInstance(Locale.KOREA);
        	String formattedTotalBalance = numFormat.format(totalBalance) + "원";
        	
        	//조회기준일시 표기
        	LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter datetimeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedNow = now.format(datetimeFormat);
            
            System.out.println("JHaccountList " + JHaccountList.size());
            System.out.println("BGHaccountList " + BGHaccountList.size());
            System.out.println("HJaccountList " + HJaccountList.size());
        	
            session.setAttribute("JHaccountList", JHaccountList);
            session.setAttribute("BGHaccountList", BGHaccountList);
        	session.setAttribute("HJaccountList", HJaccountList);
        	session.setAttribute("formattedTotalBalance", formattedTotalBalance);
        	session.setAttribute("formattedNow", formattedNow);
        	
        	System.out.println("현재 로그인: " + (UserVO) session.getAttribute("loginUser"));
		}
		
		return "/jsp/transaction/inquiryOpenbank.jsp";
	}

}
