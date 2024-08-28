<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
    .fa-asterisk {
        color: #d63031;
    }
    .success { border: 2px solid green; }
    .fail { border: 2px solid red; }
</style>

<script>
$(function(){
    var status = {
        workerNameValid : true,
        workerPwValid : false,
        workerPwCheckValid : false,
        workerEmailValid : false,
        workerRankValid : false,
        workerContactValid : true,
        workerAddressValid : true,
        ok : function(){
            return this.workerNameValid && this.workerPwValid
            && this.workerPwCheckValid && this.workerRankValid
            && this.workerEmailValid && this.workerContactValid
            && this.workerAddressValid;
        }
    };

    $("[name=workerNo]").blur(function() {
        var workerNo = $(this).val();
        $.ajax({
            url: "http://localhost:8080/rest/worker/checkNo",
            method : "post",
            data: { workerNo: workerNo },
            success: function(response) {
                if (response === true) {
                    status.workerNoCheckValid = true;
                    $("[name=workerNo]").removeClass("fail").addClass("success");
                } 
                else {
                    status.workerNoCheckValid = false;
                    $("[name=workerNo]").removeClass("success").addClass("fail");
                }
            }
        });
    });

    $("[name=workerName]").blur(function(){
        var regex = /^[가-힣a-zA-Z0-9]{1,21}$/;
        var isValid = regex.test($(this).val());
        $(this).removeClass("success fail")
               .addClass(isValid ? "success" : "fail");
        status.workerNameValid = isValid;
    });

    $("[name=workerPw]").blur(function(){
        var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
        var isValid = regex.test($(this).val());
        $(this).removeClass("success fail")
               .addClass(isValid ? "success" : "fail");
        status.workerPwValid = isValid;
    });

    $("#password-check").blur(function(){
        var isValid = $("[name=workerPw]").val().length
                      && $(this).val() === $("[name=workerPw]").val();
        $(this).removeClass("success fail")
               .addClass(isValid ? "success" : "fail");
        status.workerPwCheckValid = isValid;
    });

    $("[name=workerRank]").blur(function(){
        var regex = /^(인턴|사원|과장|팀장|사장)$/;
        var isValid = regex.test($(this).val());
        $(this).removeClass("success fail")
               .addClass(isValid ? "success" : "fail");
        status.workerRankValid = isValid;
    });

    $("[name=workerEmail]").blur(function(){
        var isValid = $(this).val().length > 0;
        $(this).removeClass("success fail")
               .addClass(isValid ? "success" : "fail");
        status.workerEmailValid = isValid;
    });

    $("[name=workerContact]").blur(function(){
        var regex = /^010[1-9][0-9]{7}$/;
        var isValid = $(this).val().length == 0 || regex.test($(this).val());
        $(this).removeClass("success fail")
               .addClass(isValid ? "success" : "fail");
        status.workerContactValid = isValid;
    });

    $("[name=workerPost], [name=workerAddress1], [name=workerAddress2]").blur(function(){
        var workerPost = $("[name=workerPost]").val();
        var workerAddress1 = $("[name=workerAddress1]").val();
        var workerAddress2 = $("[name=workerAddress2]").val();
        
        var isEmpty = workerPost.length == 0 
                    && workerAddress1.length == 0 
                    && workerAddress2.length == 0;
        var isFill = workerPost.length > 0
                    && workerAddress1.length > 0
                    && workerAddress2.length > 0;
        var isValid = isEmpty || isFill;
        $("[name=workerPost], [name=workerAddress1], [name=workerAddress2]")
            .removeClass("success fail")
            .addClass(isValid ? "success" : "fail");
        status.workerAddressValid = isValid;
    });

    $(".check-form").submit(function(){
        $("[name], #password-check").trigger("input").trigger("blur");
        return status.ok();
    });

    document.getElementById('fileInput').addEventListener('change', function(event) {
        var file = event.target.files[0]; // 선택한 파일
        var image = document.getElementById('profileImage');
        
        if (file) {
            var reader = new FileReader();
            
            reader.onload = function(e) {
                // 이미지의 data URL을 얻어 이미지 태그의 src 속성에 적용
                image.src = e.target.result;
            }
            
            reader.readAsDataURL(file); // 파일을 data URL로 읽기
        } else {
            // 파일이 선택되지 않았을 때 기본 이미지로 되돌리기
            image.src = "https://placehold.co/150?text=NO";
        }
    });

    // 페이지 로드 시 기본 이미지 설정
    var image = document.getElementById('profileImage');
    image.src = "https://placehold.co/150?text=NO";
});

    // 페이지 로드 시 기본 이미지 설정
    document.addEventListener('DOMContentLoaded', function() {
        var image = document.getElementById('profileImage');
        image.src = "https://placehold.co/150?text=NO";
    });
</script>


