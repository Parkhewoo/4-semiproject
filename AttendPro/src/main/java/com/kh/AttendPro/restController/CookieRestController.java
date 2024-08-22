package com.kh.AttendPro.restController;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/rest/cookie")
public class CookieRestController {
	
	@PostMapping("/today")
	public void today(HttpServletResponse response, 
						@RequestParam String cookieName, 
						@RequestParam(required = false) String cookieValue) {
		LocalDateTime current = LocalDateTime.now();
		LocalDateTime midnight = current.plusDays(1).withHour(0).withMinute(0).withSecond(0)
				.truncatedTo(ChronoUnit.SECONDS);
		Duration duration = Duration.between(current, midnight);
		
		//값을 전달하지 않았다면 현재시각으로 설정
		if(cookieValue == null) {
			cookieValue = current.toString();
		}
		
		Cookie cookie = new Cookie(cookieName, cookieValue);
		cookie.setMaxAge((int)duration.getSeconds());
		cookie.setPath("/");//사용할 위치를 만든 곳이 아니라 홈페이지 전체로 지정
		response.addCookie(cookie);
	}
	
}