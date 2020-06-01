package com.project.service;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.vo.ReplyVO;
import com.project.vo.SearchCriteria;

public interface ReplyService {

	//댓글 조회
	public List<ReplyVO> readReply(int bno) throws Exception;
	
	//댓글 작성
	public void writeReply(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception;
	
	//댓글 수정
	public void updateReply(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception;
	
	//댓글 삭제
	public void deleteReply(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception;
		
	//선택된 댓글 조회
	public ReplyVO selectReply(int rno) throws Exception;

	//댓글수정뷰
	public void replyUpdateView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception;
	
	//댓글 삭제뷰
	public void replyDeleteView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception;
	
	}
