package com.kh.AttendPro.dto;

import java.sql.Date;
import java.sql.Timestamp;


import lombok.Data;

@Data
public class CompanyDto {
	private String companyName;
	private Date companyInTime;
	private Date companyOutTime;
	private Date companyHolidayDate;
}
