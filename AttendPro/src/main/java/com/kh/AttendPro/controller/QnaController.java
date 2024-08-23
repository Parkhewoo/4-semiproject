package com.kh.AttendPro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.AttendPro.vo.PageVO;


@Controller
@RequestMapping("/QnA")
public class QnaController {
	
	@RequestMapping("list")
	public String list(@ModelAttribute("PageVO") PageVO pageVo ,Model model) {
		
		return "/WEB-INF/views/QnA/list.jsp";
	}
	
}
