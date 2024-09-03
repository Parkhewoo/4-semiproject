<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .container {
        width: 100%;
        max-width: 1200px;
        margin: 50px auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .row {
        margin-bottom: 15px;
    }
    .field {
        width: 50%;
        padding: 8px;
        border-radius: 4px;
        border: 1px solid #ddd;
        box-sizing: border-box;
    }
    .btn {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 10px 20px;
        margin: 5px;
        font-size: 16px;
        color: #fff;
        background-color: #3498db;
        border: none;
        border-radius: 4px;
        text-align: center;
        text-decoration: none;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    .btn:hover {
        background-color: #2980b9;
    }
    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    .info-message {
        text-align: center;
        font-size: 18px;
        color: #e74c3c;
    }
    .success-feedback, .fail-feedback {
        display: none;
        font-size: 12px;
        color: #e74c3c;
    }
    .success-feedback {
        color: #2ecc71;
    }
    .success-feedback.show, .fail-feedback.show {
        display: block;
    }
    
    .btn-my {
        background-color: #659ad5;
        color: white;
        border-radius: 0.3em;
        border: none;
    }

    .field-show-container {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
    }
    .field-show-container input[type="checkbox"] {
        margin-right: 10px;
    }
    .field-show-container i {
        cursor: pointer;
        margin-left: 5px;
    }
</style>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
$(function() {
    var status = {
        currentPwValid: false,
        changePwValid: false,
        changePwCheckValid: false,
        ok: function() {
            return this.currentPwValid && this.changePwValid && this.changePwCheckValid;
        }
    };

    // 비밀번호 표시/숨기기 토글
    $('.field-show').change(function() {
        var inputType = $(this).is(':checked') ? 'text' : 'password';
        var $targetInput = $(this).closest('.row').find('input[type="password"], input[type="text"]').not(this);
        $targetInput.attr('type', inputType);
        $(this).siblings('i').toggleClass('fa-eye fa-eye-slash');
    });

    // 현재 비밀번호 유효성 검사
    $("[name=currentPw]").blur(function() {
        var currentPw = $(this).val();
        var $feedback = $(this).siblings('.feedback');
        $.ajax({
            url: "/admin/checkCurrentPassword",
            method: "POST",
            data: { currentPw: currentPw },
            success: function(response) {
                var isValid = response === "valid";
                $feedback.removeClass("success-feedback fail-feedback")
                         .addClass(isValid ? "success-feedback" : "fail-feedback")
                         .text(isValid ? "현재 비밀번호와 일치합니다" : "현재 비밀번호와 일치하지 않습니다")
                         .show();
                status.currentPwValid = isValid;
            }
        });
    });

    // 새 비밀번호 유효성 검사
    $("[name=changePw]").blur(function() {
        var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
        var isValid = regex.test($(this).val());
        var $feedback = $(this).siblings('.feedback');
        $feedback.removeClass("success-feedback fail-feedback")
                 .addClass(isValid ? "success-feedback" : "fail-feedback")
                 .text(isValid ? "올바른 형식입니다!" : "형식에 맞춰 8~16자로 작성하세요")
                 .show();
        status.changePwValid = isValid;
        $("#changePw-check").trigger('blur');  // 비밀번호 확인 필드 재검사
    });

    // 새 비밀번호 확인 유효성 검사
    $("#changePw-check").blur(function() {
        var isValid = $("[name=changePw]").val() === $(this).val();
        var $feedback = $(this).siblings('.feedback');
        $feedback.removeClass("success-feedback fail-feedback")
                 .addClass(isValid ? "success-feedback" : "fail-feedback")
                 .text(isValid ? "비밀번호가 일치합니다" : "비밀번호가 일치하지 않습니다")
                 .show();
        status.changePwCheckValid = isValid;
    });

    // 폼 제출 시 유효성 검사
    $(".check-form").submit(function(e) {
        e.preventDefault();
        $("[name=currentPw], [name=changePw], #changePw-check").trigger("blur");
        if (status.ok()) {
            this.submit();
        } else {
            alert("입력 정보를 다시 확인해주세요.");
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
            <div class="row">
                <h2>현재 비밀번호 입력</h2>
            </div>
            <div class="field-show-container">
                <label>
                    <input type="checkbox" class="field-show">
                    <span>현재 비밀번호 표시하기</span>
                </label>
                <i class="fa-solid fa-eye"></i>
            </div>
            <input type="password" name="currentPw" id="currentPw" class="field w-100"
                   placeholder="현재 비밀번호를 입력하세요" required>
            <div class="feedback"></div>
        </div>
        
        <div class="row mt-20">
            <div class="row">
                <h2>새 비밀번호 입력</h2>
            </div>
            <div class="field-show-container">
                <label>
                    <input type="checkbox" class="field-show">
                    <span>새 비밀번호 표시하기</span>
                </label>
                <i class="fa-solid fa-eye"></i>
            </div>
            <input type="password" name="changePw" id="changePw" class="field w-100"
                   placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함" required>
            <div class="feedback"></div>
        
        
        <div class="row mt-20">
            <input type="password" id="changePw-check" name="changePwCheck" class="field w-100"
                   placeholder="새 비밀번호 확인" required>
            <div class="feedback"></div>
        </div>
        </div>
        <div class="row mt-30">
            <button type="submit" class="btn btn-my">변경하기</button>
        </div>
    </form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>