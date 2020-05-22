package com.project.service;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.dao.MemberDAO;
import com.project.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;
	
	// 회원가입
	@Override
	public void register(MemberVO vo) throws Exception {
		int result = dao.idChk(vo);
		try {
			if(result == 1) {
				return;
			}else if(result == 0) {
				dao.register(vo);
			}
			// 요기에서~ 입력된 아이디가 존재한다면 -> 다시 회원가입 페이지로 돌아가기 
			// 존재하지 않는다면 -> register
		} catch (Exception e) {
			throw new RuntimeException();
		}
	}
	//로그인
	@Override
	public MemberVO login(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr, HttpServletRequest request) throws Exception {
		
		HttpSession session = req.getSession();
		MemberVO login = dao.login(vo);
		MemberVO.setLoginIp(request.getRemoteAddr());
		if(login == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
			return login;
		}else {
			session.setAttribute("member", login);
		}
		
		return dao.login(vo);
	}
	
	//회원정보수정
	@Override
	public void memberUpdate(MemberVO vo, HttpSession session) throws Exception {
		session.invalidate();
		dao.memberUpdate(vo);
	}
	
	//회원탈퇴
	@Override
	public void memberDelete(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		
		// 세션에 있는 member를 가져와 member변수에 넣어줍니다.
		MemberVO member = (MemberVO) session.getAttribute("member");
		// 세션에있는 비밀번호
		String sessionPass = member.getUserPass();
		// vo로 들어오는 비밀번호
		String voPass = vo.getUserPass();
		
		if(!(sessionPass.equals(voPass))) {
			rttr.addFlashAttribute("msg", false);
			return;
		}
		session.invalidate();
		dao.memberDelete(vo);
	}
	
	// 아이디 중복 체크
	@Override
	public int idChk(MemberVO vo) throws Exception {
		int result = dao.idChk(vo);
		return result;
	}
	
}