package com.project.service;

import java.util.List;

import com.project.vo.MemberVO;
import com.project.vo.SearchCriteria;

public interface MemberService {

	// 회원가입
	public void register(MemberVO vo) throws Exception;
	
	//로그인
	public MemberVO login(MemberVO vo) throws Exception;

}
