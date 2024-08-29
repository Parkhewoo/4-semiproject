package com.kh.AttendPro.dto;

import java.time.LocalTime;

import lombok.Data;

import java.sql.Date;

@Data
public class CompanyDto {
    private String companyId;
    private String companyCeo;
    private String companyName;
    private LocalTime companyIn;       // LocalTime으로 변경
    private LocalTime companyOut;      // LocalTime으로 변경
    private String companyPost;		   // 우편번호
    private String companyAddress1;	   // 주소
    private String companyAddress2;    // 상세주소
}