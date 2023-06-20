package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public interface Controller {

	String handleRequest(HttpServletRequest request, HttpServletResponse response);

}
