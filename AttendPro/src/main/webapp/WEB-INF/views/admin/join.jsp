<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">

<link rel="stylesheet" type="text/css" href="./commons.css">
<!--<link rel="stylesheet" type="text/css" href="./test.css">-->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="/css/commons.css">

<style>
	.fa-asterisk {
		color:#d63031;
	}
</style>

<script>
        $(function(){
        	var status = {
        			adminIdValid : false, //형식검사
        			adminIdCheckValid : false, //중복검사
        			adminPwValid : false, //형식검사
        			adminPwCheckValid : false, 
        			adminNoValid : false, //형식검사
        			adminEmailValid : false, //형식검사
        			adminEmailCheckValid : false, //이메일 인증검사
        			ok : function(){
        				return this.adminIdValid && this.adminIdCheckValid
        				&& this.adminPwValid && this.adminPwCheckValid
        				&& this.adminNoValid && this.adminEmailValid && this.adminEmailCheckValid;
        			},
        	};
        	//입력창 검사
        	$("[name=adminId]").blur(function(){
        		//아이디에 대한 형식검사
        		var regex = /^[a-z][a-z0-9]{7,19}$/;
        		var adminId = $(this).val();//this.value
        		var isValid = regex.test(adminId);
        		//아이디 중복 검사(형식이 올바른 경우만)
        		if(isValid){
        			$.ajax({
        				url:"/rest/admin/checkId",
        			method:"post",
        			data:{adminId : adminId},
        			success: function(response){
        				if(response){//아이디가 사용 가능한 경우
        					status.adminIdCheckValid = true;
        					$("[name=adminId]").removeClass("success fail fail2")
        														.addClass("success");
        				}
        				else{//아이디가 이미 사용중인 경우
        					status.adminIdCheckValid = false;
        					$("[name=adminId]").removeClass("success fail fail2")
        											.addClass("fail2");
        				}
        			},
       			}),
        	}
        		else{//아이디가 형식에 맞지 않는 경우
        			$("[name=adminId]").removeClass("success fail fail2")
        									.addClass("fail");
        		}
        		status.adminIdValid = isValid;
        	});
        	//비밀번호 형식검사
        	$("[name=adminPw]").blur(function(){
        		var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
        		var isValid = regex.test($(this).val());
        		$(this).removeClass("success fail")
        							.addClass(isValid ? "success" : "fail");
        		status.adminPwValid = isValid;
        	});
        	$("#password-check").blur(function(){
        		var isValid = $("[name=adminPw]").val().length
        							&& $(this).val() == $("[name=adminPw]").val();
        		$(this).removeClass("success fail")
        				.addClass(isValid ? "success" : "fail");
        		status.adminPwCheckValid = isValid;
        	});
        	//사업자 번호 형식검사
        	$("name=adminNo").blur(function(){
        		var regex = /^[0-9]{3}-[0-9]{2}-[0-9]{5}$/;
        		var isValid = $(this).val().length == 0 || regex.test($(this).val());
        		$(this).removeClass("success fail")
        						.addClass(isValid ? "success" : "fail");
        		status.adminNoValid = isValid;
        	});
        	//이메일 형식검사
        	var certEmail;
        	
        	$(".btn-cert-send").click(function(){
        		var email = $("[name=adminEmali]").val();
        		
        		if(email.length == 0){
        			status.adminEmailValid = false;
        			return;
        		}
        		status.adminEmailValid = true;
        		
        		$.ajax({
        			url:"/rest/cert/send",
        			method:"post",
        			data:{certEmail : email},
        			beforeSend: function(){
        			$(".email-wrapper").nextAll(".cert-wrapper").remove();
        			$(".btn-cert-send").prop("disabled", true);
        			$(".btn-cert-send").find(".fa-solid")
        									.removeClass("fa-paper-plane")
        									.addClass("fa-spinner fa-spin");
        			$(".btn-cert-send").find("span").text("발송중");
        			},
        			complete:function(){
        				$(".btn-cert-send").prop("disabled", false);
        				$("btn-cert-send").find(".fa-solid")
        								  .removeClass("fa-spinner fa-spin")
        								  .addClass("fa-paper-plane");
        				$(".btn-cert-send").find("span").text("보내기");
        			},
        			success:function(response){
        				certEmail = email;
        				
        				var template = $("#cert-template").text();
        				var html = $.parseHTML(template);
        				
        				$(".email-wrapper").after(html);
        			},
        		});
        	});
        	$(document).on("click", ".btn-cert-check", function(){
        		var currentEmail = $("[name=adminEmail]").val();
        		if(certEmail != currentEmail){
        			window.alert("이메일을 수정하여 다시 인증해야 합니다");
        			$(".cert-wrapper").remove();
        			return;
        		}
        		
        		var certNumber = $(".cert-input").val();
        		var regex = /^[0-9]{6}$/;
        		if (regex.test(certNumber) == false){
        			return;
        		}
        		$.ajax({
        			url:"/rest/cert/check",
        			method:"post",
        			data: {
        				certEmail : certEmail,
        				certNumber : certNumber
        			},
        			success:function(response){
        				if(response == true){
        					$(".cert-wrapper").remove();
        					$("[name=adminEmail]").prop("readonly", true);
        					$(".btn-cert-send").remove();
        					
        					status.adminEmailCheckValid = true;
        				}
        				else{
        					$(".cert-input").removeClass("success fail").addClass("fail");
        					status.adminEmailCheckValid = false;
        				}
        			},
        		});
        	});
        	//폼 검사
        	$(".check-form").submit(function(){
        		$("[name], #password-check").trigger("input").trigger("blur");
        		return status.ok();
        	});
        });
        </script>

<form action="join" method="post">
	<div class="container w-500 my-50">
		<div class="row center">
			<h1>회원가입</h1>
		</div>
		<div class="row">
			<label>아이디</label> <input name="adminId" type="text"
				class="field w-100" placeholder="영문소문자 시작, 숫자 포함 8~20자">
		</div>
		<div class="row">
			<label>비밀번호</label> <input name="adminPw" type="password"
				class="field w-100" placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함">
		</div>
		<div class="row">
			<label>사업자 번호</label> <input name="adminNo" type="text"
				class="field w-100" placeholder="***-**-*****">
		</div>

		<div class="row">
			<label>이메일</label> <input name="adminEmail" type="text"
				class="field w-100" placeholder="sample@kh.com">
		</div>
		<div class="row">
			<button type="submit" class="btn btn-positive w-100">등록하기</button>
		</div>
	</div>
</form>


<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>