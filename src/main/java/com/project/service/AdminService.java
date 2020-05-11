package com.project.service;

import java.util.List;

import com.project.vo.AdminVO;

public interface AdminService {

	// 회원 목록 조회
	public List<AdminVO> list() throws Exception;
	
	// 회원 삭제
	public void delete(AdminVO	adminVO) throws Exception;
	
	// 게시물 총개수
	public int boardcount() throws Exception;

}
