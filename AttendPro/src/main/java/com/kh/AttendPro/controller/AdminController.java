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
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.AttendPro.configuration.CustomCertProperties;
import com.kh.AttendPro.dao.AdminDao;
import com.kh.AttendPro.dao.BlockDao;
import com.kh.AttendPro.dao.CertDao;
import com.kh.AttendPro.dao.CompanyDao;
import com.kh.AttendPro.dao.QnaDao;
import com.kh.AttendPro.dao.WorkerDao;
import com.kh.AttendPro.dto.AdminDto;
import com.kh.AttendPro.dto.BlockDto;
import com.kh.AttendPro.dto.CertDto;
import com.kh.AttendPro.dto.CompanyDto;
import com.kh.AttendPro.error.TargetNotFoundException;
import com.kh.AttendPro.service.EmailService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
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
	
	@Autowired
	private QnaDao qnaDao;
	
	@Autowired
	private CompanyDao companyDao;
	
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/admin/join.jsp";
	}
	
	@Transactional
	@PostMapping("/join")
	public String join(@RequestParam String adminId,
            @RequestParam String adminPw,
            @RequestParam String adminNo,
            @RequestParam String adminEmail,
            Model model){
		
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
        	model.addAttribute("adminDto",adminDto);
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
						@RequestParam(required = false) String remember,// 쿠키 아이디 저장하기
						HttpSession session, HttpServletResponse response) {
		
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

		//[5] (쿠키적용) 로그인 성공 시 remeber 의 유무에 따라 쿠키 생성 or 제거
		if(remember != null) {//아이디 저장하기 체크
			Cookie ck = new Cookie("saveId", adminId);//쿠키 생성
			ck.setMaxAge(4 * 7 * 60 * 60);//4주 동안 유효
			response.addCookie(ck);//사용자에게 발행 
		}
		else {//아이디 저장하기 체크x
			Cookie ck = new Cookie("saveId", adminId);//쿠키 생성
			ck.setMaxAge(0);//0초 지속(= 삭제)
			response.addCookie(ck);//사용자에게 발행
		}

		return "redirect:/";
	}
	
	//로그아웃(회원 전용 기능)
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("createdUser");
		session.removeAttribute("createdRank");
		return "redirect:/";
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
	
	//관리자 마이페이지
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		String adminId = (String) session.getAttribute("createdUser");
		AdminDto adminDto = adminDao.selectOne(adminId);
		CompanyDto companyDto = companyDao.selectOne(adminId);
		
		model.addAttribute("adminDto", adminDto);
	    model.addAttribute("companyDto", companyDto);
		//해당 admin이 작성한 글 조회하여 첨부
		model.addAttribute("qnaWriteList", qnaDao.selectListByQnaWriter(adminId));
		
		return "/WEB-INF/views/admin/mypage.jsp";
	}
	
	//관리자 회원탈퇴
	@GetMapping("/exit")
	public String exit() {
		return "/WEB-INF/views/admin/exit.jsp";
	}
	@PostMapping("/exit")
	public String exit(HttpSession session, @RequestParam String adminPw) {
		//아이디 및 정보추출
		String adminId = (String)session.getAttribute("createdUser");
		AdminDto adminDto = adminDao.selectOne(adminId);
		
		//비밀번호 비교
//		boolean isValid = adminPw.equals(adminDto.getAdminPw());
		boolean isValid = encoder.matches(adminPw, adminDto.getAdminPw());
		if(isValid == false) return "redirect:exit?error";
		
		// DB에서 회원 삭제
	    adminDao.delete(adminId);
		
		session.removeAttribute("createdUser");
//		session.removeAttribute("createdRank");
		
		return "redirect:goodbye";
	}
	
	@RequestMapping("/goodbye")
	public String goodbye() {
		return "/WEB-INF/views/admin/goodbye.jsp";
	}
	
	//차단 알림 페이지
	@RequestMapping("/block")
	public String block() {
		return "/WEB-INF/views/admin/block.jsp";
	}
	
	//관리자 개인정보 변경
	@GetMapping("/change")
	public String change(HttpSession session, Model model) {
		
		//아이디 추출
		String adminId = (String)session.getAttribute("createdUser");
		
		//회원정보 조회
		AdminDto adminDto = adminDao.selectOne(adminId);
		
		//화면에 전달
		model.addAttribute("adminDto", adminDto);
		
		return "/WEB-INF/views/admin/change.jsp";
	}
	
	@PostMapping("/change")
	public String change(HttpSession session,
									@ModelAttribute AdminDto adminDto) {
		//기본 정보 조회
		String adminId = (String)session.getAttribute("createdUser");
		AdminDto findDto = adminDao.selectOne(adminId);
		
		//비밀번호 검사
		boolean isValid = adminDto.getAdminPw().equals(findDto.getAdminPw());
		if(isValid == false) return "redirect:change?error";
		
		//변경처리
		adminDto.setAdminId(adminId);//아이디 추가
		adminDao.updateAdmin(adminDto);
		return "redirect:mypage";
	}
	
	// 관리자 비밀번호 변경
	@GetMapping("/password")
	public String password() {
	    return "/WEB-INF/views/admin/password.jsp";
	}

	@PostMapping("/checkCurrentPassword")
	@ResponseBody
	public String checkCurrentPassword(@RequestParam String currentPw, HttpSession session) {
	    String adminId = (String) session.getAttribute("createdUser");
	    AdminDto adminDto = adminDao.selectOne(adminId);

	    // 현재 비밀번호 확인
	    boolean isValid = encoder.matches(currentPw, adminDto.getAdminPw());
	    return isValid ? "valid" : "invalid";
	}

	@PostMapping("/password")
	public String password(
	        @RequestParam String currentPw,
	        @RequestParam String changePw,
	        @RequestParam(value = "changePwCheck", required = false) String changePwCheck,
	        HttpSession session) {

	    // 관리자 ID 가져오기
	    String adminId = (String) session.getAttribute("createdUser");

	    // 현재 비밀번호 확인
	    AdminDto adminDto = adminDao.selectOne(adminId);
	    boolean isCurrentPwValid = encoder.matches(currentPw, adminDto.getAdminPw());
	    if (!isCurrentPwValid) {
	        return "redirect:password?error"; // 현재 비밀번호 불일치
	    }

	    // 새 비밀번호와 확인 비밀번호 일치 여부 확인
	    if (!changePw.equals(changePwCheck)) {
	        return "redirect:password?error"; // 비밀번호 확인 불일치
	    }

	    // 새 비밀번호 형식 검증
	    String regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$";
	    boolean isChangePwValid = changePw.matches(regex);
	    if (!isChangePwValid) {
	        return "redirect:password?error"; // 새 비밀번호 형식 불일치
	    }

	    // 비밀번호 업데이트
	    boolean success = adminDao.updateAdminPw(adminId, changePw);
	    if (!success) {
	        return "redirect:password?error"; // 비밀번호 업데이트 실패
	    }

	    // 세션 무효화 (비밀번호 변경 후 세션을 무효화하여 새로운 비밀번호로 재로그인 요구)
	    session.invalidate();

	    return "redirect:passwordFinish";
	}


	@RequestMapping("/passwordFinish")
	public String passwordFinish() {
	    return "/WEB-INF/views/admin/passwordFinish.jsp";
	}

	
}