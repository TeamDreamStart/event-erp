package kr.co.dreamstart.dto;

public class PageVO {

	//페이지 총 갯수
	private int total;
	// 보여지는 페이지 중 첫번째 페이지
	private int startPage;
	// 마지막 페이지
	private int endPage;
	private boolean prev, next;
	private Criteria cri;

	// 한번에 보여지는 목록 갯수
	private int displayPageNum = 10;

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	public void setTotalCount(int total) {
		this.total = total;
		calcData();
	}

	private void calcData() {
		// 현재 페이지 그룹의 끝 번호 계산
		endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);

		// 시작 페이지
		startPage = (endPage - displayPageNum) + 1;

		// 실제 마지막 페이지 (전체 데이터 건수 기반)
		int realEnd = (int) Math.ceil((double) total / cri.getPerPageNum());

		if (endPage > realEnd) {
			endPage = realEnd;
		}

		// 이전/다음 버튼 여부
		prev = startPage > 1;
		next = endPage < realEnd;
	}


	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}

	@Override
	public String toString() {
		return "PagingVO [total=" + total + ", startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev
				+ ", next=" + next + ", cri=" + cri + ", displayPageNum=" + displayPageNum + "]";
	}

}
