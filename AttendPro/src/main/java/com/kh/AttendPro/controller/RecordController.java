package com.kh.AttendPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.kh.AttendPro.dao.RecordDao;

import jakarta.servlet.http.HttpSession;

@Controller
public class RecordController {
	
	@Autowired
	RecordDao recordDao;
	
	@PostMapping("/checkIn")
	public String checkIn(HttpSession session) {
		String createdUser = (String) session.getAttribute("createdUser");
		recordDao.checkIn(createdUser);
		return "/";
	}
	
	//당일 출근 기록이 없을 경우 접근 불가 
	@PostMapping("/checkOut")
	public String checkOut(HttpSession session) {
		String createdUser = (String) session.getAttribute("createdUser");
		recordDao.checkIn(createdUser);
		return "/";
	}
	
}
