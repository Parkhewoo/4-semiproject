package com.kh.AttendPro.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class NoticeDto {
	private int noticeNo;
	private String noticeWriter;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeWtime;
	private Date noticeUtime;
}
