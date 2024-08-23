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

    <style>
    

    </style>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<form action="login" method="post" autocomplete="off">
	<div class="container w-350 my-50">
		<div class="row center">
			<h1>로그인</h1>
		</div>
		<div class="row">
			<input type="text" name="adminId" class="field w-100"
				 placeholder="아이디">
		</div>
		<div class="row">
			<input type="password" name="adminPw" class="field w-100"
				 placeholder="비밀번호">
		</div>
		<div class="row">
			<button type="submit" class="btn btn-positive w-100">로그인</button>
		</div>
	</div>
</form>



<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>