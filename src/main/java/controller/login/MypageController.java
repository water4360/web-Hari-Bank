package controller.login;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.PostVO;
import controller.BasicController;
import user.UserVO;

public class MypageController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		session = request.getSession();
		
		// 로그인 안된 경우
		if (session.getAttribute("loginUser") == null) {
		
        	String prevBtn = "mypage";
        	session.setAttribute("prevBtn", prevBtn);
        	
            // 로그인 페이지로 리다이렉션
            return "login.do";
        } else {
        	String id = ((UserVO)session.getAttribute("loginUser")).getId();
    		
    		List<PostVO> qnaList = new ArrayList<>();
    		qnaList = daoService.getQnaListById(id);
    		session.setAttribute("qnaList", qnaList);
    		
        	System.out.println("현재 로그인: " + (UserVO) request.getAttribute("loginUser"));
		}
		
		return "/jsp/mypage.jsp";
	}
}
