package controller;

import java.util.HashMap;
import java.util.Map;

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
		mappings.put("/login.do", new LoginController());
		mappings.put("/create-account.do", new CreateAccountController());
		
		
		
		
	}
	public Controller getController(String path) {
		return mappings.get(path);
	}
}
