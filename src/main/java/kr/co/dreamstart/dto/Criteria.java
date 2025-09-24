package kr.co.dreamstart.dto;

public class Criteria {
	//현재 페이지
	private int page;
	// 페이지당 표시할 레코드 갯수
	private int perPageNum;

	/*
	 * 기본 생성자
	 * page perPageNum을 따로 지정해 주지 않으면 기본값을 각각 1, 10으로 부여한다.
	 */	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}

	public Criteria(int page, int perPageNum) {
		super();
		this.page = page;
		this.perPageNum = perPageNum;
	}

	public int getPage() {
		return page;
	}

	// 페이지 갯수가 0 이하로 지정되면 1로 값을 준다
	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}

	/*
	 * public int getPerPageNum() { return perPageNum; }
	 */

	// 페이지 당 표시되는 게시글 갯수가 0 이하 100이상으로 지정되면 10으로
	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	// sql Mapper 를 위한 메소드
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]";
	}

}
