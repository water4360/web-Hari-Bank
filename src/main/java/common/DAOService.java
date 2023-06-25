package common;

import java.util.List;

import bank.AccountDAO;
import bank.AccountVO;
import board.PostDAO;
import board.PostVO;
import user.UserDAO;
import user.UserVO;

public class DAOService {

	protected UserDAO ud;
	protected AccountDAO ad;
	protected PostDAO pd;
	
	public DAOService() {
		super();
		ud = new UserDAO();
		ad = new AccountDAO();
		pd = new PostDAO();
	}
	/*
	 * UserDAO
	 */
	
	//회원가입
	public void addUser(UserVO uvo) {
		ud.addUser(uvo);
	}
	
	//회원 찾기
	public UserVO getUserById(String id) {
		return ud.getUserById(id);
	}
	
	//로그인 확인
	public boolean isCorrectInfo(String id, String pw) {
		return ud.isCorrectInfo(id, pw);
	}
	
	//아이디 중복확인
	public boolean isDuplicated(String id) {
		return ud.isDuplicated(id);
	}
	
	
	
	/*
	 * AccountDAO
	 */
	//계좌개설
	public void addAccount(AccountVO vo) throws Exception {
		ad.addAccount(vo);
	}
	
	//계좌찾기
	public AccountVO getAccountById(String id) {
		return ad.getAccountById(id);
	}

	
	/*
	 * PostDAO
	 */
	
	//회원별 QNA 리스트
	public List<PostVO> getQnaListById(String id) {
		return pd.getQnaListById(id);
	}
	
}