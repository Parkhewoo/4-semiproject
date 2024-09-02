package com.kh.AttendPro.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.AttendPro.dao.RecordDao;
import com.kh.AttendPro.dao.WorkerDao;
import com.kh.AttendPro.dto.WorkerDto;
import com.kh.AttendPro.error.TargetNotFoundException;
import com.kh.AttendPro.service.AttachmentService;
import com.kh.AttendPro.vo.AttendanceVO;
import com.kh.AttendPro.vo.PageVO;

import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/admin/worker")
public class AdminWorkerController {
	@Autowired
	private WorkerDao workerDao;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private AttachmentService attachmentService;
	@Autowired
	private RecordDao recordDao;
	
	//회원가입
	   @GetMapping("/add")
	   public String add() {
	      return "/WEB-INF/views/worker/add.jsp";
	   }
	//(+추가) 이미지 파일 첨부 기능
	   @Transactional
	   @PostMapping("/add")
	   public String add(@ModelAttribute WorkerDto workerDto,
			   					 MultipartFile attach) throws IllegalStateException, IOException {		   	   
		 //[1] 회원가입
	      workerDao.insert(workerDto);
	      System.out.println("workerDto"+workerDto);
	      System.out.println(attach);
	      
	      if(attach.isEmpty() == false) {
	    	  //[2] 첨부파일이 있다면 등록 및 저장
	    	  int attachmentNo = attachmentService.save(attach);
	    	  //[3] 회원 이미지에 연결정보 저장
	    	  workerDao.connect(workerDto.getWorkerNo(), attachmentNo);
	    	  
	      }
	      return "redirect:addFinish";
	   }
	   
	   @RequestMapping("/addFinish")
	   public String addFinish() {
	      return "/WEB-INF/views/worker/addFinish.jsp";
	   }
	
	   @RequestMapping("/detail")
	   public String detail(@RequestParam int workerNo, Model model) {
	       WorkerDto workerDto = workerDao.selectOne(workerNo);
	       System.out.println("WorkerDto: " + workerDto); // 디버깅용 로그
	       model.addAttribute("workerDto", workerDto);
	       return "/WEB-INF/views/worker/detail.jsp";
	   }
//	   @RequestMapping("/list")
//		public String list(Model model, 
//				@RequestParam(required = false) String column,
//				@RequestParam(required = false) String keyword) {
//			
//			boolean isSearch = column != null && keyword != null;
//			model.addAttribute("isSearch", isSearch);
//			//System.out.println("isSearch = " + isSearch);
//			
//			model.addAttribute("column", column);
//			model.addAttribute("keyword", keyword);
//			
//			if(isSearch) {
//				model.addAttribute("list", workerDao.selectList(column, keyword));
//			}
//			else {
//				model.addAttribute("list", workerDao.selectList());
//			}
//			return "/WEB-INF/views/worker/list.jsp";
//		}
	   
	   @RequestMapping("/list")
	   public String list(@ModelAttribute("pageVO") PageVO pageVO, Model model) {
	       // 빈 문자열을 null로 변환
	       if (pageVO.getColumn() != null && pageVO.getColumn().trim().isEmpty()) {
	           pageVO.setColumn(null);
	       }
	       if (pageVO.getKeyword() != null && pageVO.getKeyword().trim().isEmpty()) {
	           pageVO.setKeyword(null);
	       }
	       model.addAttribute("list", workerDao.selectListByPaging(pageVO));
	       pageVO.setCount(workerDao.countByPaging(pageVO));
	       model.addAttribute("pageVO", pageVO);

	       return "/WEB-INF/views/worker/list2.jsp";
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

		    return "redirect:detail?workerNo=" + workerDto.getWorkerNo();
		}
		
		//삭제
		@RequestMapping("/delete")
		public String delete(@RequestParam int workerNo) {
			boolean result = workerDao.delete(workerNo);
			if(result == false) throw new TargetNotFoundException();
			return "redirect:list";//상대
		}
		
		//이미지 찾기(회원가입 시 첨부한 이미지를 찾는다)
		@RequestMapping("/myImage")
		public String myImage(HttpSession session) {
			try {
				int workerNo = (int)session.getAttribute("createdUser");
				int attachmentNo = workerDao.findImage(workerNo);
				return "redirect:/attach/download?attachmentNo="+attachmentNo;
			}
			catch(Exception e) {
				return "redirect:/images/user.jpg";
			}			
		}
		
		@RequestMapping("/attendance")
	    public String attendance(@RequestParam int workerNo,
	            Model model) {
	        
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
	        
	        return "/WEB-INF/views/worker/attendance.jsp";
	    }


		
}
