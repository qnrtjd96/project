package com.project.dao;

import com.project.vo.VisitCountVO;

public class VisitCountDAO {
	 public int insertVisitor(VisitCountVO vo) throws Exception{
         return insert("VisitCountDAO.insertVisitor",vo);
	 }

	private int insert(String string, VisitCountVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}
}