<div class="container w-600 my-50">
    <div class="row center">
        <h1>사원정보 수정 페이지</h1>
    </div>
    <div class="row">
        <div class="progressbar"><div class="guage"></div></div>
    </div>

    <form class="check-form" action="edit" method="post" autocomplete="off" enctype="multipart/form-data">
        <input type="hidden" name="adminId" value="${sessionScope.createdUser}">
        
        <div class="row">
            <div class="multipage">
                <input type="hidden" name="workerNo" class="field w-100" value="${ workerDto.workerNo }" required>
                <input type="hidden" name="workerPw" class="field w-100" value="${workerDto.workerPw }"
                                placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함" required>
                <input type="hidden" id="password-check" class="field w-100" value="${workerDto.workerPw}"
                        placeholder="확인을 위해 비밀번호 한번 더 입력" required>
               
                <div class="page">
                    <div class="row">
                        <h2>1단계 : 사원 이름 입력</h2>
                    </div>
                    <div class="row">
                        <label>사원 이름</label>
                        <input type="text" name="workerName" class="field w-100"  value="${workerDto.workerName}" required>
                        <div class="success-feedback">멋진 이름입니다!</div>
                        <div class="fail-feedback">잘못된 형식의 이름입니다</div>
                    </div>
                    <div class="row mt-50">
                        <div class="flex-box">
                            <div class="w-50 left">
                                <button type="button" class="btn btn-neutral btn-prev">
                                    <i class="fa-solid fa-chevron-left"></i>이전
                                </button>
                            </div>
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
                        <h2>2단계 : 직급 입력</h2>
                    </div>
                    <div class="row">
                        <label for="workerRank">직급</label>
                        <select name="workerRank" id="workerRank" class="field w-100" required>
                            <option value="" disabled selected>선택하세요</option>
                            <option value="인턴">인턴</option>
                            <option value="사원">사원</option>
                            <option value="과장">과장</option>
                            <option value="팀장">팀장</option>
                            <option value="사장">사장</option>
                        </select>
                        <div class="fail-feedback">직급은 반드시 선택해야 합니다</div>
                    </div>
                    <div class="row mt-50">
                        <div class="flex-box">
                            <div class="w-50 left">
                                <button type="button" class="btn btn-neutral btn-prev">
                                    <i class="fa-solid fa-chevron-left"></i>이전
                                </button>
                            </div>
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
                        <h2>3단계 : 이메일 입력</h2>
                    </div>
                    <div class="row">
                        <label>이메일</label>
                        <input type="email" name="workerEmail" class="field w-100" placeholder="test@kh.com" required>
                        <div class="fail-feedback">이메일은 반드시 입력해야 합니다</div>
                    </div>
                    <div class="row mt-50">
                        <div class="flex-box">
                            <div class="w-50 left">
                                <button type="button" class="btn btn-neutral btn-prev">
                                    <i class="fa-solid fa-chevron-left"></i>이전
                                </button>
                            </div>
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
                        <h2>4단계 : 선택정보 입력</h2>
                    </div>
                    <div class="row">
                        <label>연락처(휴대전화번호, - 제외)</label>
                        <input type="text" name="workerContact" class="field w-100" placeholder="010XXXXXXXX">
                        <div class="fail-feedback">입력한 번호가 형식에 맞지 않습니다</div>
                    </div>
                    <div class="row">
                        <label>생년월일</label>
                        <input type="text" name="workerBirth" class="field w-100">
                    </div>
                    <div class="row mt-50">
                        <div class="flex-box">
                            <div class="w-50 left">
                                <button type="button" class="btn btn-neutral btn-prev">
                                    <i class="fa-solid fa-chevron-left"></i>이전
                                </button>
                            </div>
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
                        <h2>5단계 : 주소 입력</h2>
                    </div>
                    <div class="row">
                        <input type="text" name="workerPost" class="field" placeholder="우편번호" readonly>
                        <button class="btn btn-neutral btn-find-address">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                        <button class="btn btn-negative btn-clear-address">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>
                    <div class="row">
                        <input type="text" name="workerAddress1" class="field w-100" placeholder="기본주소" readonly>
                    </div>
                    <div class="row">
                        <input type="text" name="workerAddress2" class="field w-100" placeholder="상세주소">
                        <div class="fail-feedback">주소는 비워두거나 모두 입력해야 합니다</div>
                    </div>
                    <div class="row mt-50">
                        <div class="flex-box">
                            <div class="w-50 left">
                                <button type="button" class="btn btn-neutral btn-prev">
                                    <i class="fa-solid fa-chevron-left"></i>이전
                                </button>
                            </div>
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
                <h2>6단계 : 프로필 이미지 선택</h2>
            </div>
            <div class="row">
                <input type="file" id="fileInput" name="attach" accept="image/*" class="field w-100">
            </div>
            <div class="row">
                <img id="profileImage" src="https://placehold.co/150?text=NO" width="150" height="150" alt="Profile Image">
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
                            사원정보 수정
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
