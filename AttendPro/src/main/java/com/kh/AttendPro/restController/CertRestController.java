package com.kh.AttendPro.restController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.AttendPro.configuration.CustomCertProperties;
import com.kh.AttendPro.dao.CertDao;
import com.kh.AttendPro.dto.CertDto;
import com.kh.AttendPro.service.EmailService;

@RestController
@RequestMapping("/rest/cert")
public class CertRestController {

	@Autowired
	private EmailService emailService;
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private CustomCertProperties customCertProperties;
	
	//사용자가 요구하는 이메일로 인증메일을 발송하는 기능
	@PostMapping("/send")
	public void send(@RequestParam String certEmail) {
	emailService.sendCert(certEmail);
	}
	
	//사용자가 입력한 인증번호가 유효한지를 판정하는 기능
	@PostMapping("/check")
	public boolean check(@ModelAttribute CertDto certDto) {
		boolean result = certDao.check(certDto, customCertProperties.getExpire());
		if(result) {//인증성공시
			certDao.delete(certDto.getCertEmail());//인증번호 삭제
		}
		return result;
	}
}
