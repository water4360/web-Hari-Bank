package common;

import java.util.List;

import bank.account.AccountDAO;
import bank.account.AccountVO;
import bank.board.PostDAO;
import bank.board.PostVO;
import bank.info.InfoDAO;
import bank.info.InfoVO;
import bank.product.DepositDAO;
import bank.product.DepositVO;
import bank.transaction.TransactionDAO;
import bank.transaction.TransactionVO;
import bank.user.UserDAO;
import bank.user.UserVO;

public class DAOService {

	protected UserDAO ud;
	protected PostDAO pd;
	protected InfoDAO bd;
	protected AccountDAO ad;
	protected DepositDAO dd;
	protected TransactionDAO td;
	
	public DAOService(){
		super();
		ud = new UserDAO();
		pd = new PostDAO();
		bd = new InfoDAO();
		ad = new AccountDAO();
		dd = new DepositDAO();
		td = new TransactionDAO();
	}
	/*
	 * UserDAO(사용자)
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
	 * AccountDAO(계좌)
	 */
	//계좌개설
	public void addAccount(AccountVO vo) throws Exception {
		ad.addAccount(vo);
	}
	
	//계좌찾기
	public AccountVO getAccountById(String id) {
		return ad.getAccountById(id);
	}
	//단일계좌 상세조회
	public AccountVO getAccountInfo(String no) {
		return ad.getAccountInfo(no);
	}
	//전체계좌조회
	public List<AccountVO> getAccountListById(String id) {
		return ad.getAccountListById(id);
	}
	//계좌비번 확인
	public boolean isCorrectAccountPw(String accountNo, String pw) {
		return ad.isCorrectAccountPw(accountNo, pw);
	}

	
	/*
	 * PostDAO(게시글)
	 */
	
	//회원별 QNA 리스트
	public List<PostVO> getQnaListById(String id) {
		return pd.getQnaListById(id);
	}
	
	
	
	/*
	 * DepositDAO(예금)
	 */
	public DepositVO getDepositInfo(String code) {
		return dd.getDepositInfo(code);
	}
	
	
	
	/*
	 * BankDAO(은행)
	 */
	public List<InfoVO> getBankList() {
		return bd.getBankList();
	}
	
	
	/*
	 * TransactionDAO(이체거래)
	 */

	//이체
	public int transferMoney(String senderAccountNo, String accountPw, String receiverAccountNo, long amount) throws Exception {
		return td.transferMoney(senderAccountNo, accountPw, receiverAccountNo, amount);
	}
	
	//거래정보 등록
	public String insertTransactionInfo(String senderBankCode, String senderAccountNo, String accountPw, String receiverBankCode, String receiverAccountNo, long amount, long currentBalance) throws Exception {
		return td.insertTransactionInfo(senderBankCode, senderAccountNo, accountPw, receiverBankCode, receiverAccountNo, amount, currentBalance);
	}
	
	//거래내역 조회
	public List<TransactionVO> getTransactionList(String accountNo) {
		return td.getTransactionList(accountNo);
	}
	
	
	
}
