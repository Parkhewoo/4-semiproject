
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
		//상태 객체
		var status = {
				adminPwValid : false,
			adminPwCheckValid : false,
			ok : function(){
				return this.adminPwValid && this.adminPwCheckValid;
			}
		};
		
		//비밀번호 형식검사
		$("[name=adminPw]").blur(function(){
			var adminPw= $(this).val();
			var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
			status.adminPwValid = regex.test(adminPw);
			$(this).removeClass("success fail").addClass(status.adminPwValid ? "success" : "fail");
		});
		//비밀번호 확인 검사
		$("#password-check").blur(function(){
    var adminPw = $("[name=adminPw]").val();
    var adminPwCheck = $(this).val();
    status.adminPwCheckValid = adminPw.length > 0 && adminPw == adminPwCheck;
    $(this).removeClass("success fail").addClass(status.adminPwCheckValid ? "success" : "fail");
});
		//form 검사
		$(".check-form").submit(function(){
			$("[name=adminPw]").trigger("blur");
			$("#password-check").trigger("blur");
			return status.ok();
		});
	});
</script>

<div class="container w-600 my-50">
	<div class="row center">
		<h1>비밀번호 재설정</h1>
	</div>
	
	<form action="resetPw" method="post" autocomplete="off" class="check-form">
		<input type="hidden" name="certEmail" value="${certDto.certEmail}">
		<input type="hidden" name="certNumber" value="${certDto.certNumber}">
		<input type="hidden" name="adminId" value="${adminId}">
	
		<div class="row">
			<label>변경할 비밀번호</label>
			<input type="password" name="adminPw" class="field w-100">
			<div class="success-feedback">형식에 맞는 비밀번호입니다</div>
			<div class="fail-feedback">영문 대소문자, 숫자, 특수문자를 포함한 8~16자로 작성하세요</div>
		</div>
		<div class="row">
			<label>비밀번호 확인</label>
			<input type="password" id="password-check" class="field w-100">
			<div class="success-feedback">비밀번호가 일치합니다</div>
			<div class="fail-feedback">비밀번호가 일치하지않습니다</div>
		</div>
		<div class="row mt-30">
			<button type="submit" class="btn btn-positive w-100">
				<i class="fa-solid fa-lock"></i>
				변경하기
			</button>
		</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
