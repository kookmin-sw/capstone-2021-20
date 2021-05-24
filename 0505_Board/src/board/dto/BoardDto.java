package board.dto;

public class BoardDto {
	
	private int seq, count, liked;
	private String writer, title, content, reg_dtm;
	
	public BoardDto() {
		// TODO Auto-generated constructor stub
	}
	
	public BoardDto(int seq, String writer, String title, String content, String reg_dtm) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.reg_dtm = reg_dtm;
	}

	public int getLiked() {
		return liked;
	}

	public void setLiked(int liked) {
		this.liked = liked;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReg_dtm() {
		return reg_dtm;
	}

	public void setReg_dtm(String reg_dtm) {
		this.reg_dtm = reg_dtm;
	}
	
	
}
