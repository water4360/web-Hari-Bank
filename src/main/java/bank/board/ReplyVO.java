package bank.board;

public class ReplyVO {
	private int no;
	private int boardNo;
	private String content;
	private String writer;
	private String regDate;
	
	
	public ReplyVO() {
		super();
	}
	public ReplyVO(int no, int boardNo, String content, String writer, String regDate) {
		super();
		this.no = no;
		this.boardNo = boardNo;
		this.content = content;
		this.writer = writer;
		this.regDate = regDate;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	
}
