package controller;

import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import bank.account.AccountVO;
import bank.info.InfoVO;
import bank.product.DepositVO;
import bank.transaction.TransactionVO;
import bank.user.UserVO;
import common.DAOService;

@Controller
public class MainController extends BasicController {
	
	@Autowired
	private DAOService daoService;

	@GetMapping("/main")
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		return "main.jsp";
	}
	
	// index.jsp에서 a링크로 받은 board 처리!
		@GetMapping("/inquiry")
		public String inquiry(HttpServletRequest request, HttpServletResponse response) {
			session = request.getSession();
			System.out.println("inquiryCtrl 진입");

			// 로그인 안된 경우
			if (session.getAttribute("loginUser") == null) {
				String prevBtn = "inquiry";
				session.setAttribute("prevBtn", prevBtn);

				// 로그인 페이지로 포워딩
				return "/login";
			} else {
				String id = ((UserVO) session.getAttribute("loginUser")).getId();
				List<AccountVO> accountList = daoService.getAccountListById(id);

				// 보유계좌 총합계
				long totalBalance = 0;
				for (AccountVO vo : accountList) {
					totalBalance += vo.getBalance();
				}
				// 자릿수 표기 + 원 붙이기
				NumberFormat numFormat = NumberFormat.getInstance(Locale.KOREA);
				String formattedTotalBalance = numFormat.format(totalBalance) + "원";

				// 조회기준일시 표기
				LocalDateTime now = LocalDateTime.now();
				DateTimeFormatter datetimeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				String formattedNow = now.format(datetimeFormat);

				session.setAttribute("accountList", accountList);
				session.setAttribute("accountCount", accountList.size());
				session.setAttribute("formattedTotalBalance", formattedTotalBalance);
				session.setAttribute("formattedNow", formattedNow);

				System.out.println("현재 로그인: " + (UserVO) session.getAttribute("loginUser"));
			}
			return "/transaction/inquiry";
		}

		@PostMapping("/inquiry/detail")
		public String inquiryDetail(HttpServletRequest request) {
			System.out.println("계좌상세조회 진입");
			session = request.getSession();

			String no = request.getParameter("accountNo");

			// 로그인 안된 경우
			if (session.getAttribute("loginUser") == null) {
				String prevBtn = "inquiryDetail";
				session.setAttribute("prevBtn", prevBtn);

				// 로그인 페이지로 리다이렉션
//	            return request.getContextPath()+"login.do";
				return "/login";
			} else {
				AccountVO account = daoService.getAccountInfo(no);
				DepositVO deposit = daoService.getDepositInfo(no);

				// 자릿수 표기 + 원 붙이기
				long totalBalance = Long.valueOf(account.getBalance());
				NumberFormat numFormat = NumberFormat.getInstance(Locale.KOREA);
				String formattedTotalBalance = numFormat.format(totalBalance) + "원";

				System.out.println(formattedTotalBalance);

				// 조회시각
				LocalDateTime now = LocalDateTime.now();
				DateTimeFormatter datetimeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				String formattedNow = now.format(datetimeFormat);

				// 거래내역
				List<TransactionVO> transList = daoService.getTransactionList(no);

				// 계좌객체, 자릿수표기된 잔액, 조회시각, 거래내역 등록
				request.setAttribute("account", account);
				request.setAttribute("deposit", deposit);
				request.setAttribute("formattedTotalBalance", formattedTotalBalance);
				request.setAttribute("formattedNow", formattedNow);
				request.setAttribute("transactionList", transList);
			}
			return "/transaction/inquiryDetail";

		}
		
		
		
		@GetMapping("/openbank")
		public String openInquiry(HttpServletRequest request, HttpServletResponse response) throws Exception {
			session = request.getSession();
			System.out.println("오픈뱅킹조회Ctrl 진입");
			
			// 로그인 안된 경우
			if(session.getAttribute("loginUser") == null) {
	        	String prevBtn = "openbank";
	        	session.setAttribute("prevBtn", prevBtn);
	        	
	            // 로그인 페이지로 포워딩
	            return "/login";
			} else {
				
				//사용자 이름,생년월일,폰번호가 일치하는 사용자의
				//각 db에서의 계좌리스트와 잔액정보를 출력해야 함.
				//all리스트에 accountVO
	        	List<AccountVO> JHaccountList = daoService.getOpenbankAccountListById("JH","j.hyun123@kakao.comK");
	        	List<AccountVO> BGHaccountList = daoService.getOpenbankAccountListById("BGH", "jh111");
	        	List<AccountVO> HJaccountList = daoService.getOpenbankAccountListById("H.J", " j.hyun123@kakao.com");
	        	List<List<AccountVO>> allAccountList = new ArrayList<>();
	        	
	        	//보유계좌 총합계
	        	long totalBalance = 0;
	        	
	        	//총 보유계좌 수
	        	int allAccountCnt = 0;
	        	
	        	if(JHaccountList.size()!=0) {
	        		for(AccountVO vo: JHaccountList) {
	            		totalBalance += vo.getBalance();
	            	}
	        		allAccountCnt += JHaccountList.size();
	        		allAccountList.add(JHaccountList);
	        	} 
	        	if(BGHaccountList.size()!=0) {
	        		for(AccountVO vo: BGHaccountList) {
	            		totalBalance += vo.getBalance();
	            	}
	        		allAccountCnt += BGHaccountList.size();
	        		allAccountList.add(BGHaccountList);

	        	} 
	        	if(HJaccountList.size()!=0) {
	        		for(AccountVO vo: HJaccountList) {
	            		totalBalance += vo.getBalance();
	            	}
	        		allAccountCnt += HJaccountList.size();
	        		allAccountList.add(HJaccountList);
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
			
			return "/transaction/inquiryOpenbank";
		}
		
		@PostMapping("/openbank/inquiry")
		public String openInquiryDetail(HttpServletRequest request, HttpServletResponse response) {
			session = request.getSession();
			System.out.println("계좌상세조회 진입");
			
			String no = request.getParameter("accountNo");
//			String code = request.getParameter("productCode");
			
			
			// 로그인 안된 경우
	        if (session.getAttribute("loginUser") == null) {
	        	String prevBtn = "inquiryDetail";
	        	session.setAttribute("prevBtn", prevBtn);
	        	
	            // 로그인 페이지로 리다이렉션
//	            return request.getContextPath()+"login.do";
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
		
		@GetMapping("/playGame")
		public String play() {
			System.out.println("하리산책 플레이!");
			return "/game/play";
		}
		
		@GetMapping("/news")
		public String news() {
			System.out.println("금융뉴스 페이지");
			return "/news/news";
		}
		
//		@PostMapping("/news/{no}")
//		public String newsDetail(@PathVariable("no")int no, HttpServletRequest request) {
//			System.out.println("뉴스Detail 진입");
//			NewsVO vo = new NewsVO();
//			
//			
//		}
		
		@GetMapping("/transaction")
		public String transaction(HttpServletRequest request, Model model) {
			System.out.println("이체Ctrl 진입");
			session = request.getSession();
			
			String prevBtn = "transaction";
			session.setAttribute("prevBtn", prevBtn);
			
			// 로그인 안된 경우
	        if (session.getAttribute("loginUser") == null) {
	            // 로그인 페이지로 포 워 딩!
	            return "/login";
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
	        		session.setAttribute("myAccountList", accountList);
	        		session.setAttribute("bankList", bankList);
	        		return "/transaction/transaction";
	        	} else {
	        		//개설계좌가 없으면 계좌 개설 화면으로 돌아가기.
	        		//원래라면 알림을 보여줘야.................
	        		return "redirect:/create-account";
	        	}
			}
		}
		
//		@ResponseBody
//		@PostMapping("/checkCurrentBalance")
//		public Map<String, String> checkBalance(HttpServletRequest request) {
//			// ajax에서 넘겨주는 정보
//			String accountNo = request.getParameter("accountNo");
//			System.out.println("계좌번호 넘어오니?" + accountNo);
//			
//			Map<String, String> currentBalance = new HashMap<>();
//			
//			// dao에서 계좌를 찾아서,
//			AccountVO account = daoService.getAccountInfo(accountNo);
//
//			if (account != null) {
//				// 있는 계좌 정보라면 잔액을 저장
//				long balance = Long.valueOf(account.getBalance());
//				
//	        	//자릿수 표기 + 원 붙이기
//	        	NumberFormat numFormat = NumberFormat.getInstance(Locale.KOREA);
//	        	String formattedTotalBalance = numFormat.format(balance) + "원";
//				System.out.println("현재잔액 얼마? " + formattedTotalBalance);
//				
//				currentBalance.put("balance", formattedTotalBalance);
//				
//				return currentBalance;
//			}
//			return null;
//		}
		@ResponseBody
		@PostMapping("/checkCurrentBalance")
		public String checkBalance(HttpServletRequest request) {
			// ajax에서 넘겨주는 정보
			String accountNo = request.getParameter("accountNo");
			System.out.println("계좌번호 넘어오니?" + accountNo);
			
			// dao에서 계좌를 찾아서,
			AccountVO account = daoService.getAccountInfo(accountNo);

			if (account != null) {
				// 있는 계좌 정보라면 잔액을 저장
				long balance = Long.valueOf(account.getBalance());
				
	        	//자릿수 표기 + 원 붙이기
	        	NumberFormat numFormat = NumberFormat.getInstance(Locale.KOREA);
	        	String formattedTotalBalance = numFormat.format(balance) + "원";
				System.out.println("현재잔액 얼마? " + formattedTotalBalance);
				
				return formattedTotalBalance;
			}
			return null;
		}
		
}
