package com.kh.AttendPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.AttendPro.dao.QnaDao;
import com.kh.AttendPro.dto.QnaDto;
import com.kh.AttendPro.error.TargetNotFoundException;
import com.kh.AttendPro.vo.PageVO;

import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/qna")
public class QnaController {
	
	@Autowired
	QnaDao qnaDao;
	
		@RequestMapping("/list")
		public String list(@ModelAttribute("PageVO") PageVO pageVO , Model model) {
			model.addAttribute("qnaList", qnaDao.selectListByPaging(pageVO));
			int count = qnaDao.countByPaging(pageVO);
			pageVO.setCount(count);
			return "/WEB-INF/views/qna/list.jsp";
		}
		
		@RequestMapping("/detail")
		public String detail(@RequestParam int qnaNo, Model model) {
			QnaDto qnaDto = qnaDao.selectOne(qnaNo);
			if (qnaDto == null)
				throw new TargetNotFoundException("존재하지 않는 게시물 번호입니다.");
			model.addAttribute("qnaDto", qnaDto);
			return "/WEB-INF/views/qna/detail.jsp";
		}
	
		//등록 페이지
		@GetMapping("/write")
		public String write() {
			return "/WEB-INF/views/qna/write.jsp";
		}
		
		@PostMapping("/write")
		public String write(@ModelAttribute QnaDto qnaDto, HttpSession session) {
			//세션에서 아이디 추출 후 qnaDto에 첨부
			String createdUser = (String)session.getAttribute("createdUser");
			qnaDto.setQnaWriter(createdUser);

			//시퀀스 번호를 먼저 생성하도록 지시한다
			int seq = qnaDao.sequence();
			
			//등록할 정보에 번호를 첨부한다
			qnaDto.setQnaNo(seq);
			
			//새글+답글 여부에 따라 그룹 상위글 차수를 설정해야한다
			if(qnaDto.isNew()) {
				qnaDto.setQnaGroup(seq);//그룹 번호는 글 번호와 동
				qnaDto.setQnaTarget(null);//상위글 번호는 null로 설정
				qnaDto.setQnaDepth(0);//차수는 0으로 설정
			}
			else {
				//타겟글의 정보 조회
				QnaDto targetDto = qnaDao.selectOne(qnaDto.getQnaTarget());
				qnaDto.setQnaGroup(targetDto.getQnaGroup());
				qnaDto.setQnaDepth(targetDto.getQnaDepth()+1);
			}
			
			
			//등록을 지시한다
			qnaDao.insert(qnaDto);
			
			//생성한 번호에 맞는 상세페이지로 리다이렉트(추방)
			return "redirect:detail?qnaNo="+seq;
		}
}
