package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// 여기서 선언해줬고
	private HandlerMapping mapping;

	public DispatcherServlet() {
		super();
	}

	// 여기서 오버라이딩해서 초기화 해줬음.
	@Override
	public void init() throws ServletException {
		mapping = new HandlerMapping();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			process(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			process(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void process(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String uri = request.getRequestURI();
		// 슬래쉬 마지막에 나오는 걸로부터 경로 추출
//		String path = uri.substring(uri.lastIndexOf("/"));
		uri = uri.substring(request.getContextPath().length());
		System.out.println("uri : " + uri);
		// 여기로 path가 넘어가면 해당 path에 대한 컨트롤러가 리턴되고
		Controller ctrl = mapping.getController(uri);
		
		if (ctrl != null) {
			//한줄 올려봄
			String viewPage = ctrl.handleRequest(request, response);
			
			if(viewPage.startsWith("redirect:")) {
				String viewUrl = viewPage.substring("redirect:".length());
				response.sendRedirect(request.getContextPath() + viewUrl);
			} else {
				RequestDispatcher rd = request.getRequestDispatcher(viewPage);
				rd.forward(request, response);
			}
		}
	}

	
	
	
}