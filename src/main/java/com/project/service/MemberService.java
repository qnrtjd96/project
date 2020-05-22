package com.project.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.vo.MemberVO;

public interface MemberService {

	// 회원가입
	public void register(MemberVO vo) throws Exception;
	
	//로그인
	public MemberVO login(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr, HttpServletRequest request) throws Exception;
	
	//회원정보수정
	public void memberUpdate(MemberVO vo, HttpSession session) throws Exception;

	//회원삭제
	public void memberDelete(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception;
	
	//회원가입(아이디) 중복체크
	public int idChk(MemberVO vo) throws Exception;
}
