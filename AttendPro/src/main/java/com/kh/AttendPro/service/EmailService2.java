package com.kh.AttendPro.service;

import java.io.File;
import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.kh.AttendPro.dao.CertDao;
import com.kh.AttendPro.dto.CertDto;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService2 {

	@Autowired
	private JavaMailSender sender;

	@Autowired
	private RandomService randomService;

	@Autowired
	private CertDao certDao;

	
	// 인증번호 발송 서비스
	public void sendCert(String email) throws MessagingException, IOException {

		String value = randomService.generateNumber(6);

		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
		helper.setTo(email);
		helper.setSubject("인증번호 안내");

		ClassPathResource resource = new ClassPathResource("templates/cert.html");
		File target = resource.getFile();
		Document document = Jsoup.parse(target, "UTF-8");
		Element number = document.getElementById("cert-number");
		number.text(value);

		helper.setText(document.toString(), true);

		sender.send(message);

		certDao.delete(email);
		CertDto certDto = new CertDto();
		certDto.setCertEmail(email);
		certDto.setCertNumber(value);
		certDao.insert(certDto);
	}

	// 비밀번호 재설정 메일 발송 기능
	public void sendResetPw(String workerNo, String workerEmail) throws IOException, MessagingException {
		// 이메일 템플릿 불러와 정보 설정 후 발송
		ClassPathResource resource = new ClassPathResource("templates/reset-pw.html");
		File target = resource.getFile();
		Document document = Jsoup.parse(target);

		Element adminIdWrapper = document.getElementById("worker-no");
		adminIdWrapper.text(workerNo);

		// 돌아올 링크 주소를 생성하는 코드
		// -인증번호 생성
		String certNumber = randomService.generateNumber(6);
		certDao.delete(workerEmail);
		CertDto certDto = new CertDto();
		certDto.setCertEmail(workerEmail);
		certDto.setCertNumber(certNumber);
		certDao.insert(certDto);

		// 접속주소 생성
		String url = ServletUriComponentsBuilder.fromCurrentContextPath()// htpp://localhost:8080
				.path("/admin/resetPw")// 나머지 경로
				.queryParam("certNumber", certNumber)// 파라미터
				.queryParam("certEmail", workerEmail)// 파라미터
				.queryParam("workerNo", workerNo)// 파라미터
				.build().toUriString();// 문자열 변환

		Element resetUrlWrapper = document.getElementById("reset-url");
		resetUrlWrapper.attr("href", url);

		// 메세지 생성
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
		helper.setTo(workerEmail);
		helper.setSubject("비밀번호 재설정 안내");
		helper.setText(document.toString(), true);

		// 전송
		sender.send(message);
	}

}
