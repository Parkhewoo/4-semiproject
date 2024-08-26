package com.kh.AttendPro.controller;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.AttendPro.dao.AttachmentDao;
import com.kh.AttendPro.dto.AttachmentDto;
import com.kh.AttendPro.error.TargetNotFoundException;
import com.kh.AttendPro.service.AttachmentService;

import jakarta.servlet.http.HttpServletResponse;

//사용자에게 파일을 전송하는 컨트롤러

@RestController
// 이 컨트롤러는 화면이 아닌 데이터를 사용자에게 보내는 컨트롤러
@RequestMapping("/attach")
public class FileDownloadController {
	@Autowired
	private AttachmentDao attachmentDao;
	
	@Autowired
	private AttachmentService attachmentService;
	
	public void download(@RequestParam int attachmentNo,
									HttpServletResponse response) throws IOException {
		//[1] attachmentNo에 대한 데이터 확인 작업
		AttachmentDto attachmentDto = attachmentDao.selectOne(attachmentNo);
		if(attachmentDto == null) {
			throw new TargetNotFoundException("존재하지 않는 파일 번호입니다.");
		}
		
		//[2] 정보가 있으므로 실제 파일을 불러오는 작업
		// apache commons io 라이브러리 사용
		File dir = new File("D:/upload");
		File target = new File(dir, String.valueOf(attachmentNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		
		//[3] 불러온 정보를 사용자에게 전송하는 작업(헤더 + 바디)
		response.setHeader("Content-Encoding", "UTF-8");
		response.setHeader("Content-Type", "application/octet-stream");
		response.setHeader("Content-Length",
								String.valueOf(attachmentDto.getAttachmentSize()));
		response.setHeader("Content-Disposition", 
					"attachment; filename="+attachmentDto.getAttachmentName());
		response.getOutputStream().write(data);		
	}
	
	@RequestMapping("/download")
	public ResponseEntity<ByteArrayResource> download(
									@RequestParam int attachmentNo) throws IOException{
		return attachmentService.find(attachmentNo);
	}
}
