package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DispatcherServlet extends HttpServlet {

	private HandlerMapping mappings;

//	@Override
//	public void init(ServletConfig config) throws ServletException {
//		// 서버가 실행되어서 서블릿이 실행될때 딱 한 번! 실행됨으로써 성능향상!
//		mappings = new HandlerMapping();
//	}
	   @Override
	    public void init(ServletConfig config) throws ServletException {
	        String propLoc = config.getInitParameter("propLoc");
	        mappings = new HandlerMapping(propLoc);
	    }

	// alt+shift+s + v 오버라이딩해서 service 검색, request/response으로만 변경해주고 나머지 지움.
	// response.addCookie = 서버에서 온걸 그대로 붙여서 보내는거.
	// request.getCookies = 서버에서 받는 것!
	// response.redirect = 클라이언트야 너 이거 받자마자 새로고침 해줘!

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 일반적으로 a링크 이런거 쓸때의 /는 8080뒤의 /를 의미함.
		// 하지만 xml, forward(jsp로 보낼때), include는 프로젝트명/의 /를 의미함!
		// 그래서 JYBanking(PageContext.contextPath 어쩌구??) 을 굳이 안 붙임.

		// 매번 URI가 날아올때 라이브러리가 나오는건 부적절하기 때문에
		// 라이브러리만 뽑아내기 위해 사용한다 예) /MyBank/login.do 에서 /MyBank만 추출

		String uri = request.getRequestURI();
		System.out.println("uri : " + uri);

		// request.getContextPath() : 여기서 contextPath가 프로젝트명임!
		uri = uri.substring(request.getContextPath().length());
		System.out.println("uri2 : " + uri);

		// 전역변수로 써줘야 init에서 생성된 mappings를 여기서도 사용가능!
		Controller ctrl = mappings.getController(uri);
		String callPage = ctrl.handleRequest(request, response);
		System.out.println("jsp : " + callPage);

		// 만약 받아오는 callPage가 redirect로 시작하면? 리다이렉트!
		if (callPage.startsWith("redirect:")) {
			response.sendRedirect(callPage.substring("redirect:".length()));
		} else {
			// forward 시킬 jsp주소를 추가함.
			RequestDispatcher dispatcher = request.getRequestDispatcher(callPage);
			// 요청과 응답을 하려면 request, response객체가 다 있어야 하기 때문에 얘를 넘긴다
			dispatcher.forward(request, response);
		}
	}

}