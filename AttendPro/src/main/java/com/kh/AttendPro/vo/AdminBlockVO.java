package com.kh.AttendPro.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class AdminBlockVO {
	private String adminId; //아이디
	private String adminPw; //비밀번호
	private String adminNo; //사업자번호
	private String adminRank; //관리자등급
	private String adminEmail; //이메일
	private Date adminLogin; //최종로그인일시
	
	private int blockNo;
	private String blockType;
	private String blockMemo;
	private Date blockTime;
	private String blockTarget;//회원ID(외래키,FK)
}
	
