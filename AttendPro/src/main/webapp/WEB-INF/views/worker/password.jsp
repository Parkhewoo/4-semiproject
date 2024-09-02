<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.fa-asterisk {
	color: #d63031;
}

.success {
	border: 2px solid green;
}

.fail {
	border: 2px solid red;
}

.btn-my {
	background-color: #659ad5;
	color: white;
	border-radius: 0.3em;
	border: none;
}

.field-show-checkbox {
	display: inline-block;
}

.field-show {
	display: none;
}

.fa-eye, .fa-eye-slash {
	cursor: pointer;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function() {
		var status = {
			currentPwValid : false,
			currentPwCheckValid : false,
			changePwValid : false,
			changePwCheckValid : false,
			ok : function() {
				return this.currentPwValid && this.currentPwCheckValid
						&& this.changePwValid && this.changePwCheckValid;
			}
		};

		function togglePasswordVisibility(checkbox, icons, fields) {
			checkbox.each(function() {
				var $checkbox = $(this);
				var $icons = $(icons);
				var $fields = $(fields);

				// Update password fields and icons based on checkbox state
				function updateVisibility() {
					var type = $checkbox.is(':checked') ? 'text' : 'password';
					$fields.attr('type', type);

					$icons.each(function() {
						if ($checkbox.is(':checked')) {
							$(this).removeClass('fa-eye-slash').addClass(
									'fa-eye');
						} else {
							$(this).removeClass('fa-eye').addClass(
									'fa-eye-slash');
						}
					});
				}

				// Initialize visibility based on the current state of the checkbox
				updateVisibility();

				// Add change event listener to the checkbox
				$checkbox.change(function() {
					updateVisibility();
				});
			});
		}

		// Initialize password visibility toggles
		togglePasswordVisibility($("#showCurrentPw"), ".fa-eye.currentPw",
				"[name=currentPw]");
		togglePasswordVisibility($("#showChangePw"), ".fa-eye.changePw",
				"[name=changePw], #changePw-check");

		$("[name=currentPw]")
				.blur(
						function() {
							var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
							var isValid = regex.test($(this).val());
							$(this).removeClass("success fail").addClass(
									isValid ? "success" : "fail");
							status.currentPwValid = isValid;
						});

		$("[name=changePw]")
				.blur(
						function() {
							var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
							var isValid = regex.test($(this).val());
							$(this).removeClass("success fail").addClass(
									isValid ? "success" : "fail");
							status.changePwValid = isValid;
						});

		$("#changePw-check").blur(
				function() {
					var isValid = $("[name=changePw]").val().length
							&& $(this).val() === $("[name=changePw]").val();
					$(this).removeClass("success fail").addClass(
							isValid ? "success" : "fail");
					status.changePwCheckValid = isValid;
				});

		$(".check-form").submit(function() {
			$("[name], #password-check").trigger("input").trigger("blur");
			return status.ok();
		});

		$(".check-form").on('keydown', 'input, textarea, select', function(e) {
			if (e.key === 'Enter') {
				e.preventDefault();
			}
		});
	});
</script>

<div class="container w-600 my-50">
	<div class="row center">
		<h1>비밀번호 변경 페이지</h1>
	</div>

	<form action="password" method="post" class="check-form">
		<div class="row">
			<div class="page">
				<div class="row">
					<h2>현재 비밀번호 입력</h2>
				</div>
				<div class="row">
					<input type="checkbox" id="showCurrentPw"
						class="field-show-checkbox"> <label for="showCurrentPw">
						<span>표시하기</span> <i class="fa-solid fa-eye currentPw"></i>
					</label> <input type="password" name="currentPw" class="field w-100"
						placeholder="현재 비밀번호" required>
					<div class="success-feedback">올바른 형식입니다!</div>
					<div class="fail-feedback">형식에 맞춰 8~16자로 작성하세요</div>
				</div>
				<div class="row">
					<input type="checkbox" id="showChangePw"
						class="field-show-checkbox"> <label for="showChangePw">
						<span>표시하기</span> <i class="fa-solid fa-eye changePw"></i>
					</label> <input type="password" name="changePw" class="field w-100"
						placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함" required>
					<div class="success-feedback">올바른 형식입니다!</div>
					<div class="fail-feedback">형식에 맞춰 8~16자로 작성하세요</div>

					<input type="password" id="changePw-check" class="field w-100"
						placeholder="확인을 위해 비밀번호 한번 더 입력" required>
					<div class="success-feedback">비밀번호가 일치합니다</div>
					<div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
				</div>
				<div class="row mt-50">
					<div class="flex-box">

						<div class="w-50 right">
							<button type="submit" class="btn btn-my">
								<i class="fa-solid fa-right-to-bracket"></i>변경 완료
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
