package com.project.vo;

public class Criteria {
	private int page; //보여줄 페이지
	private int perPageNum; //페이지당 보여줄 게시글 수 
	private int rowStart; //각 페이지의 범위 시작 번호 mapper에 rowstart
	private int rowEnd; //각 페이지의 범위 끝번호 rowend
	
	public Criteria() { //최초 디폴트 생성자로 기본객체 생성시 초기값을 지정한다.(1페이지, 10개씩)
		this.page = 1; //사용자가 세팅하지하지 않으면 기본 1이다.
		this.perPageNum = 10; //페이지당 10개의 게시물이 보여지도록 지정
	}
	
	public void setPage(int page) {
		if (page <= 0) { //페이지는 1부터이므로 0보다 작거나 같은값일 경우 무조건 1페이지가 설정하게해준다.
			this.page = 1; //페이지는 1이다.
			return; //리턴
		}
		this.page = page; 
	}
	
	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) { //||는 or을 뜻함 페이지가 0보다 작거나 100보다 크면
			this.perPageNum = 10; //페이지는 10이다.
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	public int getPage() {
		return page;
	}
	
	public int getPageStart() {
		return (this.page - 1) * perPageNum; //
	}
	
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	public int getRowStart() {
		rowStart = ((page - 1) * perPageNum) + 1; //시작 게시물의번호(1,11,21) = ((보여줄페이지 -1) * 페이지당 보여줄 게시글 수) +1
		//시작페이지가 0으로 시작하는것을 방지하기 위해+1을 해줌 . ex)((1-1)*10)+1 = 1 이므로 첫 시작 페이지는 1이다. 
		return rowStart; //이걸 rowstart로 리턴해준다.
	}
	
	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1; //위와 비슷한논리, 끝번호(10,20,30) = 시작번호 + 페이지당 보여줄 게시글 수 -1 
		return rowEnd;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd
				+ "]";
	}
}
