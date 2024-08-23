package com.kh.AttendPro.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.AttendPro.dao.AdminDao;
import com.kh.AttendPro.dto.AdminDto;


@Controller
@RequestMapping("/sysadmin")
public class SysAdminController {
	
	@Autowired
	private AdminDao adminDao;

	
	@RequestMapping("/home")
	public String home() {
		return "/WEB-INF/views/sysadmin/home.jsp";
	}
	
	
	// "/sysadmin/list" 페이지 기능구현 - 08/23 박관일
	 @RequestMapping("/list")
	    public String list(Model model,
	                       @RequestParam(required = false) String column,
	                       @RequestParam(required = false) String keyword) {

	        boolean isSearch = column != null && keyword != null;
	        List<AdminDto> list = isSearch ? adminDao.selectList(column, keyword) : adminDao.selectList();

	        model.addAttribute("list", list);
	        model.addAttribute("keyword", keyword);

	        return "/WEB-INF/views/sysadmin/list.jsp";
	    }
	
	@RequestMapping("/detail")
	public String detail() {
		
		
		return "/WEB-INF/views/sysadmin/detail.jsp";
	}
	
//	@RequestMapping("/delete")
//	public String delete(@RequestParam String adminId) {
//		
//	}
}
