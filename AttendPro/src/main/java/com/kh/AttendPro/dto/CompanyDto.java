package com.kh.AttendPro.dto;

import java.sql.Date;
import lombok.Data;

@Data
public class CompanyDto {
    private String companyId;
    private String companyName;
    private Date companyInTime;
    private Date companyOutTime;
    private Date companyHoliday;  // 수정된 부분
}
