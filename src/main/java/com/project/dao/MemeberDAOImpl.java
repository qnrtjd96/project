package com.project.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vo.MemberVO;

@Repository
public class MemeberDAOImpl implements MemberDAO {

	@Inject
	private SqlSession sql;

	//회원가입
	@Override
	public void register(MemberVO vo) throws Exception {
		
		sql.insert("memberMapper.register", vo);
	}
	
	//로그인
	@Override
	public MemberVO login(MemberVO vo) throws Exception {

		return sql.selectOne("memberMapper.login", vo);
	}
	
	//회원정보수정
	@Override
	public void memberUpdate(MemberVO vo) throws Exception {
		sql.update("memberMapper.memberUpdate", vo); 
	}
	
	//회원삭제
	@Override
	public void memberDelete(MemberVO vo) throws Exception {

		sql.delete("memberMapper.memberDelete", vo);
	}
	

}
