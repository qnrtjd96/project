package com.project.service;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.dao.MemberDAO;
import com.project.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;
	
	@Inject//의존성 주입 패스워드 암호화
	private BCryptPasswordEncoder pwdEncoder;
	
	// 회원가입
	@Override
	public void register(MemberVO vo) throws Exception {
		
		//변수 result값을 선언해서 dao에 idchk를 한다음에 vo에 담아서 온다.
		int result = dao.idChk(vo);
		try {
			//result 값이 1이면 리턴한다 (중복이라는 소리임)
			if(result == 1) {
				return;
			//result값이 0이면 
			}else if(result == 0) {
				//inputPass라는 변수선언, vo의 값인 userpass워드를 넣어줄껀대
				String inputpass = vo.getUserPass();
				//pwd변수선언 <- 이 inputpass는 암호화 해서 pwd에 넣어준다.
				String pwd = pwdEncoder.encode(inputpass);
				//이 pwd를 userPass에 보낸다.
				vo.setUserPass(pwd);
				
				//vo에 담고 회원가입 dao로 넘긴다.
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
		
		MemberVO login = dao.login(vo); //login을 dao.login(vo) vo안에담고 login이라는 파라미터로 보낸다 
		System.out.println(login);
		
		boolean pwdMatch;
		if(login != null) {
		pwdMatch = pwdEncoder.matches(vo.getUserPass(), login.getUserPass());
		System.out.println(vo.getUserPass());
		System.out.println(login.getUserPass());
		} else {
		pwdMatch = false;
		}
		
		//만약(null이아닌 로그인 && pwdMathch가 ture라면(userPasswod랑 login. Userpass랑 같다면)
		if(login != null && pwdMatch == true) { 
			//로그인시키고
			session.setAttribute("member", login);
		}else {
			//아니면 메세지를 반환한다.
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
		}
		
		//dao의 vo가담긴 login을 리턴시킨다.
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