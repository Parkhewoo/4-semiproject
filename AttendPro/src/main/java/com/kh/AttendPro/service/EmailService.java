package com.kh.AttendPro.service;

import java.io.File;
import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.kh.AttendPro.dao.AdminDao;
import com.kh.AttendPro.dao.CertDao;
import com.kh.AttendPro.dto.CertDto;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {

	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private RandomService randomService;
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private AdminDao adminDao;
	
	//인증번호 발송 서비스
	public void sendCert(String certEmail) {
		//인증번호 생성
		String value = randomService.generateNumber(6);
		
		//메세지 생성
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(certEmail);
		message.setSubject("비밀번호 찾기 인증번호");
		message.setTo("인증번호는 [" + value + "]입니다");
		
		//메세지 전송
		sender.send(message);
		
		//DB기록 남기기
		certDao.delete(certEmail);
		CertDto certDto = new CertDto();
		certDto.setCertEmail(certEmail);
		certDto.setCertNumber(value);
		certDao.insert(certDto);
	}
	
	//임시 비밀번호 발급 및 메일 전송
	public void sendTempPw(String adminId, String adminEmail) throws IOException, MessagingException {
		//임시 비밀번호 발급
		String tempPassword = randomService.generateString(12);
		adminDao.updateAdminPw(adminId, tempPassword);
		
		//이메일 템플릿 불러와 정보 설정 후 발송
		ClassPathResource resource = new ClassPathResource("templates/temp-pw.html");
		File target = resource.getFile();
		Document document = Jsoup.parse(target);
		Element element = document.getElementById("temp-password");
		element.text(tempPassword);
		
		//메세지 생성
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
		helper.setTo(adminEmail);
		helper.setSubject("임시 비밀번호 안내");
		helper.setText(document.toString(), true);
		
		//메세지 발송
		sender.send(message);
	}
}
