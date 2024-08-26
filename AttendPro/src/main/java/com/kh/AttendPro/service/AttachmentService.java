package com.kh.AttendPro.service;


import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.AttendPro.configuration.CustomFileuploadProperties;
import com.kh.AttendPro.dao.AttachmentDao;
import com.kh.AttendPro.dto.AttachmentDto;
import com.kh.AttendPro.error.TargetNotFoundException;

import jakarta.annotation.PostConstruct;

@Service
public class AttachmentService {
	
	@Autowired
	private CustomFileuploadProperties properties;
	
	private File dir;
		
	
	@PostConstruct
	public void init() {
		dir = new File(properties.getPath());
		dir.mkdirs();
	}
	
	@Autowired
	private AttachmentDao attachmentDao;
	
	public int save(MultipartFile attach) throws IllegalStateException, IOException {
		//[1] 시퀀스 생성1
		int attachmentNo = attachmentDao.sequence();
		
		//[2] 실물파일 저장
		File target = new File(dir, String.valueOf(attachmentNo));
		attach.transferTo(target);
		
		//[3]db생성 
		AttachmentDto attachmentDto= new AttachmentDto();
		attachmentDto.setAttachmentNo(attachmentNo);
		attachmentDto.setAttachmentName(attach.getOriginalFilename());
		attachmentDto.setAttachmentType(attach.getContentType());
		attachmentDto.setAttachmentSize(attach.getSize());
		return attachmentNo;		
	}
	
	//파일삭제 + DB삭제
	public void delete(int attachmentNo) {
		//파일삭제
		AttachmentDto attachmentDto = attachmentDao.selectOne(attachmentNo);
		if(attachmentDto == null) {
			throw new TargetNotFoundException("존재하지 않는 파일 번호입니다.");
		}
		
		//실물 파일 삭제
		File dir = new File("D:/upload");
		File target = new File(dir, String.valueOf(attachmentNo));
		target.delete();
		
		//DB삭제
		attachmentDao.delete(attachmentNo);
	}
	
	public ResponseEntity<ByteArrayResource> find(int attachmentNo) throws IOException{
		//[1] attachmentNo에 대한 데이터가 존재하는지 확인하는 작업
		AttachmentDto attachmentDto = attachmentDao.selectOne(attachmentNo);
		if(attachmentDto == null) {
			throw new TargetNotFoundException("존재하지 않는 파일 번호입니다.");
		}
		
		//[2] 정보가 있으면 실제 파일을 불러온다
		// - 파일을 불러오는 라이브러리 사용(apache commons io)
		File dir = new File("D:/upload");
		File target = new File(dir, String.valueOf(attachmentNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);//포장 하는 방식
		
		//[3] 불러온 정보를 사용자에게 전송(헤더 + 바디)
		return ResponseEntity.ok()
					.contentType(MediaType.APPLICATION_OCTET_STREAM)
					.contentLength(attachmentDto.getAttachmentSize())
					.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
					.header(HttpHeaders.CONTENT_DISPOSITION,
								ContentDisposition.attachment()
									.filename(
											attachmentDto.getAttachmentName(),
											StandardCharsets.UTF_8
										).build().toString()
					)
				.body(resource);		
	} 
	
}
