package com.kh.AttendPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.AttendPro.dao.RegistDao;
import com.kh.AttendPro.dto.AdminDto;

@Controller
@RequestMapping("/admin")
public class admincontroller {
	@Autowired
	private RegistDao registDao;
	
	@GetMapping("/regist")
	public String regist() {
		return "/WEB-INF/views/admin/regist.jsp";
	}
	
	
	@PostMapping("/regist")
	public String regist(@ModelAttribute AdminDto adminDto){
		registDao.regist(adminDto);
		return "redirect:registComplete";
	}
	
	@RequestMapping("registComplete")
	public String registComplete() {
		return"/WEB-INF/views/admin/regist2.jsp";
	}
}
