package com.kh.AttendPro.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.AttendPro.configuration.CustomCertProperties;
import com.kh.AttendPro.dao.CertDao;
import com.kh.AttendPro.dao.RecordDao;
import com.kh.AttendPro.dao.WorkerDao;
import com.kh.AttendPro.dto.CertDto;
import com.kh.AttendPro.dto.WorkerDto;
import com.kh.AttendPro.error.TargetNotFoundException;
import com.kh.AttendPro.service.AttachmentService;
import com.kh.AttendPro.service.EmailService2;
import com.kh.AttendPro.vo.AttendanceVO;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/worker")
public class WorkerController {

	@Autowired
	private WorkerDao workerDao;

	@Autowired
	private EmailService2 emailService;

	@Autowired
	private PasswordEncoder encoder;

	@Autowired
	private RecordDao recordDao;
	
	@Autowired
	private AttachmentService attachmentService;

	// Worker 로그인
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/worker/login.jsp";
	}

	@PostMapping("/login")
	public String login(@RequestParam(required = false) String workerNoStr, @RequestParam String workerPw,
			HttpSession session) {

		int workerNo = 0;
		if (workerNoStr != null && !workerNoStr.isEmpty()) {
			try {
				workerNo = Integer.parseInt(workerNoStr);
			} catch (NumberFormatException e) {
				return "redirect:login?error";
			}
		} else {
			return "redirect:login?error";
		}

		WorkerDto workerDto = workerDao.selectOne(workerNo);
		if (workerDto == null) {
			return "redirect:login?error";
		}

		boolean isValid = encoder.matches(workerPw, workerDto.getWorkerPw());
		if (!isValid) {
			return "redirect:login?error";
		}

		session.setAttribute("createdUser", workerNo);
		session.setAttribute("createdRank", workerDto.getWorkerRank());

		return "redirect:/";
	}

	// 로그아웃(회원 전용 기능)
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("createdUser");
		session.removeAttribute("createdRank");
		return "redirect:/";
	}
	
	// 비밀번호 재설정 페이지
	@GetMapping("/findPw")
	public String findPw() {
		return "/WEB-INF/views/worker/findPw.jsp";
	}

	@PostMapping("/findPw")
	public String findPw(@RequestParam int workerNo, @RequestParam String workerEmail)
			throws IOException, MessagingException {

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

	// 비밀번호 재설정 페이지
	@GetMapping("/resetPw")
	public String resetPw(@ModelAttribute CertDto certDto, @RequestParam String workerNo, Model model) {
		boolean isValid = certDao.check(certDto, customCertProperties.getExpire());

		if (isValid) {
			model.addAttribute("certDto", certDto);
			model.addAttribute("workerNo", workerNo);
			return "/WEB-INF/views/worker/resetPw.jsp";
		} else {
			throw new TargetNotFoundException("올바르지 않은 접근");
		}
	}

	@PostMapping("/resetPw")
	public String resetPw(@ModelAttribute CertDto certDto, @ModelAttribute WorkerDto workerDto) {
		// 인증번호 확인
		boolean isValid = certDao.check(certDto, customCertProperties.getExpire());
		if (!isValid) {
			throw new TargetNotFoundException("올바르지 않은 접근");
		}

		// 비밀번호 변경처리
		workerDao.updateWorkerPw(workerDto.getWorkerNo(), workerDto.getWorkerPw());
		return "redirect:resetPwComplete";
	}

	@RequestMapping("/resetPwComplete")
	public String resetPwFinish() {
		return "/WEB-INF/views/worker/resetPwComplete.jsp";
	}

	// 사원 마이페이지
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		int workerNo = (int) session.getAttribute("createdUser");
		WorkerDto workerDto = workerDao.selectOne(workerNo);

		model.addAttribute("workerDto", workerDto);

		return "/WEB-INF/views/worker/mypage.jsp";
	}

	@RequestMapping("/image")
	public String image(@RequestParam int workerNo) {
	    try {
	        int attachmentNo = workerDao.findImage(workerNo);
	        //system.out.println("WorkerController - attachmentNo = " + attachmentNo);
	        if (attachmentNo > 0) {
	            return "redirect:/attach/download?attachmentNo=" + attachmentNo;
	        } else {
	            return "redirect:/images/user.jpg";
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "redirect:/images/user.jpg";
	    }
	}

	// 사원 비밀번호 변경
	@GetMapping("/password")
	public String password() {
		return "/WEB-INF/views/worker/password.jsp";
	}
	
	@PostMapping("/checkCurrentPassword")
	@ResponseBody
	public String checkCurrentPassword(@RequestParam String currentPw, HttpSession session) {
	    int workerNo = (int) session.getAttribute("createdUser");
	    WorkerDto workerDto = workerDao.selectOne(workerNo);
	    
	    // 현재 비밀번호 확인
	    boolean isValid = encoder.matches(currentPw, workerDto.getWorkerPw());
	    return isValid ? "valid" : "invalid";
	}

	@PostMapping("/password")
	public String password(@RequestParam String currentPw,
						   @RequestParam String changePw, 
						   @RequestParam(value="changePwCheck", required = false) String changePwCheck,
						   HttpSession session) {
		// 사원 번호 추출
		int workerNo = (int) session.getAttribute("createdUser");
		// 현재 사용자의 정보를 추출
		WorkerDto workerDto = workerDao.selectOne(workerNo);
		//현재비밀번호확인
		boolean isCurrentPwValid = encoder.matches(currentPw, workerDto.getWorkerPw());
		if(!isCurrentPwValid) {
	        return "redirect:password?error"; // 현재 비밀번호 불일치
	    }
		
		//새 비밀번호와 비밀번호확인의 일치여부 확인
		if(!changePw.equals(changePwCheck)) {
			return "redirect:password?error";//비밀번호 확인 불일치
		}

		// 새 비밀번호 형식검증
		String regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$";
	    boolean isChangePwValid = changePw.matches(regex);
		if (!isChangePwValid) {
			return "redirect:password?error";//새 비밀번호 형식 불일치
		}

		// 비밀번호 업데이트
		boolean success = workerDao.updateWorkerPw(workerNo, changePw);
		if(!success) {
			return "redirect:password?error";// 비밀번호 업데이트 실패
		}
		//세션 무효화 (비밀번호 변경 후 세션을 무효화하여 새로운 비밀번호로 재로그인 요구)
		session.invalidate();
		
		return "redirect:passwordFinish";
	}

	@RequestMapping("/passwordFinish")
	public String passwordFinish() {
		return "/WEB-INF/views/worker/passwordFinish.jsp";
	}

	@RequestMapping("/check")
    public String check(HttpSession session,
            Model model) {
		if(session.getAttribute("createdUser") == null) {
			return "redirect:login";
		}
            Integer createdUser = (Integer) session.getAttribute("createdUser");
            int workerNo = createdUser; 
            boolean isCome = recordDao.getIsCome(workerNo); // 당일 출근 기록 검사
            model.addAttribute("isCome", isCome); // 출근 여부를 모델에 추가
        return "/WEB-INF/views/worker/check.jsp";
    }

    @RequestMapping("/attendance")
    public String attendance(HttpSession session,
            Model model) {
        Integer createdUser = (Integer) session.getAttribute("createdUser");
        int workerNo = createdUser;
        LocalDate today= LocalDate.now();
     // today로부터 연도와 월 추출
        int year = today.getYear();
     // today로부터 YearMonth 생성
        YearMonth yearMonth = YearMonth.from(today);
        YearMonth lastMonth = yearMonth.minusMonths(1);
        YearMonth lastMonth2 = yearMonth.minusMonths(2);
        		
        //누적
        AttendanceVO attendanceVO = recordDao.selectAttendance(workerNo);
        //올해
        AttendanceVO attendanceYearly = recordDao.selectAttendanceYearly(workerNo, year);
        //작년
        AttendanceVO attendanceYearly2 = recordDao.selectAttendanceYearly(workerNo, year-1);
        //이번달
        AttendanceVO attendanceMonthly = recordDao.selectAttendanceMonthly(workerNo, yearMonth);
        //저번달
        AttendanceVO attendanceMonthly2 = recordDao.selectAttendanceMonthly(workerNo, lastMonth);
        //저저번달
        AttendanceVO attendanceMonthly3 = recordDao.selectAttendanceMonthly(workerNo, lastMonth2);
        //올해 결근일
        int absent = recordDao.getAbsent(workerNo, year);
        //작년 결근일
        int absent2 = recordDao.getAbsent(workerNo, year-1);
        
        model.addAttribute("attendance", attendanceVO);
        
        model.addAttribute("attendanceYearly", attendanceYearly);
        model.addAttribute("attendanceYearly2", attendanceYearly2);
        
        model.addAttribute("attendanceMonthly", attendanceMonthly);
        model.addAttribute("attendanceMonthly2", attendanceMonthly2);
        model.addAttribute("attendanceMonthly3", attendanceMonthly3);
        
        String workerName = workerDao.selectOne(workerNo).getWorkerName();
        model.addAttribute("workerName", workerName);
        
        return "/WEB-INF/views/worker/attendance.jsp";
    }
    @GetMapping("/edit")
	public String change(Model model, @RequestParam int workerNo) {
		WorkerDto workerDto = workerDao.selectOne(workerNo);
		if(workerDto == null) throw new TargetNotFoundException();
		model.addAttribute("workerDto", workerDto);
		return "/WEB-INF/views/worker/edit.jsp";
	}
	@PostMapping("/edit")
	public String change(@ModelAttribute WorkerDto workerDto,
								@RequestParam("attach") MultipartFile attach) throws IllegalStateException, IOException {
	    boolean result = workerDao.update(workerDto);
	    if (!result) {
	        throw new TargetNotFoundException();
	    }
	    
	    // 기존 이미지 삭제
	    workerDao.deleteImage(workerDto.getWorkerNo());

	    // 새로운 이미지가 있는 경우
	    if (attach != null && !attach.isEmpty()) {
	        // 새로운 첨부파일 등록 및 저장
	        int attachmentNo = attachmentService.save(attach);
	        
	        // 새로운 이미지와 회원 정보 연결
	        workerDao.connect(workerDto.getWorkerNo(), attachmentNo);
	    }
	    
	    return "redirect:mypage?workerNo=" + workerDto.getWorkerNo();
	}
    
}
