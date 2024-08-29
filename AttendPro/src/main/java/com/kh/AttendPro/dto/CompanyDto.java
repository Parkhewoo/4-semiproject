package com.kh.AttendPro.dto;

import java.time.LocalTime;

import lombok.Data;

import java.sql.Date;

@Data
public class CompanyDto {
    private String companyId;
    private String companyName;
    private LocalTime companyIn;       // LocalTime으로 변경
    private LocalTime companyOut;      // LocalTime으로 변경
}
