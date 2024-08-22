package com.kh.AttendPro.dto;

import lombok.Data;

@Data
public class WorkerDto {
	private int workerNo;
	private String workerPw;
	private String workerName;
	private int workerAttend;
	private int workerAbsent;
	private int workerLate;
	private int workerLeave;
	private String workerJoin;
	private String workerRank;
	private String workerBirthday;
	private String workerContact;
	private String workerEmail;
	private String workerPost;
	private String workerAddress1;
	private String workerAddress2;
}

