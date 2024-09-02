package com.kh.AttendPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.AttendPro.dao.NoticeDao;
import com.kh.AttendPro.vo.PageVO;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class homeController {

	@Autowired
    private NoticeDao noticeDao;
	
	@RequestMapping("/")//가장 짧은 주소
	public String home(Model model, HttpServletResponse response, PageVO pageVO) {
		if(pageVO.getColumn() != null && pageVO.getColumn().trim().isEmpty()) {
			pageVO.setColumn(null);
		}
		if(pageVO.getKeyword() != null && pageVO.getKeyword().trim().isEmpty()) {
			pageVO.setKeyword(null);
		}
		
	     pageVO.setCount(noticeDao.countByPaging(pageVO));
	     model.addAttribute("pageVO", pageVO);
	     model.addAttribute("noticeList", noticeDao.selectListByPaging(pageVO));		
		return "/WEB-INF/views/home.jsp";
	}
	
	
	
}
