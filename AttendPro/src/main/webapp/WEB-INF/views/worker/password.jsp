<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<style>
 .btn-my {
        background-color: #659ad5;
        color: white;
        border-radius: 0.3em;
        border: none;
        

</style>

<script>
	$(function(){
		var status = {
				currentPwValid: false,				
				currentPwCheckValid: false,
				changePwValid: false,
				changePwCheckValid: false,
				ok: function(){
					
// 					console.log("Checking status.ok():", this.currentPwValid, this.currentPwCheckValid, this.changePwValid, this.changePwCheckValid);
					
					return this.currentPwValid && this.currentPwCheckValid
					&& this.changePwValid && this.changePwCheckValid;					
					}
				};
		$("[name=currentPw]").blur(function(){
			var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
	        var isValid = regex.test($(this).val());
	        $(this).removeClass("success fail")
	               .addClass(isValid ? "success" : "fail");
	        status.currentPwValid = isValid;
// 	        console.log("currentPwValid:", status.currentPwValid);
		});
		$("#currentPw-check").blur(function(){
	        var isValid = $("[name=currentPw]").val().length
	                      && $(this).val() === $("[name=currentPw]").val();
	        $(this).removeClass("success fail")
	               .addClass(isValid ? "success" : "fail");
	        status.currentPwCheckValid = isValid;
// 	        console.log("currentPwCheckValid:", status.currentPwCheckValid);
	    });
		
		$("[name=changePw]").blur(function(){
			var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
	        var isValid = regex.test($(this).val());
	        $(this).removeClass("success fail")
	               .addClass(isValid ? "success" : "fail");
	        status.changePwValid = isValid;
// 	        console.log("changePwValid:", status.changePwValid);
		});
		$("#changePw-check").blur(function(){
	        var isValid = $("[name=changePw]").val().length
	                      && $(this).val() === $("[name=changePw]").val();
	        $(this).removeClass("success fail")
	               .addClass(isValid ? "success" : "fail");
	        status.changePwCheckValid = isValid;
// 	        console.log("changePwCheckValid:", status.changePwCheckValid);
	    });
		
		$(".check-form").submit(function(){
			 $("[name], #password-check").trigger("input").trigger("blur");
// 			 console.log("Form submission status:", result);
		        return status.ok();
		});
	});
</script>

<div class="container w- 600 my-50">
	<div class="row center">
		<h1>비밀번호 변경 페이지</h1>
	</div>
	
	<form action="password" method="post" class="check-form">
		<div class="row">
			<div class="multipage">
			
			<div class="page">
                    <div class="row">
                        <h2>1단계 : 비밀번호 입력</h2>
                    </div>
                    <div class="row">
                        <label>
                            비밀번호
                            <label class="ms-20">
                                <input type="checkbox" class="field-show">
                                <span>표시하기</span>
                            </label>
                            <i class="fa-solid fa-eye"></i>
                        </label>
                        <input type="password" name="currentPw" class="field w-100"
                                placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함" required>
                        <div class="success-feedback">올바른 형식입니다!</div>
                        <div class="fail-feedback">형식에 맞춰 8~16자로 작성하세요</div>
                    </div>
                    <div class="row">
                        <label>비밀번호 확인</label>
                        <input type="password" id="currentPw-check" class="field w-100"
                                placeholder="확인을 위해 비밀번호 한번 더 입력" required>
                        <div class="success-feedback">비밀번호가 일치합니다</div>
                        <div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
                    </div>
                    <div class="row mt-50">
                        <div class="flex-box">
                            <div class="w-50 left">                                
                            </div>
                            <div class="w-50 right">
                                <button type="button" class="btn btn-my btn-next">
                                    다음<i class="fa-solid fa-chevron-right"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="page">
                    <div class="row">
                        <h2>2단계 : 변경할 비밀번호 입력</h2>
                    </div>
                    <div class="row">
                        <label>
                            변경할 비밀번호
                            <label class="ms-20">
                                <input type="checkbox" class="field-show">
                                <span>표시하기</span>
                            </label>
                            <i class="fa-solid fa-eye"></i>
                        </label>
                        <input type="password" name="changePw" class="field w-100"
                                placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함" required>
                        <div class="success-feedback">올바른 형식입니다!</div>
                        <div class="fail-feedback">형식에 맞춰 8~16자로 작성하세요</div>
                    </div>
                    <div class="row">
                        <label>비밀번호 확인</label>
                        <input type="password" id="changePw-check" class="field w-100"
                                placeholder="확인을 위해 비밀번호 한번 더 입력" required>
                        <div class="success-feedback">비밀번호가 일치합니다</div>
                        <div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
                    </div>
                    <div class="row mt-50">
                        <div class="flex-box">
                            <div class="w-50 left">
                                <button type="button" class="btn btn-my btn-prev">
                                    <i class="fa-solid fa-chevron-left"></i>이전
                                </button>
                            </div>
                            <div class="w-50 right">
                               <button type="submit" class="btn btn-my">
                                    <i class="fa-solid fa-right-to-bracket"></i>
                                    변경 완료
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

			</div>
		</div>
	</form>
	
<%-- 	<c:if test="${param.error != null}"> --%>
<!-- 		<h3 style="color:red;">비밀번호가 일치하지 않습니다</h3> -->
<%-- 	</c:if> --%>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>