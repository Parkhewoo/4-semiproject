package com.kh.AttendPro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/calendar")
public class CalendarController {

    @RequestMapping("/show")
    public String showCalendar() {
        return "/WEB-INF/views/template/calendar.jsp"; // views/template/calendar.jsp로 매핑됨
    }
}