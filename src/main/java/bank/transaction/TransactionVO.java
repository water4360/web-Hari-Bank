package bank.transaction;

//거래
public class TransactionVO {
	private String transactionNo;
	private String senderAccountNo;
	private String receiverAccountNo;
	private String amount;
	private String date;
	private String time;
	private String type;
	
	private String previousBalance;
	private String toMemo;
	private String fromMemo;

	public TransactionVO() {
		super();
	}
	
	
	
	//계좌별 입출금거래내역 조회
	public TransactionVO(String transactionNo, String date, String time, String type, String amount, String fromMemo, String previousBalance) {
		super();
		this.transactionNo = transactionNo;
		this.date = date;
		this.time = time;
		this.type = type;
		this.amount = amount;
		this.fromMemo = fromMemo;
		this.previousBalance = previousBalance;
	}




	public String getTransactionNo() {
		return transactionNo;
	}

	public void setTransactionNo(String transactionNo) {
		this.transactionNo = transactionNo;
	}

	public String getSenderAccountNo() {
		return senderAccountNo;
	}

	public void setSenderAccountNo(String senderAccountNo) {
		this.senderAccountNo = senderAccountNo;
	}

	public String getReceiverAccountNo() {
		return receiverAccountNo;
	}

	public void setReceiverAccountNo(String receiverAccountNo) {
		this.receiverAccountNo = receiverAccountNo;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPreviousBalance() {
		return previousBalance;
	}

	public void setPreviousBalance(String previousBalance) {
		this.previousBalance = previousBalance;
	}

	public String getToMemo() {
		return toMemo;
	}

	public void setToMemo(String toMemo) {
		this.toMemo = toMemo;
	}

	public String getFromMemo() {
		return fromMemo;
	}

	public void setFromMemo(String fromMemo) {
		this.fromMemo = fromMemo;
	}

	//거래내역 등록
	public TransactionVO(String transactionNo, String senderAccountNo, String receiverAccountNo, String amount,
			String type, String previousBalance, String toMemo, String fromMemo) {
		super();
		this.transactionNo = transactionNo;
		this.senderAccountNo = senderAccountNo;
		this.receiverAccountNo = receiverAccountNo;
		this.amount = amount;
		this.type = type;
		this.previousBalance = previousBalance;
		this.toMemo = toMemo;
		this.fromMemo = fromMemo;
	}
	//거래내역 가져오기
	public TransactionVO(String transactionNo, String senderAccountNo, String receiverAccountNo, String amount,
			String date, String time, String type, String previousBalance, String toMemo, String fromMemo) {
		super();
		this.transactionNo = transactionNo;
		this.senderAccountNo = senderAccountNo;
		this.receiverAccountNo = receiverAccountNo;
		this.amount = amount;
		this.date = date;
		this.time = time;
		this.type = type;
		this.previousBalance = previousBalance;
		this.toMemo = toMemo;
		this.fromMemo = fromMemo;
	}
	
	
	
	
	
}//end of class


