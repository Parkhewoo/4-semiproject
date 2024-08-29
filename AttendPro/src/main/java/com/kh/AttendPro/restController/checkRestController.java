package com.kh.AttendPro.restController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.AttendPro.dao.RecordDao;

@RestController
@RequestMapping("/rest/record")
public class checkRestController {

	@Autowired
	RecordDao recordDao;
	
	@PostMapping("/checkIn")
	public void checkIn(@RequestParam("workerNoStr") String workerNoStr) {
		int workerNo = Integer.parseInt(workerNoStr);
        recordDao.checkIn(workerNo);
//		return "redirect:/rest/check";
	}
	
//	당일 출근 기록이 없을 경우 접근 불가 
	@PostMapping("/checkOut")
	public void checkOut(@RequestParam("workerNoStr") String workerNoStr) {
		int workerNo = Integer.parseInt(workerNoStr);
        recordDao.checkOut(workerNo);
//		return "redirect:/rest/check";
	}
}
