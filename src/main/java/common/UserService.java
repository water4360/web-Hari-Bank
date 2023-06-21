package common;

import user.UserDAO;
import user.UserVO;

public class UserService {

	protected UserDAO dao;
	
	public UserService() {
		dao = new UserDAO();
	}
	
	//회원가입
	public void addUser(UserVO uvo) {
		dao.addUser(uvo);
	}
}
