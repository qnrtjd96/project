package com.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.dao.ReplyDAO;
import com.project.vo.ReplyVO;
import com.project.vo.SearchCriteria;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Inject
	private ReplyDAO dao;

	// 댓글 목록
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		
		return dao.readReply(bno);
	}
	
	// 댓글 작성
	@Override
	public void writeReply(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		dao.writdReply(vo);
	}

	// 댓글 수정
	@Override
	public void updateReply(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());		
		
		dao.updateReply(vo);
	}

	// 댓글 삭제
	@Override
	public void deleteReply(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		dao.deleteReply(vo);
	}

	// 선택된 댓글 조회
	@Override
	public ReplyVO selectReply(int rno) throws Exception {
		return dao.selectReply(rno);
	}
	
	//댓글 수정뷰 
	@Override
	public void replyUpdateView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception {
		model.addAttribute("replyUpdate", dao.selectReply(vo.getRno()));
		model.addAttribute("scri", scri);
	}
	
	//댓글 삭제뷰
	public void replyDeleteView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception {
		model.addAttribute("replyDelete", dao.selectReply(vo.getRno()));
		model.addAttribute("scri", scri);
	}

}
