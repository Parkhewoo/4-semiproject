package com.kh.AttendPro.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class CompanyDto {
	private String companyName;
	private String companyInTime;
	private String companyOutTime;
	private Date companyHolidayDate;
}
