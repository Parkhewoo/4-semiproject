package com.kh.AttendPro.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.AttendPro.configuration.CustomCertProperties;
import com.kh.AttendPro.dao.CertDao;
import com.kh.AttendPro.dao.WorkerDao;
import com.kh.AttendPro.dto.CertDto;
import com.kh.AttendPro.dto.WorkerDto;
import com.kh.AttendPro.error.TargetNotFoundException;
import com.kh.AttendPro.service.EmailService2;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/worker")
public class WorkerController {

	@Autowired
	private WorkerDao workerDao;
	
	@Autowired
	private EmailService2 emailService;
	
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
		
		//비밀번호 재설정 페이지
		@GetMapping("/findPw")
		public String findPw() {
			return "/WEB-INF/views/worker/findPw.jsp";
		}

		@PostMapping("/findPw")
		public String findPw(@RequestParam String workerNo, @RequestParam String workerEmail) throws IOException, MessagingException {
			
			WorkerDto workerDto = workerDao.selectOne(workerNo);
			if (workerDto == null) {					
				return "redirect:findPw?error";
			}

			// 이메일 비교
			if (!workerEmail.equals(workerDto.getWorkerEmail())) {// 이메일 불일치
				return "redirect:findPw?error";
			}

			// 템플릿을 불러와서 재설정 메일 발송
			emailService.sendResetPw(workerNo, workerEmail);

			return "redirect:findPwFinish";
		}

		@RequestMapping("/findPwFinish")
		public String findPwFinish() {
			return "/WEB-INF/views/worker/findPwFinish.jsp";
		}
		@Autowired
		private CertDao certDao;
		
		@Autowired
		private CustomCertProperties customCertProperties;
		
		//비밀번호 재설정 페이지
		@GetMapping("/resetPw")
		public String resetPw(@ModelAttribute CertDto certDto,
								@RequestParam String workerNo,
								Model model) {
			boolean isValid = certDao.check(certDto, customCertProperties.getExpire());

			if(isValid) {
				model.addAttribute("certDto", certDto);
				model.addAttribute("workerNo",workerNo);
			return "/WEB-INF/views/worker/resetPw.jsp";
			}
			else {
				throw new TargetNotFoundException("올바르지 않은 접근");
			}
		}
		@PostMapping("/resetPw")
		public String resetPw(@ModelAttribute CertDto certDto,
								@ModelAttribute WorkerDto workerDto) {
			//인증번호 확인
			boolean isValid = certDao.check(certDto, customCertProperties.getExpire());
			if(!isValid) {
				throw new TargetNotFoundException("올바르지 않은 접근");
			}
			
			//비밀번호 변경처리
			workerDao.updateWorkerPw(
					workerDto.getWorkerNo(), workerDto.getWorkerPw());
			return "redirect:resetPwComplete";
		}
		@RequestMapping("/resetPwComplete")
		public String resetPwFinish() {
			return "/WEB-INF/views/worker/resetPwComplete.jsp";
		}
		
}
