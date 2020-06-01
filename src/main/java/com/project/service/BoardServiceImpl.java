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

// 해당 서비스 객체가 자동으로 생성될 수 있도록 @Service를 붙인다. @Repository, @Component 등과 마찬가지로 root-context.xml에 context:component-scan을 지정해 준다
@Service
public class BoardServiceImpl implements BoardService {
	
	// 자동주입 : @Repository를 써서 자동 생성해논걸 DI
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
		
		PageMaker pageMaker = new PageMaker(); //페이징적용을 위해서 pagemaker선언
		pageMaker.setCri(scri); //scri의 값을 세팅한다 뒤에가면 알겟지만 10개씩 세팅한다. page와  perPagenum을 세팅해준다.
		pageMaker.setTotalCount(dao.listCount(scri)); //총 게시글의 수를 가져와서 세팅한다.
		
		model.addAttribute("pageMaker", pageMaker); //addAttribute는 pagMaker(2)를 "pageMaker"(1)의 이름으로 추가한다 1페이지메이커로 지정한 이름을 통해서 2를 사용한다.
		return dao.list(scri); 
	}
	
	//게시글 읽기
	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(BoardVO boardVO, SearchCriteria scri, Model model, int bno) throws Exception {
		model.addAttribute("read", dao.read(boardVO.getBno())); 
		model.addAttribute("scri", scri);
		
		/*List<ReplyVO> replyList = replyService.readReply(boardVO.getBno()); 
		model.addAttribute("replyList", replyList);*/
			   dao.boardHit(bno);
		return dao.read(bno);
	}
	
	//게시글 수정
	@Override
	public void update(BoardVO boardVO, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		dao.update(boardVO);
	}

	//게시글 삭제
	@Override
	public void delete(int bno, BoardVO boardVO, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		dao.delete(bno);
	}
	
	//댓글 게시물 삭제
	/*@Override
	public int count() throws Exception {
		
		return dao.count();
	}*/
}