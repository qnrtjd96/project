package com.project.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vo.AdminVO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Inject
	private SqlSession sqlSession;
	
	//회원목록 조회
	@Override
	public List<AdminVO> list() throws Exception {

		return sqlSession.selectList("adminMapper.list");
	}
	
	//회원 삭제
	@Override
	public void delete(AdminVO adminVO) throws Exception {
		sqlSession.delete("adminMapper.delete", adminVO);
	}
	
	//게시물 총 개수
	@Override
	public List<AdminVO> boardcount() throws Exception {
		
		return sqlSession.selectList("adminMapper.boardcount");
	}

}
