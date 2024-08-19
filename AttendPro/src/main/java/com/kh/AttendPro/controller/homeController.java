package com.kh.AttendPro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class homeController {

	@RequestMapping("/")//가장 짧은 주소
	public String home() {
		return "/WEB-INF/views/home.jsp";
	}
}
