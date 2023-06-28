package controller.account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.account.AccountVO;
import bank.user.UserVO;
import controller.BasicController;

public class CreateAccountProcessController extends BasicController{
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String accountPw = request.getParameter("account-pw");
		
		session = request.getSession();
		
		UserVO vo = null;
		AccountVO avo = new AccountVO();
		String userId = null;
		
		System.out.println("신규유저 : " + session.getAttribute("newUser"));
		System.out.println("로긴유저 : " + session.getAttribute("loginUser"));
		
		//신규가입회원이면 신규회원정보를 얻어와서
		if(session.getAttribute("loginUser")==null) {
			vo = (UserVO)session.getAttribute("newUser");
			userId = vo.getId();
			avo.setUserId(userId);
			avo.setAccountPw(accountPw);
			
			daoService.addAccount(avo);
			avo = daoService.getAccountById(userId);
			request.setAttribute("account", avo);
			
			
		} else {
		//로그인회원이면 로그인회원 정보를 넘길것.
			vo = (UserVO)session.getAttribute("loginUser");
			userId = vo.getId();
			System.out.println(vo);
			avo.setUserId(vo.getId());
			avo.setAccountPw(accountPw);
			
			daoService.addAccount(avo);
			avo = daoService.getAccountById(userId);
			request.setAttribute("account", avo);
		}
		
		
		System.out.println("계좌생성완료Ctrl 진입");
		return "/jsp/create-account-completed.jsp";
	}

}
