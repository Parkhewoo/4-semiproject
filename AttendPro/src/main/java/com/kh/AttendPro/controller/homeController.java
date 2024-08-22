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
	public String home(@CookieValue(required = false) String visit,
			Model model, HttpServletResponse response) {
		//쿠키 설정
		if(visit != null) {
			long period = System.currentTimeMillis() - Long.parseLong(visit);
			//System.out.println("방문 텀 = " + period);
			boolean isLongTimeNoSee =  period >= 1L * 60 * 1000;
			model.addAttribute("isLongTimeNoSee", isLongTimeNoSee);
		}
		
		//사용자 방문시각을 쿠키에 기록
		long current = System.currentTimeMillis();
		Cookie ck = new Cookie("visit", String.valueOf(current));
		ck.setMaxAge(Integer.MAX_VALUE);
		response.addCookie(ck);
		
		return "/WEB-INF/views/home.jsp";
	}
}
