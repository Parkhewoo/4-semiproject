package com.kh.AttendPro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class homeController {

	@RequestMapping("/")//가장 짧은 주소
	public String home(Model model, HttpServletResponse response) {

		
		return "/WEB-INF/views/home.jsp";
	}
}
