package com.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.dao.MemberDAO;
import com.project.vo.MemberVO;
import com.project.vo.SearchCriteria;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;
	
	// 회원가입
	@Override
	public void register(MemberVO vo) throws Exception {
		
	dao.register(vo);
	
	}
	//로그인
	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		return dao.login(vo);
	
	}
}