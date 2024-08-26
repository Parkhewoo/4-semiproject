package com.kh.AttendPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.AttendPro.dao.WorkerDao;
import com.kh.AttendPro.dto.WorkerDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/worker")
public class WorkerController {

	@Autowired
	private WorkerDao workerDao;
	
	//Worker 로그인
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/worker/login.jsp";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam String workerNo,
								@RequestParam String workerPw,
								HttpSession session) {
		
		//[1]아이디에 해당하는 정보(WorkerDto)를 불러온다
		WorkerDto workerDto = workerDao.selectOne(workerNo);
		if(workerDto == null)
			return "redirect:login?error";
		
		//[2] 1번에서 불러온 정보(WorkerDto)와 비밀번호를 비교
		boolean isValid =workerPw.equals(workerDto.getWorkerPw());
		if(isValid == false)
			return "redirect:login?error";		
		
		//[3] 1,2번에서 쫓겨나지 않았다면 성공으로 간주
		//session.setAttribute("이름", 값);
		session.setAttribute("createdUser", workerNo);
		session.setAttribute("createdRank", workerNo);
		
		return "/WEB-INF/views/worker/course.jsp";//출퇴근 버튼 페이지로 이동
	}
	
	//로그아웃(회원 전용 기능)
		@RequestMapping("/logout")
		public String logout(HttpSession session) {
			session.removeAttribute("createdUser");
			session.removeAttribute("createdRank");
			return "redirect:/";
		}
		
	//근로자 출근
		@GetMapping("/attend")
		public String attend() {
			return "/WEB-INF/views/worker/attend.jsp";
		}
		
		@PostMapping("/attend")
		public String attend(@RequestParam String workerNo) {
			return "";			
		}
	
	//근로자 퇴근
		@GetMapping("/leave")
		public String leave() {
			return "/WEB-INF/views/worker/leave.jsp";			
		}
		
		@PostMapping("/leave")
		public String leave(@RequestParam String workerNo) {
			return "";
		}
}
