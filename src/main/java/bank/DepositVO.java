package bank;

public class DepositVO {
	private String code;
	private String name;
	private double interest;
	private String saleStatus;
	private String detail;
	
	
	public DepositVO() {
		super();
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getInterest() {
		return interest;
	}
	public void setInterest(double interest) {
		this.interest = interest;
	}
	public String getSaleStatus() {
		return saleStatus;
	}
	public void setSaleStatus(String saleStatus) {
		this.saleStatus = saleStatus;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public DepositVO(String code, String name, double interest, String saleStatus, String detail) {
		super();
		this.code = code;
		this.name = name;
		this.interest = interest;
		this.saleStatus = saleStatus;
		this.detail = detail;
	}
	
	
}
