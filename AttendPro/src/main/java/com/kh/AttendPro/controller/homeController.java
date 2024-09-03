package com.kh.AttendPro.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.AttendPro.dao.NoticeDao;
import com.kh.AttendPro.dto.NoticeDto;
import com.kh.AttendPro.vo.PageVO;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class homeController {

    @Autowired
    private NoticeDao noticeDao;

    @RequestMapping("/") 
    public String home(Model model, HttpServletResponse response, PageVO pageVO) {
        
        int limit = 6;
        List<NoticeDto> noticeList = noticeDao.selectRecentNotices(limit);

       
        model.addAttribute("noticeList", noticeList);

       

        return "/WEB-INF/views/home.jsp";
    }
}
