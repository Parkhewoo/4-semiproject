package com.kh.AttendPro.dto;

import lombok.Data;

@Data
public class WorkerDto {
	private int workerNo;
	private String workerName;
	private int workerAttend;
	private int workerAbsent;
	private int workerLate;
	private int workerLeave;
	private String workerJoinDate;
}

