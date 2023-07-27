package controller;

import java.util.HashMap;
import java.util.Map;

import controller.account.CreateAccountController;
import controller.account.CreateAccountProcessController;
import controller.board.DeleteQnAController;
import controller.board.FAQController;
import controller.board.InsertNewQnAController;
import controller.board.ModifyQnAController;
import controller.board.QnAController;
import controller.board.QnADetailsController;
import controller.board.WriteQnAController;
import controller.customer.CustomerController;
import controller.login.KakaoLoginController;
import controller.login.LoginController;
import controller.login.LoginProcessController;
import controller.login.LogoutController;
import controller.login.MypageController;
import controller.login.UpdateMyInfoController;
import controller.product.ProductsController;
import controller.signup.SignupKakaoController;
import controller.signup.SignupProcessController;
import controller.signup.SignupWebController;
import controller.transaction.InquiryController;
import controller.transaction.InquiryDetailController;
import controller.transaction.InquiryDetailOpenbankController;
import controller.transaction.InquiryOpenbankController;
import controller.transaction.TransactionController;
import controller.transaction.TransactionProcessController;
import controller.transaction.CheckCurrentBalanceController;
import controller.transaction.CheckReceiverAccountController;

//클라이언트에서 Controller요청이 들어오면 얘가 상속받아서 넘겨주는...??...  
public class HandlerMapping {
	//선언. 여기서의 Controller = 만들어둔 인터페이스.
	private Map<String, Controller> mappings;
	
	//초기화
	public HandlerMapping() {
		mappings = new HashMap<String, Controller>();
		
		//xxx가 들어오면 xxxControlloer()로 안내!
        mappings.put("/", new MainController());
		mappings.put("/main", new MainController());
		
		//상단 메뉴들
		mappings.put("/inquiry", new InquiryController());
		mappings.put("/inquiryDetail", new InquiryDetailController());
		
		mappings.put("/inquiryOpenbank", new InquiryOpenbankController());
		mappings.put("/inquiryDetailOpenbank", new InquiryDetailOpenbankController());
		
		mappings.put("/transaction", new TransactionController());
		mappings.put("/transactionProcess", new TransactionProcessController());
		
		//단순검증
		mappings.put("/checkCurrentBalance", new CheckCurrentBalanceController());
		mappings.put("/checkAccountPassword", new CheckAccountPasswordController());
		mappings.put("/checkReceiverAccount", new CheckReceiverAccountController());
		
		
		mappings.put("/products", new ProductsController());
		mappings.put("/customer", new CustomerController());
		mappings.put("/mypage", new MypageController());
		mappings.put("/update-info", new UpdateMyInfoController());
		
		//메인 메뉴
		mappings.put("/web-signup", new SignupWebController());
		mappings.put("/kakao-signup", new SignupKakaoController());
		mappings.put("/signupProcess", new SignupProcessController());
		
		//계좌 개설
		mappings.put("/create-account", new CreateAccountController());
		mappings.put("/createAccountProcess", new CreateAccountProcessController());
		
//		mappings.put("/notice", new NoticeController());
		mappings.put("/faq", new FAQController());
//		mappings.put("/qna", new QnAController());
		mappings.put("/qna-details", new QnADetailsController());
		
		//게시판용
		mappings.put("/write-post", new WriteQnAController());
		mappings.put("/modify-post", new ModifyQnAController());
		mappings.put("/delete-post", new DeleteQnAController());
		mappings.put("/insert-new-post", new InsertNewQnAController());
		
		
		//로그인
		mappings.put("/login", new LoginController());
		mappings.put("/kakaoLogin", new KakaoLoginController());
		mappings.put("/loginProcess", new LoginProcessController());
		mappings.put("/logout", new LogoutController());
		
		
		
		
		
	}
	public Controller getController(String path) {
		return mappings.get(path);
	}
}
