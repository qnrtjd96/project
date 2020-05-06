package com.project.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String delete(AdminVO adminVO) throws Exception{
		logger.info("delete");
		
		service.delete(adminVO);
		
		return "redirect:/admin/list";
	}
		
	// 회원 탈퇴 post
	@RequestMapping(value="/delete", method = RequestMethod.POST)
	public String memberDelete(AdminVO adminVO, HttpSession session, RedirectAttributes rttr) throws Exception{
		
		System.out.println(adminVO.getUserId());
		service.delete(adminVO);
		session.invalidate();
		return "redirect:/";
		}
}
