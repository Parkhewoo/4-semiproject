package com.kh.AttendPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.AttendPro.dao.AdminDao;
import com.kh.AttendPro.dto.AdminDto;

@Controller
@RequestMapping("/join")
public class admincontroller {
	
	@Autowired
	private AdminDao adminDao;
	
	@GetMapping("/join")
	public String regist() {
		return "/WEB-INF/views/join.jsp";
	}
	
	@PostMapping("/join")
	public String regist(@ModelAttribute AdminDto adminDto){
		adminDao.join(adminDto);
		return "redirect:joinComplete";
	}
	
	@RequestMapping("/joinFinish")
	public String registComplete() {
		return"/WEB-INF/views/joinFinish.jsp";
	}
	
	//목록+검색
	@RequestMapping("/list")
	public String list(Model model,
			@RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword) {
				
				boolean isSearch = column !=null && keyword != null;
				model.addAttribute("isSearch",isSearch);
				
				model.addAttribute("column",column);
				model.addAttribute("keyword",keyword);
				
				if(isSearch) {
					model.addAttribute("list",adminDao.selectList(column, keyword));
				}
				else {
					model.addAttribute("list",adminDao.selectList());
				}
				return"/WEB-INF/views/list.jsp"; 
			}
}
