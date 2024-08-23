<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	 <%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <link rel="stylesheet" type="text/css" href="./commons.css">
    <!--<link rel="stylesheet" type="text/css" href="./test.css">-->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="/css/commons.css">

<form action="join" method="post">
	<div class="container w-500 my-50">
		<div class="row center">
			<h1>회원가입</h1>
		</div>
		<div class="row">
			<label>아이디</label> 
		<input name="adminId" type="text" class="field w-100"
				placeholder="영문소문자 시작, 숫자 포함 8~20자">
		</div>
		<div class="row">
			<label>비밀번호</label> 
		<input name="adminPw" type="password" class="field w-100"
				placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함">
		</div>
		<div class="row">
		<label>사업자 번호</label>
		<input name="adminNo" type="text" class="field w-100"
				placeholder="***-**-*****">
		</div>
		
		<div class="row">
		<label>이메일</label>
		<input name="adminEmail" type="text" class="field w-100"
				placeholder="sample@kh.com">
		</div>
		<div class="row">
			<button type="submit" class="btn btn-positive w-100">등록하기</button>
		</div>
	</div>
</form>


<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>