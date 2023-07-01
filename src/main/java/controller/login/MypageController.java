package controller.login;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bank.board.PostVO;
import bank.user.UserVO;
import controller.BasicController;

public class MypageController extends BasicController {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("마이페이지Ctrl 진입");
		session = request.getSession();
		
		// 로그인 안된 경우
		if (session.getAttribute("loginUser") == null) {
		
        	String prevBtn = "mypage";
        	session.setAttribute("prevBtn", prevBtn);
        	
            // 로그인 페이지로 리다이렉션
            return "login.do";
        } else {
        	String id = ((UserVO)session.getAttribute("loginUser")).getId();
    		
        	//조회기준일시 표기
        	LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter datetimeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String latestLoginTime = now.format(datetimeFormat);
            session.setAttribute("latestLoginTime", latestLoginTime);
        	
        	
    		List<PostVO> qnaList = new ArrayList<>();
    		qnaList = daoService.getQnaListById(id);
    		session.setAttribute("qnaList", qnaList);
    		
        	System.out.println("현재 로그인: " + (UserVO) request.getAttribute("loginUser"));
		}
		
		return "/jsp/mypage.jsp";
	}
}
