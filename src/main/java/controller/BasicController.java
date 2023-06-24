package controller;

import javax.servlet.http.HttpSession;

import common.ConnectionFactory;
import common.DAOService;
import common.DAOServiceFactory;


public abstract class BasicController implements Controller {

	// controller들 묶어주기 + Service 상속용
	protected HttpSession session;
	protected ConnectionFactory conn;
	protected DAOService daoService;
	
	public BasicController() {
		daoService = DAOServiceFactory.getInstance();
	}
}
