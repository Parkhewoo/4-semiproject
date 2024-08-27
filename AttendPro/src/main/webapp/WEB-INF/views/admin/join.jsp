<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./commons.css">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

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

h1 {
	font-size: 24px;
	margin-bottom: 20px;
	color: #333;
}

.feedback {
	display: none;
	margin-top: 5px;
	font-size: 14px;
}

.success-feedback {
	color: #28a745;
}

.fail-feedback {
	color: #dc3545;
}

.fail2-feedback {
	color: #dc3545;
}
</style>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(function() {
		var status = {
			adminIdValid : false,
			adminIdCheckValid : false,
			adminPwValid : false,
			adminPwCheckValid : false,
			adminNoValid : false,
			adminEmailValid : false,
			adminEmailCheckValid : false,
			ok : function() {
				return this.adminIdValid && this.adminIdCheckValid
						&& this.adminPwValid && this.adminPwCheckValid
						&& this.adminNoValid && this.adminEmailValid
						&& this.adminEmailCheckValid;
			},
		};
		// 아이디 형식 검사
		$("[name=adminId]").blur(
				function() {
					var regex = /^[a-z][a-z0-9]{7,19}$/;
					var adminId = $(this).val();
					var isValid = regex.test(adminId);

					if (isValid) {
						$.ajax({
							url : "/rest/admin/checkId",
							method : "post",
							data : {
								adminId : adminId
							},
							success : function(response) {
								if (response) {
									status.adminIdCheckValid = true;
									$("[name=adminId]").removeClass(
											"success fail fail2").addClass(
											"success");
								} else {
									status.adminIdCheckValid = false;
									$("[name=adminId]").removeClass(
											"success fail fail2").addClass(
											"fail2");
								}
							},
						});
					} else {
						$("[name=adminId]").removeClass("success fail fail2")
								.failClass("fail");
					}
					status.adminIdValid = isValid;
				});
		// 비밀번호 형식 검사
		$("[name=adminPw]")
				.blur(
						function() {
							var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
							var isValid = regex.test($(this).val());
							$(this).removeClass("succes fail").addClass(
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
					var isValid = $(this).val().length == 0
							|| regex.test($(this).val());
					$(this).removeClass("success fail").addClass(
							isValid ? "success" : "fail");
					status.adminNoValid = isValid;
				});

		// 이메일 형식 검사 및 인증
		var certEmail;

		$(".btn-cert-send").blur(
				function() {
					var email = $("[name=adminEmail]").val();
					if (email.length === 0) {
						status.adminEmailValid = false;
						return;
					}

					status.adminEmailValid = true;

					$.ajax({
						url : "/rest/cert/send",
						method : "post",
						data : {
							certEmail : email
						},
						beforeSend : function() {
							$(".email-wrapper").nextAll(".cert-wrapper")
									.remove();
							$(".btn-cert-send").prop("disabled", true);
							$(".btn-cert-send").find(".fa-solid").removeClass(
									"fa-paper-plane").addClass(
									"fa-spinner fa-spin");
							$(".btn-cert-send").find("span").text("발송중");
						},
						complete : function() {
							$(".btn-cert-send").prop("disabled", false);
							$(".btn-cert-send").find(".fa-solid").removeClass(
									"fa-spinner fa-spin").addClass(
									"fa-paper-plane");
							$(".btn-cert-send").find("span").text("보내기");
						},
						success : function(response) {
							certEmail = email;

							var template = $("#cert-template").text();
							var html = $.parseHTML(template);

							$(".email-wrapper").after(html);
						}
					});
				});

		$(document).on(
				"click",
				".btn-cert-check",
				function() {
					var currentEmail = $("[name=adminEmail]").val();
					if (certEmail !== currentEmail) {
						window.alert("이메일을 수정하여 다시 인증해야 합니다");
						$(".cert-wrapper").remove();
						return;
					}

					var certNumber = $(".cert-input").val();
					var regex = /^[0-9]{6}$/;
					if (!regex.test(certNumber)) {
						return;
					}
					$.ajax({
						url : "/rest/cert/check",
						method : "post",
						data : {
							certEmail : certEmail,
							certNumber : certNumber
						},
						success : function(response) {
							if (response == true) {
								$(".cert-wrapper").remove();
								$("[name=adminEmail]").prop("readonly", true);
								$(".btn-cert-send").remove();

								status.adminEmailCheckValid = true;
							} else {
								$(".cert-input").removeClass("success fail")
										.addClass("fail");
								status.adminEmailCheckValid = false;
							}
						}
					});
				});

		// 폼 제출 검사
		$(".check-form").submit(function() {
			$("[name], #password-check").trigger("input").trigger("blur");
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
			<div class="fail-feedback">이메일은 반드시 입력해야 합니다</div>
		</div>
		<div class="row">
			<button type="submit" class="btn btn-positive w-100">등록하기</button>
		</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
