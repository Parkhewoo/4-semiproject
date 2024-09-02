package com.kh.AttendPro.vo;

import lombok.Data;

@Data
public class AttendanceVO {
	private int attend;
	private int absent;
	private int late;
	private int leave;
	private int workday;
}
