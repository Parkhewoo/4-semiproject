package com.kh.AttendPro.dto;

import java.sql.Date;
import java.time.LocalTime;

import lombok.Data;

@Data
public class RecordDto {
	private int workerNo; //primary key
	private String adminId;
	private Date workerIn;
	private Date workerOut;
}
