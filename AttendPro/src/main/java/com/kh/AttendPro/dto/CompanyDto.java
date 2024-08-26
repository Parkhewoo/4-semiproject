package com.kh.AttendPro.dto;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class CompanyDto {
    private String companyId;
    private String companyName;
    private Date companyIn;
    private Date companyOut;
    private Date companyHoliday;  // 수정된 부분
}
