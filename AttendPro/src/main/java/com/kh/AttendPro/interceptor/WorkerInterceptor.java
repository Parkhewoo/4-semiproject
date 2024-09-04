package com.kh.AttendPro.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//시스템관리자 회원 분류단계.
//configuration을 통해 마지막에 분류 
@Service
public class WorkerInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//일반사원 = 현재 사용자의 세션에 들어있는 createdLevel이 일반사원인 경우
		HttpSession session = request.getSession();
		String createdLevel = (String)session.getAttribute("createdLevel");
		boolean isWorker = "일반 사원".equals(createdLevel);
		System.out.println("isWorker = " + isWorker);
		
		if(isWorker) {//일반사원이라면
			return true;//통과
		}
		else {//일반사원이 아니라면
			response.sendError(403);//권한없음(부족), Forbidden
			return false;
		}
	}
}
