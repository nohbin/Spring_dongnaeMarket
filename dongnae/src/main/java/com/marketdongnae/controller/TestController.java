package com.marketdongnae.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.marketdongnae.service.TestService;


@Controller
public class TestController {
	@Autowired
	TestService testService;

	@GetMapping(value = "/testSuccess")
	public ModelAndView test1() {
		return new ModelAndView("testSuccess");
	}
	@GetMapping(value = "/testFail")
	public ModelAndView test2() {
		return new ModelAndView("testFail");
	}

	@GetMapping(value = "/insert")
	public ModelAndView insert() {
		ModelAndView mv = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
			map.put("m_id", "testId2");
			map.put("m_pwd", "testPwd2");
			map.put("m_email", "test2@a.com");
			map.put("m_name", "testName2");
			map.put("m_phone", "22");
			map.put("si_id", "3");
		String m_id = testService.insert(map);
		if(m_id == null)
			mv.setViewName("redirect:/testFail");
		else
			mv.setViewName("redirect:/testSuccess");
		return mv;
	}
}