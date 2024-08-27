package com.kh.AttendPro.restController;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.AttendPro.error.TargetNotFoundException;
import com.kh.AttendPro.service.AttachmentService;

@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@RestController
@RequestMapping("/rest/qna")
public class QnaRestController {
	
	//글 내부에 포함될 이미지를 업로드하고 번호를 반환하는 기능
	@Autowired
	private AttachmentService attachmentService;
	
	@PostMapping("/upload")
	public int upload(@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		if(attach.isEmpty()) {
			throw new TargetNotFoundException("파일이 없습니다");
		}
		int attachmentNo = attachmentService.save(attach);
		return attachmentNo;
	}
	
	@PostMapping("/uploads")
	public List<Integer> uploads(
			@RequestParam(value = "attach") List<MultipartFile> attachList) throws IllegalStateException, IOException {
		List<Integer> results = new ArrayList<>();//번호 담을 저장소 생성
		for(MultipartFile attach : attachList) {//사용자가 보낸 파일 수만큼 반복
			if(!attach.isEmpty()) {
				int attachmentNo = attachmentService.save(attach);
				results.add(attachmentNo);
			}
		}
		return results;
	}



}