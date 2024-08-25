package com.kh.AttendPro.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.AttendPro.dao.AdminDao;
import com.kh.AttendPro.dao.BlockDao;
import com.kh.AttendPro.dao.WorkerDao;
import com.kh.AttendPro.dto.AdminDto;
import com.kh.AttendPro.dto.BlockDto;
import com.kh.AttendPro.service.EmailService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class admincontroller {
	
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private WorkerDao workerDao;
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private BlockDao blockDao;
	
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/admin/join.jsp";
	}
	
	@Transactional
	@PostMapping("/join")
	public String join(@ModelAttribute AdminDto adminDto, Model model){
		if (adminDto.getAdminRank() == null || adminDto.getAdminRank().isEmpty()) {
	        model.addAttribute("error", "등급을 선택해 주세요.");
	        return "/WEB-INF/views/admin/join.jsp";
	    }
		
	    adminDao.join(adminDto);
		return "redirect:joinFinish";
	}
	
	
	@RequestMapping("/joinFinish")
	public String registComplete() {
		return"/WEB-INF/views/admin/joinFinish.jsp";
	}
	
	//Admin 로그인 기능
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/admin/login.jsp";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam String adminId,
						@RequestParam String adminPw,						
						HttpSession session) {
		
		//[1]Admin 아이디를 AdminDto에서 불러온다		
		AdminDto adminDto = adminDao.selectOne(adminId);
		if (adminDto == null)
			return "redirect:login?error";

		//[2] 1에서 불러온 정보(AdminDto)와 비밀번호를 비교
		boolean isValid = adminPw.equals(adminDto.getAdminPw());
		if (isValid == false)
			return "redirect:login?error";
		
		
		//[3] 1,2번에서 쫓겨나지 않았다면 차단 여부를 검사
		BlockDto blockDto = blockDao.selectLastOne(adminId);
		boolean isBlock = blockDto != null && blockDto.getBlockType().equals("차단");
		if(isBlock) return "redirect:block";
		
		//[4] 1,2,3에서 쫓겨나지 않았다면 성공으로 간주
		session.setAttribute("createdUser", adminId);
		session.setAttribute("createdRank", adminDto.getAdminRank());
		adminDao.updateAdminLogin(adminId);

//		session.setAttribute("이름", "값");
		
		return "redirect:/";
	}
	
	//로그아웃(회원 전용 기능)
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("createdUser");
		session.removeAttribute("createdRank");
		return "redirect:/";
	}
	
	//목록+검색
	@RequestMapping("/list")
	public String list(Model model,
			@RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword) {
				
				boolean isSearch = column !=null && keyword != null;
				model.addAttribute("isSearch",isSearch);
				
				model.addAttribute("column",column);
				model.addAttribute("keyword",keyword);
				
				if(isSearch) {
					model.addAttribute("list",adminDao.selectList(column, keyword));
				}
				else {
					model.addAttribute("list",adminDao.selectList());
				}
				return"/WEB-INF/views/admin/list.jsp"; 
			}
	@GetMapping("/findPw")
	public String findPw() {
		return "/WEB-INF/views/admin/findPw.jsp";
	}
	@PostMapping("/findPw")
	public String findPw(@RequestParam String adminId, @RequestParam String adminEmail) throws IOException, MessagingException {
		//아이디로 회원 정보를 조회
		 AdminDto adminDto = adminDao.selectOne(adminId);
		 if(adminDto == null) {
			 return "redirect:findPw?error";
		 }
		 
		 //이메일 비교
		 if(!adminEmail.equals(adminDto.getAdminEmail())) {//이메일 불일치
			 return "redirefct:findPw?error";
		 }
		 //이메일 발송
		 emailService.sendTempPw(adminId, adminEmail);
		 
		 //완료페이지로 리다이렉트
		 return "redirect:findPwFinish";
	}
	@RequestMapping("/findPwFinish")
	public String findPwFinish() {
		return "/WEB-INF/views/admin/findPwFinish.jsp";
	}
	
	
}