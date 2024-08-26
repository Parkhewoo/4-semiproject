package com.kh.AttendPro.advice;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.kh.AttendPro.error.TargetNotFoundException;

@ControllerAdvice(annotations = {Controller.class})
public class ExceptionAdvice {
	@ExceptionHandler(TargetNotFoundException.class)
	public String notFound() {
		return "/WEB-INF/views/error/notFound.jsp";
	}
}
