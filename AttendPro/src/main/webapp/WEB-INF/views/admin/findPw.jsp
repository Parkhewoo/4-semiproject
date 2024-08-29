<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.row label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
	color: #333;
}

.field {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

.field:focus {
	border-color: #007bff;
	outline: none;
	box-shadow: 0 0 0 0.2rem rgba(38, 143, 255, 0.25);
}
.btn  {
    background-color: #659ad5;
    color: white;
    border-radius: 0.3em;
    border: none;
} 
.btn:hover {
	background-color: #0869d4 !important;
}

</style>
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