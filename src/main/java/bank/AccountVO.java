package bank;

import java.util.Date;

public class AccountVO {
	private String bankCode;
	private String userId;
	private String productCode;
	private String accountNo;
	private Date createdDate;
	private String firstName;
	private String lastName;
	private String accountPw;
	private String totalBalance;
	private String benefitCode;
	private String accountNickname;
	private String transferOnceLimit;
	private String transferDayLimit;
	public AccountVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getBankCode() {
		return bankCode;
	}
	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
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
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
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
	public String getTotalBalance() {
		return totalBalance;
	}
	public void setTotalBalance(String totalBalance) {
		this.totalBalance = totalBalance;
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
	public AccountVO(String bankCode, String userId, String productCode, String accountNo, Date createdDate,
			String firstName, String lastName, String accountPw, String totalBalance, String benefitCode,
			String accountNickname, String transferOnceLimit, String transferDayLimit) {
		super();
		this.bankCode = bankCode;
		this.userId = userId;
		this.productCode = productCode;
		this.accountNo = accountNo;
		this.createdDate = createdDate;
		this.firstName = firstName;
		this.lastName = lastName;
		this.accountPw = accountPw;
		this.totalBalance = totalBalance;
		this.benefitCode = benefitCode;
		this.accountNickname = accountNickname;
		this.transferOnceLimit = transferOnceLimit;
		this.transferDayLimit = transferDayLimit;
	}

	
	
	
}
