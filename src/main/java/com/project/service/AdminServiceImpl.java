package com.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.dao.AdminDAO;
import com.project.vo.AdminVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	private AdminDAO dao;
	
	// 회원 목록 조회
	@Override
	public List<AdminVO> list() throws Exception {

		return dao.list();
	}

	// 회원 삭제
	@Override
	public void delete(AdminVO adminVO) throws Exception {
		dao.delete(adminVO);
	}
	
	//게시물 총 개수
	@Override
	public int boardcount() throws Exception {
		
		return dao.boardcount();
	}
}