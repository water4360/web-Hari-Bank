package bank;

public class BankVO {
	private String bankCode;
	private String bankName;
	private String userId;

	public BankVO() {
		super();
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

	public BankVO(String bankCode, String bankName) {
		super();
		this.bankCode = bankCode;
		this.bankName = bankName;
	}
	
	
}


