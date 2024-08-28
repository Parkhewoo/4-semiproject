package com.kh.AttendPro.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import com.kh.AttendPro.error.TargetNotFoundException;
import com.kh.AttendPro.vo.PageVO;


@Controller
@RequestMapping("/sysadmin")
public class SysAdminController {
	
	@Autowired
	private AdminDao adminDao;
	
	@Autowired BlockDao blockDao;

	
	@RequestMapping("/home")
	public String home() {
		return "/WEB-INF/views/sysadmin/home.jsp";
	}
	
	
	// "/sysadmin/list" 페이지 기능구현 - 08/23 박관일
//	 @RequestMapping("/list")
//	    public String list(Model model,
//	                       @RequestParam(required = false) String column,
//	                       @RequestParam(required = false) String keyword) {
//
//	        boolean isSearch = column != null && keyword != null;
//	        List<AdminDto> list = isSearch ? adminDao.selectList(column, keyword) : adminDao.selectList();
//
//	        model.addAttribute("list", list);
//	        model.addAttribute("keyword", keyword);
//
//	        return "/WEB-INF/views/sysadmin/list.jsp";
//	    }
	
	//관리자 목록
	@RequestMapping("/list")
	   public String list(@ModelAttribute("pageVO") PageVO pageVO, Model model) {
	       // 빈 문자열을 null로 변환
	       if (pageVO.getColumn() != null && pageVO.getColumn().trim().isEmpty()) {
	           pageVO.setColumn(null);
	       }
	       if (pageVO.getKeyword() != null && pageVO.getKeyword().trim().isEmpty()) {
	           pageVO.setKeyword(null);
	       }
	       model.addAttribute("list", adminDao.selectListBypaging(pageVO));
	       pageVO.setCount(adminDao.countByPaging(pageVO));
	       model.addAttribute("pageVO", pageVO);

	       return "/WEB-INF/views/sysadmin/admin/list.jsp";
	   }
	
//	//관리자 상세페이지
//	@RequestMapping("/detail")
//	public String detail(@RequestParam String adminId, Model model) {
//		AdminDto dto = adminDao.selectOne(adminId);
//		model.addAttribute("dto", dto);
//		
//		  // 차단 이력 조회 추가
//	    List<BlockDto> blockList = blockDao.selectList(adminId);
//	    model.addAttribute("blockList", blockList);
//	    
//	      // 현재 차단상태를 조회
//	    BlockDto lastBlock = blockDao.selectLastOne(adminId);
//	    model.addAttribute("lastBlock",lastBlock);
//		
//		return "/WEB-INF/views/sysadmin/admin/detail.jsp";
//	}
//	
	
	
	@RequestMapping("/detail")
	public String detail(@RequestParam String adminId, 
	                     @ModelAttribute("pageVO") PageVO pageVO,
	                     Model model) {
	    AdminDto dto = adminDao.selectOne(adminId);
	    model.addAttribute("dto", dto);
	    
	    // 페이지 크기를 10으로 설정 (이미 설정되어 있지 않다면)
	    if (pageVO.getSize() == 0) {
	        pageVO.setSize(10);
	    }
	    
	    // 관리자의 전체 차단 기록 수 가져오기
	    int totalBlockCount = blockDao.countByAdmin(adminId);
	    pageVO.setCount(totalBlockCount);
	    
	    // 페이지네이션된 차단 기록 가져오기
	    List<BlockDto> blockList = blockDao.selectListByAdmin(adminId, pageVO);
	    model.addAttribute("blockList", blockList);
	    
	    // 현재 차단 상태 가져오기
	    BlockDto lastBlock = blockDao.selectLastOne(adminId);
	    model.addAttribute("lastBlock", lastBlock);
	    
	    return "/WEB-INF/views/sysadmin/admin/detail.jsp";
	}
	
	//관리자 정보수정
	@GetMapping("/edit")
	public String edit(Model model, @RequestParam String adminId) {		
		AdminDto adminDto = adminDao.selectOne(adminId);
		if(adminDto == null)
			throw new TargetNotFoundException("존재하지 않는 아이디입니다");
		model.addAttribute("adminDto", adminDto);
			return "/WEB-INF/views/sysadmin/admin/edit.jsp";
	}
	
	//관리자 정보수정
	@PostMapping("/edit")
	public String edit(@ModelAttribute AdminDto adminDto) {
		boolean result = adminDao.updateAdminBySysadmin(adminDto);
		if(result == false)
			throw new TargetNotFoundException("존재하지 않는 아이디입니다");
		return "redirect:/sysadmin/detail?adminId=" + adminDto.getAdminId();

	}
	
	//관리자 정보삭제
	@RequestMapping("/delete")
	public String delete(@RequestParam String adminId) {
		boolean result = adminDao.delete(adminId);
		if(result == false)
			throw new TargetNotFoundException("존재하지 않는 아이디입니다");
		return "redirect:list";
	}
	
	//관리자 차단
	@GetMapping("/block")
	public String block(@RequestParam String blockTarget) {
		
		
		AdminDto adminDto = adminDao.selectOne(blockTarget);
		if(adminDto == null)
			throw new TargetNotFoundException("존재하지 않는 아이디입니다");
		return "/WEB-INF/views/sysadmin/admin/block.jsp";
	}
//	
//	//관리자 차단
//	@PostMapping("/block")
//	public String block(@ModelAttribute BlockDto blockDto) {
//		//마지막 차단이력조회
//		BlockDto lastDto = blockDao.selectLastOne(blockDto.getBlockTarget());
//		//last는 null이거나(차단) 아니거나(해제)
//		//if(!lastDto.getBlockType().equals("차단")) {//lastDto가 null이면 차단
//		if(lastDto == null || lastDto.getBlockType().equals("해제")) {
//			blockDao.insertBlock(blockDto);//차단등록
//		}
//		return "redirect:list";//상대경로
//		//return "redirect:/sysadmin/admin/list"; <절대경로
//	}
	
	  @PostMapping("/block")
	    public String block(@ModelAttribute BlockDto blockDto, Model model) {
	        try {
	            blockDao.insertBlock(blockDto);
	        } catch (TargetNotFoundException e) {
	            model.addAttribute("error", e.getMessage());
	        }
	        return "redirect:detail?adminId=" + blockDto.getBlockTarget();
	    }
	
	//차단 해제기능
	@GetMapping("/cancle")
	public String cancle(@RequestParam String blockTarget) {
		AdminDto adminDto = adminDao.selectOne(blockTarget);
		if(adminDto == null)
			throw new TargetNotFoundException("존재하지 않는 아이디입니다");
		return "/WEB-INF/views/sysadmin/admin/cancle.jsp";
	}
	
	@PostMapping("/cancle")
	public String cancle(@ModelAttribute BlockDto blockDto) {
		BlockDto lastDto = blockDao.selectLastOne(blockDto.getBlockTarget());
		if(lastDto != null && lastDto.getBlockType().equals("차단")) {
			blockDao.insertCancle(blockDto);
		}
		return "redirect:detail?adminId=" + blockDto.getBlockTarget();
	}
	
	@Autowired
	private WorkerDao workerdao;
	//데이터 현황 페이지
	@RequestMapping("/status")
	public String status(Model model) {
		model.addAttribute("adminStatusList", adminDao.statusByAdminRank());
		model.addAttribute("workerStatusList", workerdao.statusByWorkerRank());
		return "/WEB-INF/views/sysadmin/status.jsp";
	}
	
		
}
 