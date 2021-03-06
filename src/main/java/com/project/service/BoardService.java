package com.project.service;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.vo.BoardVO;
import com.project.vo.SearchCriteria;

public interface BoardService {

	// 게시글 작성
	public void write(BoardVO boardVO) throws Exception;
	
	// 게시물 목록 조회
	public List<BoardVO> list(Model model, SearchCriteria scri) throws Exception;
		
	// 게시물 상세보기
	public BoardVO read(BoardVO boardVO, SearchCriteria scri, Model model, int bno) throws Exception;
	
	// 게시물 수정
	public void update(BoardVO boardVO, SearchCriteria scri, RedirectAttributes rttr) throws Exception;
	
	// 게시물 삭제
	public void delete(int bno, BoardVO boardVO, SearchCriteria scri, RedirectAttributes rttr) throws Exception;

}
