package com.kh.AttendPro.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class RecordDto {
	private Date recordIn;
	private Date recordOut;
	private int recordAttend;
	private int recordAbsent;
	private int recordLate;
	private int recordLeave;
	private String recordIsCome;
}
