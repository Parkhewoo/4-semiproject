package com.kh.AttendPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.AttendPro.dao.AdminDao;
import com.kh.AttendPro.dto.AdminDto;

@Controller
@RequestMapping("/")
public class admincontroller {
	
	@Autowired
	private AdminDao adminDao;
	
	@GetMapping("/join")
	public String regist() {
		return "/WEB-INF/views/join.jsp";
	}
	
	@PostMapping("/join")
	public String regist(@ModelAttribute AdminDto adminDto){
		adminDao.regist(adminDto);
		return "redirect:joinComplete";
	}
	
	@RequestMapping("/joinFinish")
	public String registComplete() {
		return"/WEB-INF/views/joinFinish.jsp";
	}
}
