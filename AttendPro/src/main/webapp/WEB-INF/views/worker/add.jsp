<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .fa-asterisk {
        color: #d63031;
    }
    .success { border: 2px solid green; }
    .fail { border: 2px solid red; }
    
     .btn-my {
        background-color: #659ad5;
        color: white;
        border-radius: 0.3em;
        border: none;
</style>
   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
 // 문서가 로드될 때 실행되는 이벤트 리스너
    document.addEventListener('DOMContentLoaded', function() {
        var fileInput = document.getElementById('fileInput');
        var profileImage = document.getElementById('profileImage');

        // 기본 이미지 설정
        profileImage.src = "https://placehold.co/150?text=NO";

        fileInput.addEventListener('change', function(e) {
            var file = e.target.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    profileImage.src = e.target.result;
                }
                reader.readAsDataURL(file);
            } else {
                profileImage.src = "https://placehold.co/150?text=NO";
            }
        });

        // 주소 찾기
        window.Find = function() {
            new daum.Postcode({
                oncomplete: function (data) {
                    var addr = '';
                    if (data.userSelectedType === 'R') {
                        addr = data.roadAddress;
                    } else {
                        addr = data.jibunAddress;
                    }
                    document.querySelector("[name=workerPost]").value = data.zonecode;
                    document.querySelector("[name=workerAddress1]").value = addr;
                    document.querySelector("[name=workerAddress2]").focus();
                }
            }).open();
        }

        // 주소 지우기
        window.clearAddress = function() {
            document.querySelector("[name=workerPost]").value = '';
            document.querySelector("[name=workerAddress1]").value = '';
            document.querySelector("[name=workerAddress2]").value = '';
        }

        // 입력 검증을 위한 상태 객체
        var status = {
            workerNameValid: true,
            workerPwValid: false,
            workerPwCheckValid: false,
            workerEmailValid: false,
            workerRankValid: false,
            workerContactValid: true,
            workerAddressValid: true,
            ok: function() {
                return this.workerNameValid && this.workerPwValid
                    && this.workerPwCheckValid && this.workerRankValid
                    && this.workerEmailValid && this.workerContactValid
                    && this.workerAddressValid;
            }
        };

        // 이메일 입력 검증
        $("[name=workerEmail]").blur(function() {
            var regex = /^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$/;
            var isValid = regex.test($(this).val());
            $(this).removeClass("success fail")
                   .addClass(isValid ? "success" : "fail");
            $(".success-feedback, .fail-feedback").hide();

            // 해당 입력 필드의 형제 요소 중 성공 및 실패 피드백만 표시
            $(this).siblings(".success-feedback, .fail-feedback").hide();
            $(this).siblings(isValid ? ".success-feedback" : ".fail-feedback").show();
            status.workerEmailValid = isValid;
        });

        // 전화번호 입력 검증
        $("[name=workerContact]").blur(function() {
            var regex = /^010\d{8}$/;
            var isValid = regex.test($(this).val());
            $(this).removeClass("success fail")
                   .addClass(isValid ? "success" : "fail");

            // 해당 입력 필드의 형제 요소 중 성공 및 실패 피드백만 표시
            $(this).siblings(".success-feedback, .fail-feedback").hide();
            $(this).siblings(isValid ? ".success-feedback" : ".fail-feedback").show();
            status.workerContactValid = isValid;
        });

        // 생년월일 입력 제한
        var workerBirthInput = document.querySelector("[name=workerBirth]");
        workerBirthInput.setAttribute("max", new Date().toISOString().slice(0,10));

        // 각 입력 필드 검증
        $("[name=workerNo]").blur(function() {
            var workerNo = $(this).val();
            $.ajax({
                url: "http://localhost:8080/rest/worker/checkNo",
                method: "post",
                data: { workerNo: workerNo },
                success: function(response) {
                    if (response === true) {
                        status.workerNoCheckValid = true;
                        $("[name=workerNo]").removeClass("fail").addClass("success");
                    } else {
                        status.workerNoCheckValid = false;
                        $("[name=workerNo]").removeClass("success").addClass("fail");
                    }
                }
            });
        });

        $("[name=workerName]").blur(function() {
            var regex = /^[가-힣a-zA-Z0-9]{1,21}$/;
            var isValid = regex.test($(this).val());
            $(this).removeClass("success fail")
                   .addClass(isValid ? "success" : "fail");
            status.workerNameValid = isValid;
        });

        $("[name=workerPw]").blur(function() {
            var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
            var isValid = regex.test($(this).val());
            $(this).removeClass("success fail")
                   .addClass(isValid ? "success" : "fail");
            status.workerPwValid = isValid;
        });

        $("#password-check").blur(function() {
            var isValid = $("[name=workerPw]").val().length
                          && $(this).val() === $("[name=workerPw]").val();
            $(this).removeClass("success fail")
                   .addClass(isValid ? "success" : "fail");
            status.workerPwCheckValid = isValid;
        });

        $("[name=workerRank]").blur(function() {
            var regex = /^(인턴|사원|과장|팀장|사장)$/;
            var isValid = regex.test($(this).val());
            $(this).removeClass("success fail")
                   .addClass(isValid ? "success" : "fail");
            status.workerRankValid = isValid;
        });

        $("[name=workerPost], [name=workerAddress1], [name=workerAddress2]").blur(function() {
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
            // 해당 입력 필드의 형제 요소 중 성공 및 실패 피드백만 표시
            $(this).siblings(".success-feedback, .fail-feedback").hide();
            $(this).siblings(isValid ? ".success-feedback" : ".fail-feedback").show();
            status.workerAddressValid = isValid;
        });

        $(".check-form").submit(function() {
            $("[name], #password-check").trigger("input").trigger("blur");
            return status.ok();
        });

        // ENTER 키 동작 방지 (input, textarea, select 필드에 한정)
        $(".check-form").on('keydown', 'input, textarea, select', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
            }
        });

        // 비밀번호 표시 체크박스 처리
        var passwordInput = document.querySelector("[name=workerPw]");
        var passwordCheckInput = document.getElementById("password-check");
        var passwordShowCheckbox = document.querySelector(".field-show");
        var passwordShowIcon = document.querySelector(".fa-eye");

        // 체크박스 상태에 따라 비밀번호 표시/숨기기
        passwordShowCheckbox.addEventListener("change", function() {
            if (this.checked) {
                passwordInput.type = "text";
                passwordCheckInput.type = "text";
                passwordShowIcon.classList.remove("fa-eye");
                passwordShowIcon.classList.add("fa-eye-slash");
            } else {
                passwordInput.type = "password";
                passwordCheckInput.type = "password";
                passwordShowIcon.classList.remove("fa-eye-slash");
                passwordShowIcon.classList.add("fa-eye");
            }
        });
    });

     
   
