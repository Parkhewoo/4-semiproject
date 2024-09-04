package com.kh.AttendPro.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.AttendPro.dao.QnaDao;
import com.kh.AttendPro.dto.QnaDto;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class QnaOwnerInterceptor implements HandlerInterceptor {
	
	//(주의) 인터셉터에서 DB를 가게 만들면 성능저하가 심하다 (반드시 필요한 경우만)
	@Autowired
	private QnaDao qnaDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
											HttpServletResponse response, Object handler)
			throws Exception {
		//검사 시나리오
		//사전검사. 관리자이면서 삭제페이지로 가는 경우는 무조건 통과
		//1. 현재 로그인한 회원의 아이디를 조회한다 (HttpSession)
		//1-F. 차단 (401 미인증)
		//2. 수정 혹은 삭제 하려는 게시글 번호를 추출한다 (Parameter)
		//3. 게시글 정보를 조회하여 작성자와 회원의 아이디가 같은지 비교한다
		//4-T. 통과
		//4-F. 차단 (403 권한 없음)
		
		//사전검사
		HttpSession session = request.getSession();
		String createdLevel = (String) session.getAttribute("createdLevel");
		boolean isAdmin = createdLevel != null && createdLevel.equals("일반 관리자");
		boolean isDelete = request.getRequestURI().equals("/board/delete");
		if(isAdmin && isDelete) {
			return true;
		}
		
		//1
		String createdUser = (String) session.getAttribute("createdUser");
		//1-F
		if(createdUser == null) {
			response.sendError(401);
			//response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
			return false;
		}
		//2
		int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
		//3
		QnaDto qnaDto =qnaDao.selectOne(qnaNo);
		boolean isOwner = createdUser.equals(qnaDto.getQnaWriter());
		
		if(isOwner) {//4-T
			return true;
		}
		else {//4-F
			response.sendError(403);
			return false;
		}
	}
}




