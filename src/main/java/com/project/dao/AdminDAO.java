package com.project.dao;

import java.util.List;

import com.project.vo.AdminVO;

public interface AdminDAO {
	
	// 회원 목록 조회
	public List<AdminVO> list() throws Exception;
	
	// 회원 삭제
	public void delete(AdminVO AdminVO) throws Exception;
	
	// 게시물 총 개수
	public int boardcount() throws Exception;

}
