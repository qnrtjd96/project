package com.project.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {

	private int totalCount; //전체 게시물의 수
	private int startPage; // 화면에 보여질 첫번쨰 번호, 시작페이지 번호
	private int endPage;// 화면에 보여질 끝 번호, 끝 번호
	private boolean prev;//이전 버튼을 누를수 있는 경우/없는 경우를 분류하기 위함
	private boolean next;//다음 버튼을 누를수 있는 경우/없는 경우를 분류하기 위함
	private int displayPageNum = 10;//화면페이지 하단에 보여줄 게시글 갯수
	private Criteria cri; //Criteria값을 쓸꺼기 때문에 선언한다.
	
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData(); //calcData를 호출 전체 필드 변수들 세팅: 전체 게시글의 수의 setter가 호출될때 전체 세팅되도록 함
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	 
	public boolean isPrev() {
		return prev;
	}
	
	public boolean isNext() {
		return next;
	}
	
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	
	public Criteria getCri() {
		return cri;
	}
	 
	private void calcData() {//전체 필드 변수 값들을 계산하는 메서드
		//끝페이지=(현재페이지 번호/페이지 번호의 개수)*페이지 번호의 갯수  //현재페이지의 블록의 끝번호
		endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum); //(무조건올림 Math.ceil이 올려주는 역할을 함)
		
		//시작페이지(끝페이지-페이지 번호의 갯수) +1 //현재페이지의 블록의 시작번호
		startPage = (endPage - displayPageNum) + 1; //+1을 한 이유는 첫페이지가 0이 아닌 1로 시작하게 하기위해 1~10, 11~20
		
		
		//tempEndPage는 페이지네이션의 갯수이다. 페이지네이션의 갯누는 총 게시물/한화면에 출력될 게시물수  >> 총개시물/10이다.
		int tempEndPage = (int) (Math.ceil(totalCount / (double)cri.getPerPageNum()));//(총 게시물수 / 한페이지당 보여줄 게시물갯수)
		//
		if (endPage > tempEndPage) { //endPage가 tempEndPage 보다 크다면
			endPage = tempEndPage; //같다고 표시한다.
		}
		prev = cri.getPage() == 1 ? false : true; //이전 startpage==1이면(1페이지면 이전을 누를수 없게) false : ture;
		next = cri.getPage() * cri.getPerPageNum() >= totalCount ? false : true; //다음 엔트페이지 * perpageNum가 >>> 총게시물  크거나 같으면 false: true;
	}
	
	public String makeQuery(int page) {  //검색할때 쓰는   메소드
		UriComponents uriComponents = //UriComponents는 path나 query에 해당하는 문자열들을 추가해서 원하는 uri를 생성한다.
		UriComponentsBuilder.newInstance() //객체생성
						    .queryParam("page", page) //페이지 추가
							.queryParam("perPageNum", cri.getPerPageNum()) //페이지 갯수추가 / 페이지의 갯수가 정해진다.
							.build();
		   
		return uriComponents.toUriString(); //다시리턴
	}
	
	public String makeSearch(int page) //위에 꺼랑 비슷함 검색할때 쓰는 메소드
	{
	 //UriComponents는 path나 query에 해당하는 문자열들을 추가해서 원하는 uri를 생성한다.
	 UriComponents uriComponents = UriComponentsBuilder.newInstance() //객체생성
	            .queryParam("page", page) //페이지 추가
	            .queryParam("perPageNum", cri.getPerPageNum()) //한페이지의 갯수
	            .queryParam("searchType", ((SearchCriteria)cri).getSearchType()) //SearchType을 가져오고
	            .queryParam("keyword", encoding(((SearchCriteria)cri).getKeyword()))//keyword를 가져온다.
	            .build(); 
	    return uriComponents.toUriString();   
	}

	private String encoding(String keyword) {
		if(keyword == null || keyword.trim().length() == 0) { //키워드가 null이거나 length가 0이면 리턴시킨다.
			return "";
		}
		 
		try {
			return URLEncoder.encode(keyword, "UTF-8"); 
		} catch(UnsupportedEncodingException e) { 
			return ""; 
		}
	}
}
