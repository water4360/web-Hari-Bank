package bank.board;

public class PostVO {
	//카테고리, 글번호, 작성자, 제목, 내용, 작성일, 조회수, 게시글 수
	private String category;
	private int no;
	private String writer;
	private String title;
	private String contents;
	private String regDate;
	private int viewCnt;

	public PostVO() {
		super();
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public int getViewCnt() {
		return viewCnt;
	}

	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	//신규생성용
	public PostVO(int no, String writer, String title, String contents, String regDate, int viewCnt) {
		super();
		this.no = no;
		this.writer = writer;
		this.title = title;
		this.contents = contents;
		this.regDate = regDate;
		this.viewCnt = viewCnt;
	}
	
	//수정용
	public PostVO(int no, String writer, String title, String contents, String category) {
		super();
		this.no = no;
		this.writer = writer;
		this.title = title;
		this.contents = contents;
		this.category = category;
	}

	@Override
	public String toString() {
		return "PostVO [category=" + category + ", no=" + no + ", writer=" + writer + ", title=" + title + ", contents="
				+ contents + ", regDate=" + regDate + ", viewCnt=" + viewCnt + "]";
	}
	
	
}



