package bank.account;

public class AccountVO {
	private String accountNo;
	private String accountPw;
	private String createdDate;
	private long balance;
	private String accountNickname;
	private String productCode;
	private String userId;
	private String bankCode;
	
	private String bankName;
	private String productName;
	private String totalBalnce;
	
	
	private String firstName;
	private String lastName;
	private String benefitCode;
	private String transferOnceLimit;
	private String transferDayLimit;
	
	public AccountVO() {
		super();
	}
	
	
	
	
	@Override
	public String toString() {
		return "AccountVO [accountNo=" + accountNo + ", accountPw=" + accountPw + ", createdDate=" + createdDate
				+ ", balance=" + balance + ", accountNickname=" + accountNickname + ", productCode=" + productCode
				+ ", userId=" + userId + ", bankCode=" + bankCode + ", bankName=" + bankName + ", productName="
				+ productName + ", totalBalnce=" + totalBalnce + "]";
	}




	//간단 계좌생성
	public AccountVO(String accountNo, String accountPw, String createdDate, long balance,
			String accountNickname, String productCode, String userId, String bankCode) {
		super();
		this.accountNo = accountNo;
		this.accountPw = accountPw;
		this.createdDate = createdDate;
		this.balance = balance;
		this.accountNickname = accountNickname;
		this.productCode = productCode;
		this.userId = userId;
		this.bankCode = bankCode;
	}
	
	
	//계좌정보 가져오기
	public AccountVO(String accountNo, String accountPw, String createdDate, long balance, String accountNickname,
			String productCode, String userId, String bankCode, String productName) {
		super();
		this.accountNo = accountNo;
		this.accountPw = accountPw;
		this.createdDate = createdDate;
		this.balance = balance;
		this.accountNickname = accountNickname;
		this.productCode = productCode;
		this.userId = userId;
		this.bankCode = bankCode;
		this.productName = productName;
	}
	// 전체 잔액이 포함된 계좌정보 가져오기
	public AccountVO(String accountNo, String accountPw, String createdDate, long balance, String accountNickname,
			String productCode, String userId, String bankName, String bankCode, String productName, String totalBalance) {
		super();
		this.accountNo = accountNo;
		this.accountPw = accountPw;
		this.createdDate = createdDate;
		this.balance = balance;
		this.accountNickname = accountNickname;
		this.productCode = productCode;
		this.userId = userId;
		this.bankCode = bankCode;
		
		this.bankName = bankName;
		this.productName = productName;
		this.totalBalnce = totalBalance;
	}
	
	
	
	
	public String getBankCode() {
		return bankCode;
	}
	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	public String getAccountNo() {
		return accountNo;
	}
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getAccountPw() {
		return accountPw;
	}
	public void setAccountPw(String accountPw) {
		this.accountPw = accountPw;
	}
	public long getBalance() {
		return balance;
	}
	public void setBalance(long balance) {
		this.balance = balance;
	}
	public String getTotalBalance() {
		return totalBalnce;
	}
	public void setTotalBalance(String totalBalance) {
		this.totalBalnce = totalBalance;
	}
	public String getBenefitCode() {
		return benefitCode;
	}
	public void setBenefitCode(String benefitCode) {
		this.benefitCode = benefitCode;
	}
	public String getAccountNickname() {
		return accountNickname;
	}
	public void setAccountNickname(String accountNickname) {
		this.accountNickname = accountNickname;
	}
	public String getTransferOnceLimit() {
		return transferOnceLimit;
	}
	public void setTransferOnceLimit(String transferOnceLimit) {
		this.transferOnceLimit = transferOnceLimit;
	}
	public String getTransferDayLimit() {
		return transferDayLimit;
	}
	public void setTransferDayLimit(String transferDayLimit) {
		this.transferDayLimit = transferDayLimit;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}
	
	
	
}
