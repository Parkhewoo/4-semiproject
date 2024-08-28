package com.kh.AttendPro.restController;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.AttendPro.dao.WorkerDao;
import com.kh.AttendPro.service.AttachmentService;
import com.kh.AttendPro.vo.StatusVO;

import jakarta.servlet.http.HttpSession;

//회원에 대한 비동기 통신을 처리하기 위한 컨트롤러
@RestController
@RequestMapping("/rest/worker")
public class WorkerRestController {
	@Autowired
	WorkerDao workerDao;
	
	@Autowired
	private AttachmentService attachmentService;
	
	//프로필 이미지만 업로드하는 매핑
	@PostMapping("/profile")
	public void profile(HttpSession session,
							@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		if(attach.isEmpty()) return;
		//아이디 추출
		int workerNo = (int)session.getAttribute("createdUser");
		
		//기존 이미지가 있다면 제거
		try {
			int beforeNo = workerDao.findImage(workerNo);//번호를 찾은뒤
			attachmentService.delete(beforeNo);//지우기
		}
		catch(Exception e) {}
		
		//신규 이미지 저장
		int attachmentNo = attachmentService.save(attach);
		
		//아이디와 신규 이미지를 연결
		workerDao.connect(workerNo, attachmentNo);
	}
	
	//(시스템관리자용) 데이터베이스현황 조회 status
		@RequestMapping("/status")
		public List<StatusVO> statusByWorkerRank(){
			return workerDao.statusByWorkerRank();
		}
	
	
}





