package com.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.dao.AdminDAO;
import com.project.vo.AdminVO;

@Service
public class AdminServiceImpl implements AdminService { //구현부(adminserviceImpl)가 상속한다. 인터페이스(adminService)를 	implements와extends와의 큰 차이점은 부모의 메서드를 무조건 다시 override해주어야 된다는 것을 알 수 있다.
														/*	1. extends는 일반 클래스와 abstract 클래스 상속에 사용되고, implement는 interface 상속에 사용된다.
															2. class가 class를 상속받을 땐 extends를 사용하고, interface가 interface를 상속 받을 땐 extends를 사용한다.
															3. class가 interface를 사용할 땐 implements를 써야하고
															4. interface가 class를 사용할 땐 implements를 쓸수 없다.
															5. extends는 클래스 한 개만 상속 받을 수 있다.
															6. extends 자신 클래스는 부모 클래스의 기능을 사용한다.
															7. implements는 여러개 사용 가능하다.
															8. implements는 설계 목적으로 구현 가능하다.
															9. implements한 클래스는 implements의 내용을 다 사용해야 한다.*/

	@Inject
	private AdminDAO dao;
	
	// 회원 목록 조회
	@Override
	public List<AdminVO> list() throws Exception { //list<AdminVO>인터페이스에서 내린걸 다시선언  

		return dao.list();//dao에게 전달함list를
	}

	// 회원 삭제
	@Override
	public void delete(AdminVO adminVO) throws Exception { //void는 리턴할 값이 없을 때 쓰임 , 회원을 삭제시키기만 하면 대는거기 때문에 void를 쓰는것이 맞음
		dao.delete(adminVO); //adminVO에 값을 담아서 던짐
	}
	
	//게시물 총 개수
	@Override
	public int boardcount() throws Exception {
		
		return dao.boardcount();
	}
	
	//댓글 총 개수
	@Override
	public int replycount() throws Exception {
		
		return dao.replycount();
	}
	
	//회원 총 개수
	@Override
	public int membercount() throws Exception {
		
		return dao.membercount();
	}
}