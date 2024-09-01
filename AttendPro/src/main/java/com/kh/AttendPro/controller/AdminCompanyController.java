package com.kh.AttendPro.controller;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import com.kh.AttendPro.dao.CompanyDao;
import com.kh.AttendPro.dao.HolidayDao;
import com.kh.AttendPro.dto.CompanyDto;
import com.kh.AttendPro.dto.HolidayDto;
import com.kh.AttendPro.error.TargetNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.List;

@Controller
@RequestMapping("/admin/company")
public class AdminCompanyController {

    @Autowired
    private CompanyDao companyDao;

    @Autowired
    private HolidayDao holidayDao;

    @GetMapping("/insert")
    public String insert() {
        return "/WEB-INF/views/admin/company/insert.jsp";
    }

    @PostMapping("/insert")
    public String insert(@ModelAttribute CompanyDto companyDto,
                         HolidayDto holidayDto) {
        if (companyDto.getCompanyId() == null || companyDto.getCompanyId().isEmpty()) {
            throw new IllegalArgumentException("Company ID is missing");
        }

        companyDao.insert(companyDto);
        holidayDao.insert(holidayDto);
        return "redirect:info?companyId=" + companyDto.getCompanyId();
    }

    @RequestMapping("/info")
    public String detail(@RequestParam String companyId, Model model) {
        CompanyDto companyDto = companyDao.selectOne(companyId);
        if (companyDto == null) {
            throw new TargetNotFoundException();
        }
        List<HolidayDto> holidays = holidayDao.selectByCompanyId(companyId);

        // JSON 변환
        Gson gson = new GsonBuilder()
            .setDateFormat("yyyy-MM-dd") // 날짜 형식 지정
            .create();
        String holidaysJson = gson.toJson(holidays);

        // 모델에 JSON 문자열 추가
        model.addAttribute("holidaysJson", holidaysJson);
        model.addAttribute("companyDto", companyDto);
        return "/WEB-INF/views/admin/company/detail.jsp";
    }

    // 수정 (GET)
    @GetMapping("/set")
    public String set(Model model, @RequestParam String companyId) {
        CompanyDto companyDto = companyDao.selectOne(companyId);
        //if (companyDto == null) throw new TargetNotFoundException();

        List<Date> holidayDates = holidayDao.selectHolidayDatesByCompanyId(companyId);

        model.addAttribute("companyDto", companyDto);
        model.addAttribute("holidayDates", holidayDates);

        return "/WEB-INF/views/admin/company/set.jsp";
    }

    @PostMapping("/set")
    public String updateCompany(@ModelAttribute CompanyDto companyDto,
                                @RequestParam(required = false) String addHolidayDate,
                                @RequestParam(required = false) String removeHolidayDate,
                                @RequestParam String companyId) throws ParseException {
        // 회사 정보 업데이트
        boolean result = companyDao.update(companyDto);
        if (!result) throw new TargetNotFoundException();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        // 휴일 추가
        if (addHolidayDate != null && !addHolidayDate.isEmpty()) {
            java.util.Date parsedAddDate = sdf.parse(addHolidayDate);
            holidayDao.addHoliday(companyId, new java.sql.Date(parsedAddDate.getTime()));
        }

        // 휴일 삭제
        if (removeHolidayDate != null && !removeHolidayDate.isEmpty()) {
            java.util.Date parsedRemoveDate = sdf.parse(removeHolidayDate);
            holidayDao.deleteHoliday(companyId, new java.sql.Date(parsedRemoveDate.getTime()));
        }

        return "redirect:info?companyId=" + companyDto.getCompanyId();
    }

}