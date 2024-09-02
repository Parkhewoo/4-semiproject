package com.kh.AttendPro.controller;

import java.util.HashSet;
import java.util.Set;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.AttendPro.dao.NoticeDao;
import com.kh.AttendPro.dto.NoticeDto;
import com.kh.AttendPro.error.TargetNotFoundException;
import com.kh.AttendPro.service.AttachmentService;
import com.kh.AttendPro.vo.PageVO;

import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	NoticeDao noticeDao;
	
	@Autowired
	private AttachmentService attachmentService;
	
		@RequestMapping("/")
		public String list(@ModelAttribute("PageVO") PageVO pageVO, Model model) {
			if(pageVO.getColumn() != null && pageVO.getColumn().trim().isEmpty()) {
				pageVO.setColumn(null);
			}
			if(pageVO.getKeyword() != null && pageVO.getKeyword().trim().isEmpty()) {
				pageVO.setKeyword(null);
			}
			pageVO.setCount(noticeDao.countByPaging(pageVO));
			model.addAttribute("noticeList", noticeDao.selectListByPaging(pageVO));
			model.addAttribute("pageVO", pageVO);
			return "/WEB-INF/views/notice/list.jsp";
		}
		@RequestMapping("/detail")
		public String detail(@RequestParam int noticeNo, Model model) {
			NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
			if(noticeDto == null)
				throw new TargetNotFoundException("존재하지 않는 게시물 번호입니다.");
			model.addAttribute("noticeDto" ,noticeDto);
			return "/WEB-INF/views/notice/detail.jsp";
		}
		
		@GetMapping("/write")
		public String write() {
			return"/WEB-INF/views/notice/write.jsp";
		}
		@PostMapping("/write")
		public String write(@ModelAttribute NoticeDto noticeDto, HttpSession session) {
			String createdUser = (String)session.getAttribute("createdUser");
			noticeDto.setNoticeWriter(createdUser);
			
			int seq = noticeDao.sequence();
			noticeDto.setNoticeNo(seq);
			
			noticeDao.insert(noticeDto);
			
			return "redirect:/";
		}
		
		@RequestMapping("/delete")
		public String delete(@RequestParam int noticeNo) {
			NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
			if(noticeDto == null)
				throw new TargetNotFoundException("존재하지 않는 글 번호");
			
			String noticeContent = noticeDto.getNoticeContent();
			
			Document document = Jsoup.parse(noticeContent);
			Elements elements = document.select(".notice-attach");
			for(Element element : elements) {
				String key = element.attr("data-key");
				int attachmentNo = Integer.parseInt(key);
				attachmentService.delete(attachmentNo);
			}
			boolean result = noticeDao.delete(noticeNo);
			return "redirect:/";
		}
		@GetMapping("/edit")
		public String edit(@RequestParam int noticeNo, Model model) {
			NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
			if(noticeDto == null)
				throw new TargetNotFoundException("존재하지 않는 글 번호");
			model.addAttribute("noticeDto",noticeDto);
			return "/WEB-INF/views/notice/edit.jsp";
		}
		@PostMapping("/edit")
		public String edit(@ModelAttribute NoticeDto noticeDto) {
			NoticeDto originDto = noticeDao.selectOne(noticeDto.getNoticeNo());
			if(originDto == null)
				throw new TargetNotFoundException("존재하지 않는 글 번호");
			Set<Integer> before = new HashSet<>();
			Document beforeDocument = Jsoup.parse(originDto.getNoticeContent());
			for(Element el : beforeDocument.select(".notice-attach")) {
				String keyStr = el.attr("data-key");
				int key = Integer.parseInt(keyStr);
				before.add(key);
			}
			
			Set<Integer> after = new HashSet<>();
			Document afterDocument = Jsoup.parse(noticeDto.getNoticeContent());
			for(Element el : afterDocument.select(".notice-attach")) {
				String keyStr = el.attr("data-key");
				int key = Integer.parseInt(keyStr);
				after.add(key);
			}
			before.removeAll(after);
			
			for(int attachmentNo : before) {
				attachmentService.delete(attachmentNo);
			}
			
			noticeDao.update(noticeDto);
			
			return "redirect:detail?noticeNo=" + noticeDto.getNoticeNo();
		}
}
