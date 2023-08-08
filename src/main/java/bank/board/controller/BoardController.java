package bank.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bank.board.service.BoardService;
import bank.board.vo.BoardVO;
import bank.user.UserVO;

@Controller // 얘가 없으면 스프링 컨테이너가 해석할 수 없음
public class BoardController {

	@Autowired
	private BoardService boardService;

	// index.jsp에서 a링크로 받은 board 처리!
	@GetMapping("/board")
	public String list(HttpServletRequest request) {
		// 공유영역 4가지 중 주요 영역 2가지
		// request, session
		List<BoardVO> list = boardService.getAllBoardList();
		System.out.println(list.get(list.size()-1));
		request.setAttribute("qnas", list);
//		return "board/list";
		return "board/qna-list";
	}

//	@GetMapping("/board/detail")
//	public String detail(HttpServletRequest request, @RequestParam("no") int no) {
////		System.out.println("넘어오는 번호 : " + no);
//
//		// no번에 해당하는 게시글 조회
//		BoardVO vo = boardService.getOneBoard(no);
//		request.setAttribute("qna", vo);
//		return "board/qna-detail";
//	}

	/**
	 * URL에 바로 게시글넘버를 추가해서 조회하는 경우. path의 {no}로 들어오는 값(패스변수)을 boardNo로 받겠다는 뜻. 그러고보니
	 * void네? 요청url과 리턴할 jsp값이 같은 경우에는 void 쓸 수 있음!!! 즉 요청url 자체가 주소가 되는 것임.
	 */
	@GetMapping("/board/{no}")
//	public String detail2(@PathVariable("no") int boardNo, HttpServletRequest request) {
	public ModelAndView detail2(@PathVariable("no") int boardNo, HttpServletRequest request) {
		// no번에 해당하는 게시글 조회
		BoardVO vo = boardService.getOneBoard(boardNo);
		System.out.println("조회할 게시글 : " + vo);
		
		// 보여줄 view는 board/detail이야.
		// 등록할 model은 "board"라는 이름의 vo객체야.
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/qna-detail");
		mav.addObject("post", vo);

//		//원래는 이렇게 공유영역 등록.
//		request.setAttribute("board", vo);
//		return "board/detail";

		// 이제는 ModelAndView를 리턴함.
		return mav;
	}

	@GetMapping("/board/write")
	public void writeForm(Model model, HttpSession session) {
		BoardVO board = new BoardVO();
		UserVO user = (UserVO)session.getAttribute("loginUser");
		if(user != null) {
			//로그인이 되어 있으면
			board.setWriter(user.getId());
		}

//		그런데 만약 이렇게 값을 적어주면 이게 JSP로 넘어갔을 때에도 계속 유지가 됨.
//		board.setTitle("크하하하");
//		board.setWriter("컨트롤러");

		model.addAttribute("boardVO", board);
	}

	@PostMapping("/board/write")
	public String write(@Valid BoardVO board, BindingResult result) {

		System.out.println("board : " + board);

//		if (board.getTitle() == null || board.getTitle().length() == 0) {
//			System.out.println("에러발생.");
//			return "/board/write";
//		}

		if (result.hasErrors()) {
			System.out.println("입력시 에러발생!");
			return "board/write";
		}
			System.out.println("입력시 문제없음.");
			boardService.addBoard(board);
			//걍 "board/list2"라면 위에 url이 계속 write로 남아있겠지...
		return "redirect:/board";
	}

}
