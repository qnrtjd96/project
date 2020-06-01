package com.project.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vo.BoardVO;
import com.project.vo.SearchCriteria;

@Repository //자동 객체 생성 특히, dao를 지칭하는 말이기도함(스프링이 알아서 관리해주게됨) : 이게 자동으로 생성되려면 설정파일에서 <context:component-scan 지정필요>

public class BoardDAOImpl implements BoardDAO {
	
	// 설정파일에서 생성한 sqlSessionTemplate 객체를 자동 주입한다.(Autowired, Resource 와 유사함)
	@Inject
	private SqlSession sqlSession;
	
	// 게시글 작성
	@Override
	public void write(BoardVO boardVO) throws Exception {
		sqlSession.insert("boardMapper.insert", boardVO);	
	}
	
	// 게시물 목록 조회
	@Override
	//페이징 처리를 위한 메서드
	public List<BoardVO> list(SearchCriteria scri) throws Exception {
		return sqlSession.selectList("boardMapper.listPage", scri);
	}
	// 게시물 총 갯수
	@Override
	public int listCount(SearchCriteria scri) throws Exception{
		return sqlSession.selectOne("boardMapper.listCount");
	}
	
	// 게시물 조회
	@Override
	public BoardVO read(int bno) throws Exception {
		return sqlSession.selectOne("boardMapper.read", bno); //게시글 번호를 받아 DB작업을 통해 현재 게시판 정보를 DTO에 담아 반환
	} 
	
	// 게시물 수정
	@Override
	public void update(BoardVO boardVO) throws Exception {
		sqlSession.update("boardMapper.update", boardVO);
	}

	// 게시물 삭제
	@Override
	public void delete(int bno) throws Exception {
		sqlSession.delete("boardMapper.delete", bno);
	}

	// 게시글 조회수
	@Override
	public void boardHit(int bno) throws Exception {
		sqlSession.update("boardMapper.boardHit", bno);
	}

}
