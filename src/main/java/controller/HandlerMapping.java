package controller;

import java.util.HashMap;
import java.util.Map;

import controller.board.InsertNewQnAController;
import controller.board.QnAController;
import controller.board.QnADetailsController;
import controller.board.WriteQnAController;
import controller.login.KakaoLoginController;
import controller.login.LoginController;
import controller.login.LoginProcessController;
import controller.login.LogoutController;
import controller.login.MypageController;
import controller.signup.SignupKakaoController;
import controller.signup.SignupProcessController;
import controller.signup.SignupWebController;
import controller.transaction.InquiryController;
import controller.transaction.TransactionController;

//클라이언트에서 Controller요청이 들어오면 얘가 상속받아서 넘겨주는...??...  
public class HandlerMapping {
	//선언. 여기서의 Controller = 만들어둔 인터페이스.
	private Map<String, Controller> mappings;
	
	//초기화
	public HandlerMapping() {
		mappings = new HashMap<String, Controller>();
		
		//xxx.do가 들어오면 xxxControlloer()로 안내!
		mappings.put("/main.do", new MainController());
		
		//상단 메뉴들
		mappings.put("/inquiry.do", new InquiryController());
		mappings.put("/transaction.do", new TransactionController());
		mappings.put("/products.do", new ProductsController());
		mappings.put("/customer.do", new CustomerController());
		mappings.put("/mypage.do", new MypageController());
		
		//메인 메뉴
		mappings.put("/web-signup.do", new SignupWebController());
		mappings.put("/kakao-signup.do", new SignupKakaoController());
		mappings.put("/signupProcess.do", new SignupProcessController());
		
		//계좌 개설
		mappings.put("/create-account.do", new CreateAccountController());
		mappings.put("/createAccountProcess.do", new CreateAccountProcessController());
		
//		mappings.put("/notice.do", new NoticeController());
//		mappings.put("/fnq.do", new FnQController());
		mappings.put("/qna.do", new QnAController());
		mappings.put("/qna-details.do", new QnADetailsController());
		
		mappings.put("/write-post.do", new WriteQnAController());
		mappings.put("/insert-new-post.do", new InsertNewQnAController());
		
		
		//로그인
		mappings.put("/login.do", new LoginController());
		mappings.put("/kakaoLogin.do", new KakaoLoginController());
		mappings.put("/loginProcess.do", new LoginProcessController());
		mappings.put("/logout.do", new LogoutController());
		
		
		
		
		
		
	}
	public Controller getController(String path) {
		return mappings.get(path);
	}
}
