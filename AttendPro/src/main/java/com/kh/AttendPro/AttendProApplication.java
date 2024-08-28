package com.kh.AttendPro;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

//모든 시스템에 SpringSecurity가 자동 적용되는 것을 방지
@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
public class AttendProApplication {

	public static void main(String[] args) {
		SpringApplication.run(AttendProApplication.class, args);
	}

}
