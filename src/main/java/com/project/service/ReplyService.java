package com.project.service;

import java.util.List;

import com.project.vo.ReplyVO;

public interface ReplyService {

	public List<ReplyVO> readReply(int bno) throws Exception;

}
