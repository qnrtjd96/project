package com.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/covid19/*")
public class covid19Controller {

	private static final Logger logger = LoggerFactory.getLogger(covid19Controller.class);
	
	// 코로나 진료소 연결
	@RequestMapping(value = "/covid19/clinic2", method = RequestMethod.GET)
	public void clinic2() throws Exception{
		logger.info("clinic2");	
	}
	
	// 마스크 판매현황 연결
	@RequestMapping(value = "/covid19/mask", method = RequestMethod.GET)
	public void mask() throws Exception{
		logger.info("mask");	
		
	}
	// 위치정보 받아오기 Test
	@RequestMapping(value = "/covid19/back_mask2", method = RequestMethod.GET)
	public void back_mask2() throws Exception{
		logger.info("clinic");	
	}
	
	// ip 받아오기 Test
	@RequestMapping(value = "/covid19/ip", method = RequestMethod.GET)
	public void ip() throws Exception{
		logger.info("ip");	
	}
	
	// 어느 브라우저로 들어왔나  Test
	@RequestMapping(value = "/covid19/browser", method = RequestMethod.GET)
	public void browser() throws Exception{
		logger.info("ip");	
	}
}