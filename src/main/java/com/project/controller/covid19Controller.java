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
}