package com.kh.AttendPro.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class MemberInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        // 로그인된 사용자 정보를 세션에서 가져오기
        HttpSession session = request.getSession();
        String createdUser = (String) session.getAttribute("createdUser");

        // 로그인 여부 확인
        boolean isLogin = createdUser != null;

        // 요청 URI 가져오기
        String requestURI = request.getRequestURI();

        // 로그인 없이 접근이 허용된 경로
        boolean isExcludedPath = requestURI.startsWith("/admin/login")
                || requestURI.startsWith("/worker/login")
                || requestURI.equals("/"); // 홈 페이지 예외 추가
        
        // 로그인이 되어 있거나 예외 경로에 접근하는 경우
        if (isLogin || isExcludedPath) {
            return true; // 요청 계속 진행
        } else {
            // 로그인이 되어 있지 않고 예외 경로가 아닌 경우
            response.sendRedirect("/"); // 로그인 페이지로 리다이렉트
            return false; // 요청 차단
        }
    }
}
