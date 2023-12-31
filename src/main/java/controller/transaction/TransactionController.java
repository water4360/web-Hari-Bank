package controller.transaction;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.account.AccountVO;
import bank.info.InfoVO;
import bank.user.UserVO;
import controller.BasicController;

public class TransactionController extends BasicController {
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("이체Ctrl 진입");
		session = request.getSession();
		
		String prevBtn = "transaction";
		session.setAttribute("prevBtn", prevBtn);
		
		// 로그인 안된 경우
        if (session.getAttribute("loginUser") == null) {
            // 로그인 페이지로 포 워 딩!
            return "login.do";
        } else {
        	UserVO user = (UserVO)session.getAttribute("loginUser");
        	System.out.println("현재 로그인: " + user);
        	
        	String id = user.getId();
        	
        	//계좌목록 가져오기
        	List<AccountVO> accountList = daoService.getAccountListById(id);
        	List<InfoVO> bankList = daoService.getBankList();
        	
        	System.out.println("계좌리스트 : " + accountList.size());
        	String selectedAccount = request.getParameter("accountNo");

        	System.out.println("선택된 계좌 : " + selectedAccount);
        	//개설된 계좌가 없으면
        	if(accountList.size()!=0) {
        		//계좌리스트 불러오고 은행목록 가져오기
        		request.setAttribute("selectedAccount", selectedAccount);
        		session.setAttribute("myAccountList", accountList);
        		session.setAttribute("bankList", bankList);
        		return "/jsp/transaction/transaction.jsp";
        	} else {
        		//개설계좌가 없으면 계좌 개설 화면으로 돌아가기.
        		//원래라면 알림을 보여줘야.................
        		return "redirect:/create-account.do";
        	}
		}
	}

}
