package bank.transaction;

//거래
public class TransactionVO {
	//0629 은행코드신규추가
	//senderBank, AccNo가 무조건 내 계좌로 고정인 상태.
	//입금이 발생한 경우 금액은 +일것이고
	//출금이 발생한 경우 금액은 -겠지
	
	private String transactionNo;
	private String senderBank; //내계좌
	private String senderAccountNo;
	private String receiverBank; //상대계좌
	private String receiverAccountNo;
	private String amount;
	private String date;
	private String time;
	private String type;
	private String balance;
	private String toMemo; //보내는 메모
	private String fromMemo; //내통장 메모
	
	

	public TransactionVO() {
		super();
	}
	
	

	
	
	
	
	
	
	

	public String getSenderBank() {
		return senderBank;
	}



	public void setSenderBank(String senderBank) {
		this.senderBank = senderBank;
	}



	public String getReceiverBank() {
		return receiverBank;
	}



	public void setReceiverBank(String receiverBank) {
		this.receiverBank = receiverBank;
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

	public String getBalance() {
		return balance;
	}

	public void setBalance(String balance) {
		this.balance = balance;
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
			String type, String balance, String toMemo, String fromMemo) {
		super();
		this.transactionNo = transactionNo;
		this.senderAccountNo = senderAccountNo;
		this.receiverAccountNo = receiverAccountNo;
		this.amount = amount;
		this.type = type;
		this.balance = balance;
		this.toMemo = toMemo;
		this.fromMemo = fromMemo;
	}
	//거래내역 가져오기
	public TransactionVO(String transactionNo, String senderAccountNo, String receiverAccountNo, String amount,
			String date, String time, String type, String balance, String toMemo, String fromMemo) {
		super();
		this.transactionNo = transactionNo;
		this.senderAccountNo = senderAccountNo;
		this.receiverAccountNo = receiverAccountNo;
		this.amount = amount;
		this.date = date;
		this.time = time;
		this.type = type;
		this.balance = balance;
		this.toMemo = toMemo;
		this.fromMemo = fromMemo;
	}
	
	//계좌별 입출금거래내역 조회
		public TransactionVO(String transactionNo, String date, String time, String type, String amount, String fromMemo, String balance) {
			super();
			this.transactionNo = transactionNo;
			this.date = date;
			this.time = time;
			this.type = type;
			this.amount = amount;
			this.fromMemo = fromMemo;
			this.balance = balance;
		}

	
	
	
}//end of class


