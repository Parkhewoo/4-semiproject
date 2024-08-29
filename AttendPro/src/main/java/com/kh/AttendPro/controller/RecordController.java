package com.kh.AttendPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	//출퇴근 버튼이 있는 테스트용 임시 페이지, 삭제 예정
//	@RequestMapping("/test")
//	public String main() {
//		return "/WEB-INF/views/worker/test.jsp";
//	}

	@RequestMapping("/check")
	public String check(HttpSession session,
			Model model) {
		Integer createdUser = (Integer) session.getAttribute("createdUser");
		int workerNo = createdUser; // 직접 int로 사용
		boolean isCome = recordDao.getIsCome(workerNo); // 당일 출근 기록 검사
		model.addAttribute("isCome", isCome); // 출근 여부를 모델에 추가
		return "/WEB-INF/views/worker/check.jsp";
	}
	
	@PostMapping("/checkIn")
	public String checkIn(@RequestParam("createdUser") String workerNoStr) {
		int workerNo = Integer.parseInt(workerNoStr);
        recordDao.checkIn(workerNo);
		return "redirect:/";
	}
	
//	당일 출근 기록이 없을 경우 접근 불가 
	@PostMapping("/checkOut")
	public String checkOut(@RequestParam("createdUser") String workerNoStr) {
		int workerNo = Integer.parseInt(workerNoStr);
        recordDao.checkOut(workerNo);
		return "redirect:/";
	}
	
}
