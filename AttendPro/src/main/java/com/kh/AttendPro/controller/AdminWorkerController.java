package com.kh.AttendPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.AttendPro.dao.WorkerDao;
import com.kh.AttendPro.dto.WorkerDto;
import com.kh.AttendPro.error.TargetNotFoundException;
import com.kh.AttendPro.vo.PageVO;



@Controller
@RequestMapping("/admin/worker")
public class AdminWorkerController {
	@Autowired
	private WorkerDao workerDao;
	
	//회원가입
	   @GetMapping("/add")
	   public String add() {
	      return "/WEB-INF/views/worker/add.jsp";
	   }
	   @PostMapping("/add")
	   public String add(@ModelAttribute WorkerDto workerDto) {
	      workerDao.insert(workerDto);
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
	   
	   @RequestMapping("/list")
	   public String list(@ModelAttribute("pageVO") PageVO pageVO,
			   Model model) {
			   model.addAttribute("list",workerDao.selectListBypaging(pageVO));
			   pageVO.setCount(workerDao.countByPaging(pageVO));
			   return "/WEB-INF/views/worker/list2.jsp";
	   }
	   //목록+검색
//		@RequestMapping("/list")
//		public String list(Model model,
//				@RequestParam(required = false) String column,
//				@RequestParam(required = false) String keyword) {
//					
//			boolean isSearch = column !=null && keyword != null;
//			model.addAttribute("isSearch",isSearch);
//				
//			model.addAttribute("column",column);
//			model.addAttribute("keyword",keyword);
//					
//			if(isSearch) {
//				model.addAttribute("list",workerDao.selectList(column, keyword));
//			}
//			else {
//				model.addAttribute("list",workerDao.selectListBypaging(null));
//			}
//			return"/WEB-INF/views/worker/list.jsp"; 
//		}
		
		@GetMapping("/edit")
		public String change(Model model, @RequestParam int workerNo) {
			WorkerDto workerDto = workerDao.selectOne(workerNo);
			if(workerDto == null) throw new TargetNotFoundException();
			model.addAttribute("workerDto", workerDto);
			return "/WEB-INF/views/worker/edit.jsp";
		}
		@PostMapping("/edit")
		public String change(@ModelAttribute WorkerDto workerDto) {
			boolean result = workerDao.update(workerDto);
			if(result == false) throw new TargetNotFoundException();
			return "redirect:detail?workerNo="+workerDto.getWorkerNo();//상대
		}
		
		//삭제
		@RequestMapping("/delete")
		public String delete(@RequestParam int workerNo) {
			boolean result = workerDao.delete(workerNo);
			if(result == false) throw new TargetNotFoundException();
			return "redirect:list";//상대
		}
	
}
