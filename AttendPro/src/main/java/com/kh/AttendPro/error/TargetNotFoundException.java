package com.kh.AttendPro.error;

public class TargetNotFoundException extends RuntimeException{
	//기본 생성자
	public TargetNotFoundException() {}
	
	//예외 메세지를 전달받는 생성자
	public TargetNotFoundException(String msg) {
		super(msg);
	}
}
