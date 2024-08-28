<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.row {
	margin-bottom: 15px;
}

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

.btn {
	display: inline-block;
	padding: 10px 20px;
	font-size: 16px;
	font-weight: bold;
	text-align: center;
	color: #fff;
	background-color: #007bff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.btn-positive {
	background-color: #28a745;
}

.btn-positive:hover {
	background-color: #218838;
}

h1{
	font-size: 24px;
	margin-bottom: 20px;
	color: #333;
}

.feedback{
	display: none;
	margin-top: 5px;
	font-size: 14px;
}

.success-feedback{
	color: #28a745;
}

.fail-feedback{
	color: #dc3545;
}

.fail2-feedback{
	color: #dc3545;
}
</style>


<script>
	$(function() {
		var status = {
			adminIdValid : false,
			adminIdCheckValid : false,
			adminPwValid : false,
			adminPwCheckValid : false,
			adminNoValid : false,
			adminEmailValid : false,
			ok : function() {
			    return this.adminIdValid && this.adminIdCheckValid
			        && this.adminPwValid && this.adminPwCheckValid
			        && this.adminNoValid && this.adminEmailValid;
			}
		};
		// 아이디 형식 검사
		$("[name=adminId]").blur(function() {
					var regex = /^[a-z][a-z0-9]{7,19}$/;
					var adminId = $(this).val();
					var isValid = regex.test(adminId);

					if (isValid) {
						$.ajax({
							url : "/rest/admin/checkId",
							method : "post",
							data : { adminId : adminId },
							success : function(response) {
								if (response) {
									status.adminIdCheckValid = true;
									$("[name=adminId]").removeClass("success fail fail2")
									.addClass("success");
								} else {
									status.adminIdCheckValid = false;
									$("[name=adminId]").removeClass("success fail fail2")
														.addClass("fail2");
								}
							},
						});
					} 
					else {
						$("[name=adminId]").removeClass("success fail fail2")
								.addClass("fail");
					}
					status.adminIdValid = isValid;
				});
		// 비밀번호 형식 검사
		$("[name=adminPw]")
				.blur(
						function() {
							var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
							var isValid = regex.test($(this).val());
							$(this).removeClass("success fail").addClass(
									isValid ? "success" : "fail");
							status.adminPwValid = isValid;
						});

		// 비밀번호 확인 검사
		$("#password-check").blur(
				function() {
					var isValid = $("[name=adminPw]").val().length
							&& $(this).val() == $("[name=adminPw]").val();
					$(this).removeClass("success fail").addClass(
							isValid ? "success" : "fail");
					status.adminPwCheckValid = isValid;
				});

		// 사업자 번호 형식 검사
		$("[name=adminNo]").blur(
				function() {
					var regex = /^[0-9]{3}-[0-9]{2}-[0-9]{5}$/;
					var isValid = regex.test($(this).val());
					$(this).removeClass("success fail").addClass(
							isValid ? "success" : "fail");
					status.adminNoValid = isValid;
				});

		// 이메일 형식 검사 
		$("[name=adminEmail]").blur(function(){
			var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
			var isValid = regex.test($(this).val());
			 $(this).removeClass("success fail")
             .addClass(isValid ? "success" : "fail");
			 status.adminEmailValid = isValid;
		});

		// 폼 제출 검사
		$(".check-form").submit(function() {
			$("[name], #password-check").trigger("blur");
			return status.ok();
		});
	});
</script>




<div class="container w-500 my-50">
	<div class="row center">
		<h1>회원가입</h1>
	</div>
	<form class="check-form" action="join" method="post" autocomplete="off"
		enctype="multipart/form-data">
		<div class="row">
			<label>아이디</label> <input name="adminId" type="text"
				class="field w-100" placeholder="영문소문자 시작, 숫자 포함 8~20자">
			<div class="success-feedback">올바른 형식입니다!</div>
			<div class="fail-feedback">형식에 맞춰 8~20자로 작성하세요</div>
			<div class="fail2-feedback">중복된 아이디입니다</div>
		</div>
		<div class="row">
			<label>비밀번호</label> <input name="adminPw" type="password"
				class="field w-100" placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함">
			<div class="success-feedback">올바른 형식입니다!</div>
			<div class="fail-feedback">형식에 맞춰 8~16자로 작성하세요</div>
		</div>
		<div class="row">
			<label>비밀번호 확인</label> <input type="password" id="password-check"
				class="field w-100" placeholder="확인을 위해 비밀번호 한번 더 입력" required>
			<div class="success-feedback">비밀번호가 일치합니다</div>
			<div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
		</div>
		<div class="row">
			<label>사업자 번호</label> <input name="adminNo" type="text"
				class="field w-100" placeholder="***-**-*****">
			<div class="success-feedback">올바른 형식입니다</div>
			<div class="fail-feedback">***-**-***** 형태로 작성하십시오</div>
		</div>
		<div class="row">
			<label>이메일</label> <input name="adminEmail" type="text"
				class="field w-100" placeholder="sample@kh.com">
			<div class="fail-feedback">형식에 맞춰 작성하십시오</div>
		</div>
		<div class="row">
			<button type="submit" class="btn btn-positive w-100">등록하기</button>
		</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
