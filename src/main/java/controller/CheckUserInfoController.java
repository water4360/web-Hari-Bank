package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;
import user.UserVO;

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
		
		UserDAO dao = new UserDAO();
		String result = null;
		
//		if(dao.isDuplicated(id)) {
//			result = "true";
//		} else {
//			result = "false";
//		}

		// 데이터 전달 확인용
		System.out.printf("%s, %s, %s, %s, %s, %s, %s\n",
						id, name, birthdate, gender, telecom, phone, email);
		System.out.println("result : " + result);
		
//		try {
//			response.setContentType("text/plain");  // Setting the content type of the response
//			response.setCharacterEncoding("UTF-8");  // Setting the character encoding of the response
//			PrintWriter out = response.getWriter();  // Getting the writer object to write data
//			out.write(result);  // Writing data to the response
//			out.flush();  // Flushing the writer
//		} catch (IOException e) {
//			e.printStackTrace();
//		}


		    return null;  // Since we are writing the response directly to the PrintWriter, we can return null here
		  }

}
