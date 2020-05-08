package com.project.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.AdminService;
import com.project.vo.AdminVO;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Inject
	AdminService service;
	
	// 회원 목록 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) throws Exception{
		logger.info("list");
		
		model.addAttribute("list",service.list());
		
		return "admin/list";
		
	}
	
	// 회원 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(@RequestParam("userId") String userId, AdminVO adminVO) throws Exception{
		
		logger.info("delete");
		
		service.delete(adminVO);
		
		return "redirect:/admin/list";
	}
	
	/*1번째 방법// 회원 삭제
	@RequestMapping(value = "/delete/{userId}", method = RequestMethod.GET)
	public String delete(@PathVariable String userId, AdminVO adminVO) throws Exception{
		
		System.out.println("넘어오니안넘어오니 넘어와라 얍 ====="+ userId);
		
		logger.info("delete");
		
		service.delete(adminVO);
		
		return "redirect:/admin/list";
	}*/
	
	/*	 차트 화면
		@RequestMapping(value = "/chart", method = RequestMethod.GET)
		public String boardcount(Model model) throws Exception{
			logger.info("===========================chart===============================");
			
			model.addAttribute("boardcount",service.boardcount());
			
			return "/admin/chart";*/
	
	//차트화면
	@RequestMapping(value = "/chart", method = RequestMethod.GET)
	public ModelAndView chart(@RequestParam("boardResult") int boardResult, Model model ) throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/chart");
		mv.addObject("model",model);
		
		return mv;
	}
}
