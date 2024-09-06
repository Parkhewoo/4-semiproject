package com.kh.AttendPro.restController;

import java.sql.Date;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.AttendPro.dao.HolidayDao;


@RestController
@RequestMapping("rest/holi")
public class HolidayRestController {

	@Autowired
	private HolidayDao holidayDao;
	
	@PostMapping("/add")
	public String addHoliday(@RequestParam String companyId, @RequestParam String holidayDate) {
		try {
            Date date = Date.valueOf(holidayDate); // 문자열을 java.sql.Date로 변환
            holidayDao.addHoliday(companyId, date); // 공휴일 삭제
            return "추가되었습니다"; // 성공 메시지 반환
        } catch (Exception e) {
            return "Error deleting holiday: " + e.getMessage(); // 오류 메시지 반환
        }
    }
	
	
	@PostMapping("/delete")
    public String deleteHoliday(@RequestParam String companyId, @RequestParam String holidayDate) {
        try {
            Date date = Date.valueOf(holidayDate); // 문자열을 java.sql.Date로 변환
            holidayDao.deleteHoliday(companyId, date); // 공휴일 삭제
            return "삭제되었습니다"; // 성공 메시지 반환
        } catch (Exception e) {
            return "Error deleting holiday: " + e.getMessage(); // 오류 메시지 반환
        }
    }
	
	@PostMapping("/addMultiple")
	public String addMultipleHolidays(@RequestParam String companyId, @RequestParam String holidayDates) {
	    //system.out.println("Received companyId: " + companyId);
	    //system.out.println("Received holidayDates: " + holidayDates);
	    
	    try {
	        List<Date> dates = Arrays.stream(holidayDates.split(","))
	            .map(Date::valueOf)
	            .collect(Collectors.toList());

	        for (Date date : dates) {
	            holidayDao.addHoliday(companyId, date);
	        }
	        return "Dates added successfully";
	    } catch (Exception e) {
	        e.printStackTrace(); // 자세한 오류 스택 트레이스를 기록
	        return "Error adding holidays: " + e.getMessage();
	    }
	}


    @PostMapping("/deleteMultiple")
    public String deleteMultipleHolidays(@RequestParam String companyId, @RequestParam String holidayDates) {
        try {
            List<Date> dates = Arrays.stream(holidayDates.split(","))
                .map(Date::valueOf)
                .collect(Collectors.toList());

            for (Date date : dates) {
                holidayDao.deleteHoliday(companyId, date);
            }
            return "Dates deleted successfully";
        } catch (Exception e) {
            return "Error deleting holidays: " + e.getMessage();
        }
    }
}