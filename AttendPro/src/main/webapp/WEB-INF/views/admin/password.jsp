<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    .fa-eye, .fa-eye-slash {
        cursor: pointer;
    }
    .field {
        width: 100%;
        padding: 0.5em;
        border-radius: 0.3em;
        border: 1px solid #ccc;
    }
    .field-show {
        margin-right: 0.5em;
    }
    .success-feedback, .fail-feedback {
        display: none;
        color: green;
    }
    .fail-feedback {
        color: red;
    }
    .success {
        border-color: green;
    }
    .fail {
        border-color: red;
    }
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    $(function() {
        var status = {
            currentPwValid: false,
            currentPwCheckValid: false,
            changePwValid: false,
            changePwCheckValid: false,
            ok: function() {
                return this.currentPwValid && this.currentPwCheckValid
                    && this.changePwValid && this.changePwCheckValid;
            }
        };

        $('#show-password-toggle').change(function() {
            var inputType = $(this).is(':checked') ? 'text' : 'password';
            $('#currentPw').attr('type', inputType);
            $('#toggle-eye').toggleClass('fa-eye fa-eye-slash');
        });

        $('#show-change-password-toggle').change(function() {
            var inputType = $(this).is(':checked') ? 'text' : 'password';
            $('#changePw').attr('type', inputType);
            $('#toggle-change-eye').toggleClass('fa-eye fa-eye-slash');
        });

        $("[name=currentPw]").blur(function() {
            var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
            var isValid = regex.test($(this).val());
            $(this).removeClass("success fail")
                   .addClass(isValid ? "success" : "fail");
            status.currentPwValid = isValid;
        });

        $("[name=changePw]").blur(function() {
            var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
            var isValid = regex.test($(this).val());
            $(this).removeClass("success fail")
                   .addClass(isValid ? "success" : "fail");
            status.changePwValid = isValid;
        });

        $("#changePw-check").blur(function() {
            var isValid = $("[name=changePw]").val() === $(this).val();
            $(this).removeClass("success fail")
                   .addClass(isValid ? "success" : "fail");
            status.changePwCheckValid = isValid;
        });

        $(".check-form").submit(function() {
            $("[name], #changePw-check").trigger("blur");
            return status.ok();
        });
    });
</script>

<div class="container w-600 my-50">
    <div class="row center">
        <h1>비밀번호 변경 페이지</h1>
    </div>
    
    <form action="password" method="post" class="check-form">
        <div class="row">
            <div class="row">
                <h2>비밀번호 입력</h2>
            </div>
            <label class="ms-20">
                <input type="checkbox" class="field-show" id="show-password-toggle">
                <span>표시하기</span>
            </label>
            <i class="fa-solid fa-eye" id="toggle-eye"></i>
            <input type="password" name="currentPw" id="currentPw" class="field w-100"
                   placeholder="현재 비밀번호를 입력하세요" required>
            <div class="success-feedback">올바른 형식입니다!</div>
            <div class="fail-feedback">형식에 맞춰 8~16자로 작성하세요</div>
            
            <div class="row mt-20">
                <h2>변경할 비밀번호 입력</h2>
            </div>
            <div class="row">
                <label class="ms-20">
                    <input type="checkbox" class="field-show" id="show-change-password-toggle">
                    <span>표시하기</span>
                </label>
                <i class="fa-solid fa-eye" id="toggle-change-eye"></i>
                <input type="password" name="changePw" id="changePw" class="field w-100"
                       placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함" required>
                <div class="success-feedback">올바른 형식입니다!</div>
                <div class="fail-feedback">형식에 맞춰 8~16자로 작성하세요</div>
            </div>
            
            <div class="row mt-20">
                <input type="password" id="changePw-check" class="field w-100"
                       placeholder="확인을 위해 비밀번호 한번 더 입력" required>
                <div class="success-feedback">비밀번호가 일치합니다</div>
                <div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
            </div>
            
            <div class="row mt-50">
                <div class="flex-box">
                    <div class="w-50 right">
                        <button type="submit" class="btn btn-my">
                            <i class="fa-solid fa-right-to-bracket"></i>
                            변경 완료
                        </button>
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
