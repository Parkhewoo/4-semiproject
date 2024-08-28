package com.kh.AttendPro.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.AttendPro.configuration.CustomCertProperties;
import com.kh.AttendPro.dao.AdminDao;
import com.kh.AttendPro.dao.BlockDao;
import com.kh.AttendPro.dao.CertDao;
import com.kh.AttendPro.dao.WorkerDao;
import com.kh.AttendPro.dto.AdminDto;
import com.kh.AttendPro.dto.BlockDto;
import com.kh.AttendPro.dto.CertDto;
import com.kh.AttendPro.error.TargetNotFoundException;
import com.kh.AttendPro.service.EmailService;

import com.kh.AttendPro.vo.PageVO;




import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private WorkerDao workerDao;
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private BlockDao blockDao;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/admin/join.jsp";
	}
	
	@Transactional
	@PostMapping("/join")
	public String join(@RequestParam String adminId,
            @RequestParam String adminPw,
            @RequestParam String adminNo,
            @RequestParam String adminEmail){
		
		   // AdminDto 객체 생성
        AdminDto adminDto = new AdminDto();
        adminDto.setAdminId(adminId);
        adminDto.setAdminPw(adminPw);
        adminDto.setAdminNo(adminNo);
        adminDto.setAdminEmail(adminEmail);
		
        // 회원가입 처리
        boolean success = adminDao.join(adminDto);

        // 성공 여부에 따라 리다이렉트 또는 오류 페이지 표시
        if (success) {
            return "redirect:/admin/joinFinish"; // 가입 성공 페이지로 리다이렉트
        } else {
            return "redirect:/join"; // 실패 시 회원가입 페이지로 리다이렉트
        }
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

//		//[2] 1에서 불러온 정보(AdminDto)와 비밀번호를 비교
		boolean isValid = encoder.matches(adminPw, adminDto.getAdminPw());
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
		// 아이디로 회원 정보를 조회
		AdminDto adminDto = adminDao.selectOne(adminId);
		if (adminDto == null) {
			return "redirect:findPw?error";
		}

		// 이메일 비교
		if (!adminEmail.equals(adminDto.getAdminEmail())) {// 이메일 불일치
			return "redirect:findPw?error";
		}

		// 템플릿을 불러와서 재설정 메일 발송
		emailService.sendResetPw(adminId, adminEmail);

		return "redirect:findPwFinish";
	}

	@RequestMapping("/findPwFinish")
	public String findPwFinish() {
		return "/WEB-INF/views/admin/findPwFinish.jsp";
	}
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private CustomCertProperties customCertProperties;
	
	//비밀번호 재설정 페이지
	@GetMapping("/resetPw")
	public String resetPw(@ModelAttribute CertDto certDto,
							@RequestParam String adminId,
							Model model) {
		boolean isValid = certDao.check(certDto, customCertProperties.getExpire());

		if(isValid) {
			model.addAttribute("certDto", certDto);
			model.addAttribute("adminId",adminId);
		return "/WEB-INF/views/admin/resetPw.jsp";
		}
		else {
			throw new TargetNotFoundException("올바르지 않은 접근");
		}
	}
	@PostMapping("/resetPw")
	public String resetPw(@ModelAttribute CertDto certDto,
							@ModelAttribute AdminDto adminDto) {
		//인증번호 확인
		boolean isValid = certDao.check(certDto, customCertProperties.getExpire());
		if(!isValid) {
			throw new TargetNotFoundException("올바르지 않은 접근");
		}
		
		//비밀번호 변경처리
		adminDao.updateAdminPw(
				adminDto.getAdminId(), adminDto.getAdminPw());
		return "redirect:resetPwComplete";
	}
	@RequestMapping("/resetPwComplete")
	public String resetPwFinish() {
		return "/WEB-INF/views/admin/resetPwComplete.jsp";
	}
	
}