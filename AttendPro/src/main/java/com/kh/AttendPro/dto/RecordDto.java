package com.kh.AttendPro.dto;

import java.sql.Date;
import java.time.LocalTime;

import lombok.Data;

@Data
public class RecordDto {
	private String companyId;
	private String companyName;
	private LocalTime companyIn;
	private LocalTime companyOut;
	private Date companyHoliday;
	private int workerNo; //primary key
	private int workerAttend;
	private int workerAbsent;
	private int workerLate;
	private int workerLeave;
	private Date workerIn;
	private Date workerOut;
}
