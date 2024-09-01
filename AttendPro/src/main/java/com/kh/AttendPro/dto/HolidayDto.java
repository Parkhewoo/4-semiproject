package com.kh.AttendPro.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class HolidayDto {
    private String companyId; // 회사 ID
    private Date holidayDate; // 공휴일 날짜
    private int holidayId;
}