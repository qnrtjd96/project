package com.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.dao.BoardDAO;
import com.project.vo.BoardVO;
import com.project.vo.PageMaker;
import com.project.vo.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;
	
	// 게시글 작성
	@Override
	public void write(BoardVO boardVO) throws Exception {
		dao.write(boardVO);
	}
	
	// 게시물 목록 조회
	@Override
	public List<BoardVO> list(Model model, SearchCriteria scri) throws Exception {
		model.addAttribute("list", dao.list(scri)); //모델에 list를 뽑아올건대, scri의 값을 넣어온다.
		PageMaker pageMaker = new PageMaker(); //페이징적용
		pageMaker.setCri(scri); //scri의 값을 세팅한다 뒤에가면 알겟지만 10개씩 세팅(xml에서 알수 있음)
		pageMaker.setTotalCount(dao.listCount(scri)); //totlcount를 service로 보내는데, scri에 값을 담음
		
		model.addAttribute("pageMaker", pageMaker); //addAttribute는 pagMaker(2)를 "pageMaker"(1)의 이름으로 추가한다 1페이지메이커로 지정한 이름을 통해서 2를 사용한다.
		return dao.list(scri);
	}
	//게시물 총갯수
	public int listCount(SearchCriteria scri) throws Exception {
		return dao.listCount(scri);
	}
	
	//게시글 읽기
	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(int bno) throws Exception {
			   dao.boardHit(bno);
		return dao.read(bno);
	}
	
	//게시글 수정
	@Override
	public void update(BoardVO boardVO, SearchCriteria scri, Model model, RedirectAttributes rttr) throws Exception {
		
		model.addAttribute("update", dao.read(boardVO.getBno())); 
		model.addAttribute("scri", scri);
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		dao.update(boardVO);
	}

	//게시글 삭제
	@Override
	public void delete(int bno) throws Exception {
		
		dao.delete(bno);
	}
	
	//댓글 게시물 삭제
	/*@Override
	public int count() throws Exception {
		
		return dao.count();
	}*/
}