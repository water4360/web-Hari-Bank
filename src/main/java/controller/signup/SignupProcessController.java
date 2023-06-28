package controller.signup;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.user.UserDAO;
import bank.user.UserVO;
import common.DAOService;
import controller.BasicController;

public class SignupProcessController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String pw2 = request.getParameter("pw2");
		String name = request.getParameter("name");
		String birthdate = request.getParameter("birthdate");
		String gender = request.getParameter("gender");
		String telecom = request.getParameter("telecom");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		
		String postcode = request.getParameter("postcode");
		String roadAdd = request.getParameter("address") + request.getParameter("roadAddress");
		String detailAdd = request.getParameter("detailAddress");

		// 데이터 전달 확인용
		System.out.printf("%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n",
						id, pw, pw2, name, birthdate, gender, telecom, phone, email, postcode, roadAdd, detailAdd);
		
		try {
			UserVO vo = new UserVO();
			vo.setId(id);
			vo.setPw(pw);
			vo.setKorName(name);
			vo.setBirthdate(birthdate);
			vo.setGender(gender);
			vo.setTelecom(telecom);
			vo.setPhone(phone);
			vo.setEmail(email);
			
			vo.setPostcode(postcode);
			vo.setRoadAddress(roadAdd);
			vo.setDetailAddress(detailAdd);
			
			//DB에 등록하고
			daoService.addUser(vo);
			System.out.println("User등록완!-SignupProcessCtrl");
			
			//세션에도 등록하기
			vo=null;
			vo=daoService.getUserById(id);
			session = request.getSession();
			
			session.setAttribute("newUser", vo);
			System.out.println("User정보 DB에서 새로가져오기!-SignupProcessCtrl");
			
			return "create-account.do";
			
		} catch (Exception e) {
			e.printStackTrace();
		}
			System.out.println("가입실패-SignupProcessCtrl");
		
		return "main.do";
	}
}
