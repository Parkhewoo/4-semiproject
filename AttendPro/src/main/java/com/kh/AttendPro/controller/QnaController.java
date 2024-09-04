package com.kh.AttendPro.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
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

import com.kh.AttendPro.dao.QnaDao;
import com.kh.AttendPro.dto.QnaDto;
import com.kh.AttendPro.error.TargetNotFoundException;
import com.kh.AttendPro.service.AttachmentService;
import com.kh.AttendPro.vo.PageVO;

import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/qna")
public class QnaController {
	
	@Autowired
	QnaDao qnaDao;
	
	@Autowired
	private AttachmentService attachmentService;
	
		@RequestMapping("/list")
		public String list(@ModelAttribute("PageVO") PageVO pageVO , Model model) {
				if (pageVO.getColumn() != null && pageVO.getColumn().trim().isEmpty()) {
		           pageVO.setColumn(null);
		       }
		       if (pageVO.getKeyword() != null && pageVO.getKeyword().trim().isEmpty()) {
		           pageVO.setKeyword(null);
		       }
			model.addAttribute("qnaList", qnaDao.selectListByPaging(pageVO));
			pageVO.setCount(qnaDao.countByPaging(pageVO));
		    model.addAttribute("pageVO", pageVO);
			return "/WEB-INF/views/qna/list.jsp";
		}
		
		@RequestMapping("/adminList")
		public String list(@RequestParam(required = false) String column, 
				@RequestParam(required = false) String keyword,
				HttpSession session,
				Model model) {
			String qnaWriter =(String)session.getAttribute("createdUser");
			boolean isSearch = column != null && keyword != null;
			//검색
			if(isSearch) {
			model.addAttribute("list", qnaDao.adminSelectList(column, keyword, qnaWriter));
			}
			//목록
			else {
			model.addAttribute("list", qnaDao.adminSelectList(qnaWriter));
			}
			return "/WEB-INF/views/qna/adminList.jsp";
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
		    String createdUser = (String)session.getAttribute("createdUser");
		    qnaDto.setQnaWriter(createdUser);

		    int seq = qnaDao.sequence();
		    qnaDto.setQnaNo(seq);

		    if(qnaDto.isNew()) {
		        qnaDto.setQnaGroup(seq);
		        qnaDto.setQnaTarget(null);
		        qnaDto.setQnaDepth(0);
		    } else {
		        QnaDto targetDto = qnaDao.selectOne(qnaDto.getQnaTarget());
		        qnaDto.setQnaGroup(targetDto.getQnaGroup());
		        qnaDto.setQnaDepth(targetDto.getQnaDepth() + 1);
		        
		        // 자식 글의 내용을 부모 글의 qna_reply에 업데이트
		        qnaDao.updateReply(qnaDto.getQnaTarget(), qnaDto.getQnaContent());
		    }

		    qnaDao.insert(qnaDto);
		    String rank = "일반 관리자";
		    if(rank.equals(session.getAttribute("createdRank"))) {
		    	return "redirect:adminList";
		    }
		    return "redirect:list";
		}
		
		//삭제 페이지
		// 글 안에 들어가 있는 이미지 파일을 모두 찾아서 삭제한 뒤 글삭제
		@RequestMapping("/delete")
		public String delete(@RequestParam int qnaNo, HttpSession session) {
			QnaDto qnaDto = qnaDao.selectOne(qnaNo);
			if(qnaDto == null)
				throw new TargetNotFoundException("존재하지 않는 글 번호");
			
			String qnaContent = qnaDto.getQnaContent();//글 내용 추출
			
			//qnaContent에 들어있는 내용 중 attach를 찾기
			
			Document document = Jsoup.parse(qnaContent);//HTML로 해석!
			Elements elements = document.select(".qna-attach");//찾기
			for(Element element : elements) {//찾은걸 반복하면서
				String key = element.attr("data-key");//data-key 속성을 읽어서
				int attachmentNo = Integer.parseInt(key);//숫자로 바꿔서
				attachmentService.delete(attachmentNo);//삭제
			}
			
			boolean result = qnaDao.delete(qnaNo);
		
			 String rank = "일반 관리자";
			 if(rank.equals(session.getAttribute("createdRank"))) {
			    	return "redirect:adminList";
			   }
			return "redirect:list";
		}
		
		
		//수정 페이지
		@GetMapping("/edit")
		public String edit(@RequestParam int qnaNo, Model model) {
			QnaDto qnaDto = qnaDao.selectOne(qnaNo);
			if(qnaDto == null)
				throw new TargetNotFoundException("존재하지 않는 글 번호");
			model.addAttribute("qnaDto", qnaDto);
			return "/WEB-INF/views/qna/edit.jsp";
		}
		
		@PostMapping("/edit")
		public String edit(@ModelAttribute QnaDto qnaDto) {
			//(+추가) 수정 전/후의 첨부파일을 비교하여 삭제할 대상을 찾아 삭제처리
			// - 이미지는 class가 board-attach이고 data-key 속성에 번호가 있다
			
			QnaDto originDto = qnaDao.selectOne(qnaDto.getQnaNo());//이전글 조회
			if(originDto == null) 
				throw new TargetNotFoundException("존재하지 않는 글 번호");
			
			//수정 전
			Set<Integer> before = new HashSet<>();
			Document beforeDocument = Jsoup.parse(originDto.getQnaContent());//이전글 내용 해석
			for(Element el : beforeDocument.select(".qna-attach")) {//.qna-attach 찾아 반복
				String keyStr = el.attr("data-key");//data-key 속성 추출
				int key = Integer.parseInt(keyStr);//int로 변환
				before.add(key);//저장소에 추가
			}
			
			//수정 후
			Set<Integer> after = new HashSet<>();
			Document afterDocument = Jsoup.parse(qnaDto.getQnaContent());//수정글 내용 해석
			for(Element el : afterDocument.select(".qna-attach")) {//.board-attach 찾아 반복
				String keyStr = el.attr("data-key");//data-key 속성 추출
				int key = Integer.parseInt(keyStr);//int로 변환
				after.add(key);//저장소에 추가
			}
			
			//수정전 - 수정후 계산
			before.removeAll(after);
			
			//before에 남아있는 번호에 해당하는 파일을 모두 삭제
			for(int attachmentNo : before) {
				attachmentService.delete(attachmentNo);
			}
			
			//수정 처리
			qnaDao.update(qnaDto);
			
			// 자식글이 수정된 경우 부모글의 qna_reply를 업데이트
		    Integer qnaTarget = originDto.getQnaTarget();
		    if (qnaTarget != null) {
		        // 부모글을 조회하여 qna_reply 업데이트
		        String currentReply = qnaDto.getQnaContent(); // 수정된 자식글의 내용
		        qnaDao.updateReply(qnaTarget, currentReply);
		    }

		    return "redirect:detail?qnaNo=" + qnaDto.getQnaNo();
		}
		
		
		
}
