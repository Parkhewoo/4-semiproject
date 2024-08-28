
<%@ page language="java" contentType="text/html; charsetf=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
	$(function(){
		//상태 객체
		var status = {
				workerPwValid : false,
			workerPwCheckValid : false,
			ok : function(){
				return this.workerPwValid && this.workerPwCheckValid;
			}
		};
		
		//비밀번호 형식검사
		$("[name=workerPw]").blur(function(){
			var workerPw= $(this).val();
			var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
			status.workerPwValid = regex.test(workerPw);
			$(this).removeClass("success fail").addClass(status.workerPwValid ? "success" : "fail");
		});
		//비밀번호 확인 검사
		$("#password-check").blur(function(){
			var worker = $("[name=workerPw]").val();
			var workerPwCheck = $(this).val();
			status.workerPwCheckValid = workerPw.length > 0 && workerPw == workerPwCheck;
			$(this).removeClass("success fail").addClass(status.workerPwCheckValid ? "success" : "fail");
		});
		//form 검사
		$(".check-form").submit(function(){
			$("[name=workerPw]").trigger("blur");
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
		<input type="hidden" name="workerNo" value="${workerNo}">
	
		<div class="row">
			<label>변경할 비밀번호</label>
			<input type="password" name="workerPw" class="field w-100">
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
