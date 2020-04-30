package com.project.dao;

import java.util.List;

import com.project.vo.ReplyVO;

public interface ReplyDAO {

	//댓글조회
	public List<ReplyVO> readReply(int bno) throws Exception;

}
