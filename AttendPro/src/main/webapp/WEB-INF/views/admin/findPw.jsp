<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
$(function(){
	$(".check-form").submit(function(){
		var btn = $(this).find("button[type=submit]");
		btn.find("i").addClass("fa-bounce");
		return true;
	});
});
</script>

<div class="container w-500 my-50">
	<div class="row center">
		<h1>비밀번호 찾기</h1>
	</div>
	
	<form action="findPw" method="post" autocomplete="off" class="check-form">
	<div class="row">
		<label>아이디</label>
		<input type="text" name="adminId" class="field w-100">
	</div>
	<div class="row">
		<label>이메일</label>
		<input type="email" name="adminEmail" class="field w-100">
	</div>
	<div class="row mt-30">
		<button type="submit" class="btn btn-positive w-100">
			<i class="fa-regular fa-envelope"></i>
			<span>비밀번호 재설정 메일 발송</span>
		</button>
	</div>
	</form>
	
	<c:if test="${param.error != null}">
	<div class="row center">
		<b class="red">아이디 또는 이메일이 일치하지 않습니다</b>
	</div>
	</c:if>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>