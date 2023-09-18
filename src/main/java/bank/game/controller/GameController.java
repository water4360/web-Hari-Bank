package bank.game.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GameController {

	@GetMapping("/playGame")
	public String game(HttpServletRequest request) {
		return "game/play";
	}
}
