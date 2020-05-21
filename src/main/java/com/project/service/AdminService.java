package com.project.service;

import java.util.List;

import com.project.vo.AdminVO;

public interface AdminService {  //접근제어 인터페이스(인터페이스 인것을 알 수 있음)

	// 회원 목록 조회
	public List<AdminVO> list() throws Exception;  
	
	// 회원 삭제
	public void delete(AdminVO	adminVO) throws Exception;
	
	// 게시물 총개수
	public int boardcount() throws Exception;
	
	// 댓글 총개수
	public int replycount() throws Exception;
	
	// 회원 총개수
	public int membercount() throws Exception;
}
