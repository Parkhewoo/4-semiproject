<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
	$(function(){
		var stauts = {
				currentPwValid: false,
				currentPwCheckValid: false,
				changePwValid: false,
				changePwCheckValid: false;
				ok: function(){
					return this.workerPwCheckValid && this.workerPwValid;					
					}
				};
		$("[name=currentPw]").blur(function(){
			var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
	        var isValid = regex.test($(this).val());
	        $(this).removeClass("success fail")
	               .addClass(isValid ? "success" : "fail");
	        status.workerPwValid = isValid;
		});
		$("#currentPw-check").blur(function(){
	        var isValid = $("[name=workerPw]").val().length
	                      && $(this).val() === $("[name=workerPw]").val();
	        $(this).removeClass("success fail")
	               .addClass(isValid ? "success" : "fail");
	        status.workerPwCheckValid = isValid;
	    });
		
		$("[name=changePw]").blur(function(){
			var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
	        var isValid = regex.test($(this).val());
	        $(this).removeClass("success fail")
	               .addClass(isValid ? "success" : "fail");
	        status.workerPwValid = isValid;
		});
		$("#changePw-check").blur(function(){
	        var isValid = $("[name=workerPw]").val().length
	                      && $(this).val() === $("[name=workerPw]").val();
	        $(this).removeClass("success fail")
	               .addClass(isValid ? "success" : "fail");
	        status.workerPwCheckValid = isValid;
	    });
		
		$(".check-form").submit(function(){
			 $("[name], #password-check").trigger("input").trigger("blur");
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
                        <h2>1단계 : 현재 비밀번호 입력</h2>
                    </div>
                    <div class="row">
                        <label>
                           현재 비밀번호
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
                            <div class="w-50 right">
                                <button type="button" class="btn btn-neutral btn-next">
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
                                <button type="button" class="btn btn-neutral btn-prev">
                                    <i class="fa-solid fa-chevron-left"></i>이전
                                </button>
                            </div>
                            <div class="w-50 right">
                               <button type="submit" class="btn btn-positive">
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
	
	<c:if test="${param.error != null}">
		<h3 style="color:red;">비밀번호가 일치하지 않습니다</h3>
	</c:if>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>