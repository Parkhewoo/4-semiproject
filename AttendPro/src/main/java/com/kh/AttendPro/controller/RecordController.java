package com.kh.AttendPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.AttendPro.dao.RecordDao;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/record")
public class RecordController {
	
	@Autowired
	RecordDao recordDao;
	
	@RequestMapping("/test")
	public String main() {
		return "/WEB-INF/views/worker/test.jsp";
	}

	@PostMapping("/checkIn")
	public String checkIn(HttpSession session) {
		String createdUser = (String) session.getAttribute("createdUser");
		recordDao.checkIn(Integer.parseInt(createdUser));
		return "/";
	}
	 
	//테스트용으로 삭제 예정
	//@PostMapping("/checkIn")
	public String checkIn(@RequestParam int no) {
		recordDao.checkIn(no);
		return "/";
	}
	
	//당일 출근 기록이 없을 경우 접근 불가 
	@PostMapping("/checkOut")
	public String checkOut(HttpSession session) {
		String createdUser = (String) session.getAttribute("createdUser");
		recordDao.checkIn(Integer.parseInt(createdUser));
		return "/";
	}
	
}
