<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <!--<link rel="stylesheet" type="text/css" href="./test.css">-->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="/css/commons.css">

    <style>
    

    </style>

<form action="login" method="post" autocomplete="off">
	<div class="container w-350 my-50">
		<div class="row center">
			<h1>사원 로그인</h1>
		</div>
		<div class="row">
			<input type="text" name="workerNo" class="field w-100"
				 placeholder="아이디">
		</div>
		<div class="row">
			<input type="password" name="workerPw" class="field w-100"
				 placeholder="비밀번호">
		</div>
		<div class="row">
			<button type="submit" class="btn btn-positive w-100">로그인</button>
		</div>
		<div class="row center">
			<!-- worker 비밀번호 찾기도 a태그 이동위치가  findPw가 맞는지 확인 필요 -->
			<a href="findPw">비밀번호가 기억나지 않습니다</a>
		</div>
		<c:if test="${param.error != null}">
			<div class="row center">
				<b class="red">아이디 또는 비밀번호가 일치하지 않습니다</b>
			</div>
		</c:if>
	</div>
</form>



<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>