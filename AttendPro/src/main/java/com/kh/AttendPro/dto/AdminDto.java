package com.kh.AttendPro.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class AdminDto {
	private String adminId;
	private String adminPw;
	private String adminNo;
	private String adminRank;
	private String adminEmail;
	private Date adminLogin;
}

