package com.kh.AttendPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.AttendPro.dao.CompanyDao;
import com.kh.AttendPro.dto.CompanyDto;
import com.kh.AttendPro.error.TargetNotFoundException;

import java.sql.Timestamp;

@Controller
@RequestMapping("/admin/company")
public class AdminCompanyController {

    @Autowired
    private CompanyDao companyDao;

    // 상세
    @RequestMapping("/info")
    public String detail(@RequestParam String companyId, Model model) {
        CompanyDto companyDto = companyDao.selectOne(companyId);
        if (companyDto == null) {
            throw new TargetNotFoundException();
        }
        model.addAttribute("companyDto", companyDto);
        return "/WEB-INF/views/company/detail.jsp";
    }

    // 수정 (GET)
    @GetMapping("/set")
    public String set(Model model, @RequestParam String companyId) {
        CompanyDto companyDto = companyDao.selectOne(companyId);
        if (companyDto == null) throw new TargetNotFoundException();
        model.addAttribute("companyDto", companyDto);
        return "/WEB-INF/views/company/set.jsp";
    }

    // 수정 (POST)
    @PostMapping("/set")
    public String set(@ModelAttribute CompanyDto companyDto) {
        boolean result = companyDao.update(companyDto);
        if (!result) throw new TargetNotFoundException();
        return "redirect:info?companyId=" + companyDto.getCompanyId(); // 수정 후 리다이렉트
    }
}
