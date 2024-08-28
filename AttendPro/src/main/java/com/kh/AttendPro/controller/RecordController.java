package com.kh.AttendPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.AttendPro.dao.RecordDao;

@Controller
@RequestMapping("/record")
public class RecordController {
	
	@Autowired
	RecordDao recordDao;
	
	//출퇴근 버튼이 있는 테스트용 임시 페이지, 삭제 예정
//	@RequestMapping("/test")
//	public String main() {
//		return "/WEB-INF/views/worker/test.jsp";
//	}

	@PostMapping("/checkIn")
	public String checkIn(@RequestParam("createdUser") String createdUserStr) {
		int createdUser = Integer.parseInt(createdUserStr);
        recordDao.checkIn(createdUser);
		return "redirect:/";
	}
	
//	당일 출근 기록이 없을 경우 접근 불가 
	@PostMapping("/checkOut")
	public String checkOut(@RequestParam("createdUser") String createdUserStr) {
		int createdUser = Integer.parseInt(createdUserStr);
        recordDao.checkOut(createdUser);
		return "redirect:/";
	}
	
}
