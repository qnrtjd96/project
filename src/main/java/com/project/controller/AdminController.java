package com.project.controller;

import javax.inject.Inject; //스프링에서 제공하는 어노테이션, pom.xml에 의존성 추가를 해야한다.

import org.slf4j.Logger; //로깅 로그 찍기, 동일하게 의존성 추가를 해야함 pom.xml
import org.slf4j.LoggerFactory;// 위와 동
import org.springframework.stereotype.Controller;//@controller 어노테이션을 선언하기위해 꼭필요한 것
import org.springframework.ui.Model;//model객체를 사용하기위해 선언 ModelandView랑 차이가 있다. model은 파라미터 방식으로 메소드(model)에 파라미터를 넣어주고 String형태로 리턴함
import org.springframework.web.bind.annotation.RequestMapping; //RequestMapping을 사용하기위해 자동선언
import org.springframework.web.bind.annotation.RequestMethod; //동일
import org.springframework.web.bind.annotation.RequestParam; //동일
import org.springframework.web.servlet.ModelAndView;//modelandview를 선언하기위해 임포트, 컴포넌트 방식으로 modelandview 객체를 생성해서 객체형태로 리턴

import com.project.service.AdminService; //adminservice를 사용하기위해 포함시킨다.
import com.project.vo.AdminVO; //adminVO를 사용하기위해 임포트 시킨다.

@Controller //어노테이션 선언
@RequestMapping("/admin/*") //오청에 대해 어떤 controller, 메소드를 처리할지 맵핑하기위한 어노테이션
public class AdminController { //public 접근제어 admincontroller class에 대한 접근을 제어함

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class); //콘솔에 로그를 남긴다.
	
	@Inject //의존성주입
	AdminService service;
	
	// 회원 목록 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET) //맵핑을 어노테이션 선언  위에 admin과 합쳐져서 /admin/list 로 맵핑 찍은것은 이쪽으로 옴 + 
																 //GET은 url로 보내고 post는 숨겨져서옴 여기서는 Get방식(가져와서 뿌리는거니까)+ get은 가져와서 뿌려주는것 post는 값을 바꾸는것!(게시판 수정)
	public String list(Model model) throws Exception{  //list메소드를 선언해주고  파리미터 model을 넣어주고 보낸다.
		logger.info("list"); //list의 로그찍기
		
		model.addAttribute("list",service.list()); //model에 값을 넣을때에는 addAttribute를 사용한다.
		
		return "admin/list"; //리턴해준다.
	}
	
	// 회원 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)  
	public String delete(@RequestParam("userId") String userId, AdminVO adminVO) throws Exception{ //delete메소드 선언 리퀘스트 usrId를  받아줄 매개변수 userId값을 만들고 adminVO에 담는다
		
		logger.info("delete");
		service.delete(adminVO);
		
		return "redirect:/admin/list";
	}
	
	//차트화면
	@RequestMapping(value = "/chart", method = RequestMethod.GET)
	public ModelAndView list() throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.addObject("boardcount", service.boardcount());
		mv.addObject("replycount", service.replycount());
		mv.addObject("membercount", service.membercount());
		mv.setViewName("/admin/chart");
		return mv; 		
		}
}
