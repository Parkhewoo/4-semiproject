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
        height: 1px;
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
    }
    .field-show-container input[type="checkbox"] {
        margin-right: 10px;
    }
    .field-show-container i {
        cursor: pointer;
    }
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
        $('#show-password-toggle').change(function() {
            var inputType = $(this).is(':checked') ? 'text' : 'password';
            $('#currentPw').attr('type', inputType);
            $('#toggle-eye').toggleClass('fa-eye fa-eye-slash');
        });

        $('#show-change-password-toggle').change(function() {
            var inputType = $(this).is(':checked') ? 'text' : 'password';
            $('#changePw, #changePw-check').attr('type', inputType);
            $('#toggle-change-eye').toggleClass('fa-eye fa-eye-slash');
        });

        // 현재 비밀번호 유효성 검사
        $("[name=currentPw]").blur(function() {
            var currentPw = $(this).val();
            $.ajax({
                url: "/worker/checkCurrentPassword",
                method: "POST",
                data: { currentPw: currentPw },
                success: function(response) {
                    var isValid = response === "valid";
                    $("[name=currentPw]").removeClass("success fail")
                                         .addClass(isValid ? "success" : "fail");
                    status.currentPwValid = isValid;
                    if (isValid) {
                        $("#current-pw-success").show();
                        $("#current-pw-fail").hide();
                    } else {
                        $("#current-pw-success").hide();
                        $("#current-pw-fail").show();
                    }
                }
            });
        });

        // 새 비밀번호 유효성 검사
        $("[name=changePw]").blur(function() {
            var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
            var isValid = regex.test($(this).val());
            $(this).removeClass("success fail")
                   .addClass(isValid ? "success" : "fail");
            status.changePwValid = isValid;
            if (isValid) {
                $("#change-pw-success").show();
                $("#change-pw-fail").hide();
            } else {
                $("#change-pw-success").hide();
                $("#change-pw-fail").show();
            }
        });

        // 새 비밀번호 확인 유효성 검사
        $("#changePw-check").blur(function() {
            var isValid = $("[name=changePw]").val() === $(this).val();
            $(this).removeClass("success fail")
                   .addClass(isValid ? "success" : "fail");
            status.changePwCheckValid = isValid;
            if (isValid) {
                $("#change-pw-check-success").show();
                $("#change-pw-check-fail").hide();
            } else {
                $("#change-pw-check-success").hide();
                $("#change-pw-check-fail").show();
            }
        });

        // 폼 제출 시 유효성 검사
        $(".check-form").submit(function(e) {
            e.preventDefault();
            $("[name], #changePw-check").trigger("blur");
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
                <h2>비밀번호 입력</h2>
            </div>
            <div class="field-show-container">
                <label class="ms-20">
                    <input type="checkbox" class="field-show" id="show-password-toggle">
                    <span>표시하기</span>
                </label>
                <i class="fa-solid fa-eye" id="toggle-eye"></i>
            </div>
            <input type="password" name="currentPw" id="currentPw" class="field w-100"
                   placeholder="현재 비밀번호를 입력하세요" required>
            <div id="current-pw-success" class="success-feedback">현재 비밀번호와 일치합니다</div>
            <div id="current-pw-fail" class="fail-feedback">현재 비밀번호와 일치하지 않습니다</div>
            
            <div class="row mt-20">
                <h2>변경할 비밀번호 입력</h2>
            </div>
            <div class="row">
                <div class="field-show-container">
                    <label class="ms-20">
                        <input type="checkbox" class="field-show" id="show-change-password-toggle">
                        <span>표시하기</span>
                    </label>
                    <i class="fa-solid fa-eye" id="toggle-change-eye"></i>
                </div>
                <input type="password" name="changePw" id="changePw" class="field w-100"
                       placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함" required>
                <div id="change-pw-success" class="success-feedback">올바른 형식입니다!</div>
                <div id="change-pw-fail" class="fail-feedback">형식에 맞춰 8~16자로 작성하세요</div>
            </div>
            
            <div class="row mt-20">
                <input type="password" id="changePw-check" name="changePwCheck" class="field w-100"
                       placeholder="변경할 비밀번호 확인" required>
                <div id="change-pw-check-success" class="success-feedback">비밀번호가 일치합니다</div>
                <div id="change-pw-check-fail" class="fail-feedback">비밀번호가 일치하지 않습니다</div>
            </div>
        </div>
        
        <div class="row mt-30">
            <button type="submit" class="btn btn-my">변경하기</button>
        </div>
    </form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
