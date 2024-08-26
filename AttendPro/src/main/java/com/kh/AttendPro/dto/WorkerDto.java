package com.kh.AttendPro.dto;

import lombok.Data;

@Data
public class WorkerDto {
    private int workerNo;
    private String name;
    private String workerPw;
    private String workerName;
    private int workerAttend;
    private int workerAbsent;
    private int workerLate;
    private int workerLeave;
    private java.sql.Date workerJoin;  // DATE 타입
    private String workerRank;
    private java.sql.Date workerBirthday;  // DATE 타입
    private String workerContact;
    private String workerEmail;
    private String workerPost;
    private String workerAddress1;
    private String workerAddress2;

  
}