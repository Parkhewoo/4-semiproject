package com.kh.AttendPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.AttendPro.dao.WorkerDao;

@Controller
@RequestMapping("/worker")
public class WorkerController {

	@Autowired
	private WorkerDao workerdao;
	
	//Worker 로그인
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/worker/login.jsp";
	}
	
//	@POSTMAPPING("/LOGIN")
//	PUBLIC STRING LOGIN(@REQUESTPARAM STRING WORKERNO,
//								@REQUESTPARAM STRING WORKERPW) {
//		
//	}
}
