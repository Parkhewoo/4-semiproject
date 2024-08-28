package com.kh.AttendPro.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class QnaDto {
	private int qnaNo;
	private String qnaTitle;
	private String qnaContent;
	private String qnaWriter;
	private Date qnaWTime;
	private Date qnaUTime;
	private String qnaReply;	
	
	//답글 추가
	private int qnaGroup;
	private Integer qnaTarget;
	private int qnaDepth;
	
	//메소드 추가
	public String getQnaWriterString() {
		if(qnaWriter ==null) return "탈퇴한 사용자";
		return qnaWriter;
	}
	
	//java.sql.date는 LocalDate로 쉽게 변환 가능
	//java.sql.Timestamp는 LocalDateTime으로 쉽게 변환가능
	public String getQnaWTimeString() {
		if(qnaWTime == null) {
			return "시간 없음";
		}
		Timestamp stamp = new Timestamp(qnaWTime.getTime());
		LocalDateTime time = stamp.toLocalDateTime();
		LocalDate today = LocalDate.now();
		if(time.toLocalDate().equals(today)) {
			return time.format(DateTimeFormatter.ofPattern("HH:mm"));
		}
		else
		return time.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	}
	
	public boolean isNew() {
		return this.qnaTarget == null;
	}
	public boolean isReply() {
		return this.qnaTarget != null;
	}

}
