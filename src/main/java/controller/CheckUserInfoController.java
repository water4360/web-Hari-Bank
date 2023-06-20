package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckUserInfoController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		session = request.getSession();
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String birthdate = request.getParameter("birthdate");
		String gender = request.getParameter("gender");
		String telecom = request.getParameter("telecom");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");

		// 데이터 전달 확인용
		System.out.printf("%s, %s, %s, %s, %s, %s, %s\n",
						id, name, birthdate, gender, telecom, phone, email);
		
		return "main.do";
	}

}