</script>

</head>
<body>
   <div class="container w-600 my-50">
    <div class="row center">
        <h1>사원 등록 페이지</h1>
    </div>
    <div class="row">
        <div class="progressbar"><div class="guage"></div></div>
    </div>

    <form class="check-form" action="add" method="post" autocomplete="off" enctype="multipart/form-data">
        <input type="hidden" name="adminId" value="${sessionScope.createdUser}">
        
        <div class="row">
            <div class="multipage">
            	
                <div class="page">
                    <div class="row">
                        <h2>1단계 : 사원번호 입력</h2>
                    </div>
                    <div class="row">
                        <label>사원번호</label>
                        <input type="text" name="workerNo" class="field w-100" required>
                        <div class="success-feedback">사용가능한 번호입니다!</div>
                        <div class="fail-feedback">중복된 사원번호입니다</div>
                    </div>
                    <div class="row mt-50">
                        <div class="flex-box">
                            <div class="w-50 left"></div>
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
					    <label>
					        비밀번호
					        <label class="ms-20">
					            <input type="checkbox" class="field-show">
					            <span>표시하기</span>
					        </label>
					        <i class="fa-solid fa-eye"></i>
					    </label>
					    <input type="password" name="workerPw" class="field w-100"
					            placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함" required>
					    <div class="success-feedback">올바른 형식입니다!</div>
					    <div class="fail-feedback">형식에 맞춰 8~16자로 작성하세요</div>
					</div>
					<div class="row">
					    <label>비밀번호 확인</label>
					    <input type="password" id="password-check" class="field w-100"
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
                                <button type="button" class="btn btn-my btn-next">
                                    다음<i class="fa-solid fa-chevron-right"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="page">
                    <div class="row">
                        <h2>3단계 : 사원 이름 입력</h2>
                    </div>
                    <div class="row">
                        <label>사원 이름</label>
                        <input type="text" name="workerName" class="field w-100" required>
                        <div class="success-feedback">멋진 이름입니다!</div>
                        <div class="fail-feedback">잘못된 형식의 이름입니다</div>
                    </div>
                    <div class="row mt-50">
                        <div class="flex-box">
                            <div class="w-50 left">
                                <button type="button" class="btn btn-my btn-prev">
                                    <i class="fa-solid fa-chevron-left"></i>이전
                                </button>
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
  	      <h2>4단계 : 직급 입력</h2>
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
                <button type="button" class="btn btn-my btn-prev">
                    <i class="fa-solid fa-chevron-left"></i>이전
                </button>
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
					    <h2>5단계 : 이메일 입력</h2>
					</div>
					<div class="row">
					    <label>이메일</label>
					    <input type="email" name="workerEmail" class="field w-100" placeholder="test@kh.com" required>
					    <div class="success-feedback" >올바른 이메일 형식입니다!</div>
					    <div class="fail-feedback" style="display: none;">올바르지 않은 이메일 형식입니다</div>
					</div>
                    <div class="row mt-50">
                        <div class="flex-box">
                            <div class="w-50 left">
                                <button type="button" class="btn btn-my btn-prev">
                                    <i class="fa-solid fa-chevron-left"></i>이전
                                </button>
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
                        <h2>6단계 : 선택정보 입력</h2>
                    </div>
                    <div class="row">
                        <label>연락처(휴대전화번호, - 제외)</label>
                        <input type="text" name="workerContact" class="field w-100" placeholder="010XXXXXXXX">
                        <div class="fail-feedback">입력한 번호가 형식에 맞지 않습니다</div>
                        <div class="success-feedback">올바른 전화번호 형식입니다</div>
                    </div>
                    <div class="row">
                        <label>생년월일</label>
                        <input type="date" name="workerBirth" class="field w-100">
                    </div>
                    <div class="row mt-50">
                        <div class="flex-box">
                            <div class="w-50 left">
                                <button type="button" class="btn btn-my btn-prev">
                                    <i class="fa-solid fa-chevron-left"></i>이전
                                </button>
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
                        <h2>7단계 : 주소 입력</h2>
                    </div>
                    <div class="row">
                        <input type="text" name="workerPost" class="field" placeholder="우편번호" readonly>
                        <button type="button" class="btn btn-my btn-find-address" onclick="Find()">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                        <button type="button" class="btn btn-negative btn-clear-address" onclick="clearAddress()">
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
                                <button type="button" class="btn btn-my btn-prev">
                                    <i class="fa-solid fa-chevron-left"></i>이전
                                </button>
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
                		<h2>8단계 : 프로필 이미지 선택</h2>
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
                                <button type="button" class="btn btn-my btn-prev">
                                    <i class="fa-solid fa-chevron-left"></i>이전
                                </button>
                            </div>
                            <div class="w-50 right">
                                <button type="submit" class="btn btn-my">
                                    <i class="fa-solid fa-right-to-bracket"></i>
                                    사원등록
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    </form>
</div>