<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
</head>
<body>
<form action="admin/login" method="post" autocomplete="off">
	<div class="container w-350 my-50">
		<div class="row center">
			<h1>로그인</h1>
		</div>
		<div class="row">
			<label>아이디</label>
		<input type="text" name="adminId" value="${cookie.saveId.value}">
		</div>
		
		<div class="row">
			<label>비밀번호</label>
		<input type="password" name="adminPw">
		</div>
		
		<div class="row flex-box">
		<label>
		<input type="checkbox" >
		관리자 로그인
		</label>
		<label>
		<input type="checkbox" >
		일반회원 로그인
		</label>
		</div>
		
		<div class="row">
		<label>
		<input type="checkbox" name="remember"
		<c:if test="${cookie.saveId != null}">checked</c:if>>
		<span>아이디 저장하기</span>
		</label>
		</div>
		
		<div class="row mt-30">
			<button class="btn btn-positive w-100">로그인</button>
		</div>
		
</div>
</form>
</body>
</html>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
