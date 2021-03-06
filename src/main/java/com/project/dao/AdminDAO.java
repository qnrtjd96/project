package com.project.dao;

import java.util.List;

import com.project.vo.AdminVO;
import com.project.vo.SearchCriteria;

public interface AdminDAO {
	
	// 회원 목록 조회
	public List<AdminVO> list(SearchCriteria scri) throws Exception;
	
	// 회원 삭제
	public void delete(AdminVO AdminVO) throws Exception;
	
	// 게시물 총 개수
	public int boardcount() throws Exception;
	
	// 댓글 총 개수
	public int replycount() throws Exception;
	
	// 멤버 총 개수
	public int membercount(SearchCriteria scri) throws Exception;

}
