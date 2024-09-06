package com.kh.AttendPro.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//시스템관리자 회원 분류단계.
//configuration을 통해 마지막에 분류 
@Service
public class SysAdminInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//관리자 = 현재 사용자의 세션에 들어있는 createdLevel이 관리자인 경우
		HttpSession session = request.getSession();
		String createdRank = (String)session.getAttribute("createdRank");
		boolean isSysAdmin = "시스템 관리자".equals(createdRank);
		System.out.println("isSysAdmin = " + isSysAdmin);
		
		if(isSysAdmin) {// 시스템관리자라면
			return true;//통과
		}
		else {// 시스템관리자가 아니라면
//			response.sendError(403);//권한없음(부족), Forbidden
			response.sendRedirect("/admin/login");
			return false;
		}
	}
}
