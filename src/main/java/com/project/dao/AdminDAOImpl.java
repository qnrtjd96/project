package com.project.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vo.AdminVO;
import com.project.vo.SearchCriteria;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Inject
	private SqlSession sqlSession; //mybatis 연동을 위해서
	
	//회원목록 조회
	@Override
	public List<AdminVO> list(SearchCriteria scri) throws Exception {
		
		return sqlSession.selectList("adminMapper.list", scri); //리스트를 뽑아내는 거기 때문에 selectList
	}
	
	//회원 삭제
	@Override
	public void delete(AdminVO adminVO) throws Exception {
		sqlSession.delete("adminMapper.delete", adminVO); //리턴할 필요가없고, adminVO안에 담긴값을 삭제하려고 
	}
	
	//게시물 총 개수
	@Override
	public int boardcount() throws Exception {
		
		return sqlSession.selectOne("adminMapper.boardcount");
	}
	
	//댓글 총 개수
	@Override
	public int replycount() throws Exception {
		
		return sqlSession.selectOne("adminMapper.replycount");
	}
	
	//회원 총 개수
	@Override
	public int membercount(SearchCriteria scri) throws Exception {
		
		return sqlSession.selectOne("adminMapper.membercount");
	}
}
