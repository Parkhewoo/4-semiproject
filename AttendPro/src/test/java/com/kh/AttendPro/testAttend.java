package com.kh.AttendPro;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class testAttend {

	@RequestMapping("/")
	public String Test() {
		return "테스트 정리완료";
		
	}
}
