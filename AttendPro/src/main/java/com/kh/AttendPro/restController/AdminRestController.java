package com.kh.AttendPro.restController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.AttendPro.dao.AdminDao;
import com.kh.AttendPro.dto.AdminDto;

@RestController
@RequestMapping("/rest/admin")
public class AdminRestController {
	
	@Autowired
	private AdminDao adminDao;
	
	//아이디 중복 여부 확인
	@PostMapping("/checkId")
	public boolean checkId(@RequestParam String adminId) {
		AdminDto adminDto = adminDao.selectOne(adminId);
		return adminDto == null;
	}
}
