package bank.board.vo;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;

public class BoardVO {

		private int no;
		
		@Length(min=2, max=50, message = "최소 2글자 이상 50글자 이하로 써주세요.")
		@NotEmpty(message = "제목을 뭘로 할까요?")
		private String title;
		
		@Pattern(regexp = "^[A-Za-z0-9가-힣]*$", message = "특수문자와 한글은 사용할 수 없어요.")
		@NotEmpty(message = "누가 적은걸까요?")
		private String writer;
		private String content;
		private int viewCnt;
		private String regDate;
		
		
		private int replyCnt;
		
		
		public BoardVO() {
			super();
		}

		public int getNo() {
			return no;
		}

		public void setNo(int no) {
			this.no = no;
		}

		public String getTitle() {
			return title;
		}
		
		public void setTitle(String title) {
			this.title = title;
		}

		public String getWriter() {
			return writer;
		}

		public void setWriter(String writer) {
			this.writer = writer;
		}

		public String getContent() {
			return content;
		}

		public void setContent(String content) {
			this.content = content;
		}

		public int getViewCnt() {
			return viewCnt;
		}

		public void setViewCnt(int viewCnt) {
			this.viewCnt = viewCnt;
		}

		public String getRegDate() {
			return regDate;
		}

		public void setRegDate(String regDate) {
			this.regDate = regDate;
		}
		

		public int getReplyCnt() {
			return replyCnt;
		}

		public void setReplyCnt(int replyCnt) {
			this.replyCnt = replyCnt;
		}

		

		public BoardVO(int no, String title, String writer,
				String content, int viewCnt, String regDate, int replyCnt) {
			super();
			this.no = no;
			this.title = title;
			this.writer = writer;
			this.content = content;
			this.viewCnt = viewCnt;
			this.regDate = regDate;
			this.replyCnt = replyCnt;
		}

		@Override
		public String toString() {
			return "BoardVO [no=" + no + ", title=" + title + ", writer=" + writer + ", content=" + content
					+ ", viewCnt=" + viewCnt + ", regDate=" + regDate + ", replyCnt=" + replyCnt + "]";
		}

		
}
