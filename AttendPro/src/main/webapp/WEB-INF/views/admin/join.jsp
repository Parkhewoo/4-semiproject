
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .row {
        margin-bottom: 15px;
    }

    .btn-my {
        background-color: #659ad5;
        color: white;
        border-radius: 0.3em;
        border: none;
    }

    .row label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #333;
    }

    .field {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    .field:focus {
        border-color: #007bff;
        outline: none;
        box-shadow: 0 0 0 0.2rem rgba(38, 143, 255, 0.25);
    }

    .btn  {
    background-color: #659ad5;
    color: white;
    border-radius: 0.3em;
    border: none;
}

    .btn-positive {
        background-color: #28a745;
    }

    .btn-positive:hover {
        background-color: #218838;
    }

    h1 {
        font-size: 24px;
        margin-bottom: 20px; 
        color: #333;
    }

    .feedback {
        display: none;
        margin-top: 5px;
        font-size: 14px;
    }

    .success-feedback {
        color: #28a745;
    }

    .fail-feedback {
        color: #dc3545;
    }

    .fail2-feedback {
        color: #dc3545;
    }
</style>

<script>
    $(function() {
        var status = {
            adminIdValid: false,
            adminIdCheckValid: false,
            adminPwValid: false,
            adminPwCheckValid: false,
            adminNoValid: false,
            adminEmailValid: false,
            ok: function() {
                return this.adminIdValid && this.adminIdCheckValid
                    && this.adminPwValid && this.adminPwCheckValid
                    && this.adminNoValid && this.adminEmailValid;
            }
        };

        // 아이디 형식 검사
        $("[name=adminId]").blur(function() {
            var regex = /^[a-z][a-z0-9]{7,19}$/;
            var adminId = $(this).val();
            var isValid = regex.test(adminId);

            if (isValid) {
                $.ajax({
                    url: "/rest/admin/checkId",
                    method: "post",
                    data: { adminId: adminId },
                    success: function(response) {
                        if (response) {
                            status.adminIdCheckValid = true;
                            $("[name=adminId]").removeClass("success fail fail2")
                                .addClass("success");
                        } else {
                            status.adminIdCheckValid = false;
                            $("[name=adminId]").removeClass("success fail fail2")
                                .addClass("fail2");
                        }
                    },
                });
            } else {
                $("[name=adminId]").removeClass("success fail fail2")
                    .addClass("fail");
            }
            status.adminIdValid = isValid;
        });

        // 비밀번호 형식 검사
        $("[name=adminPw]").blur(function() {
            var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
            var isValid = regex.test($(this).val());
            $(this).removeClass("success fail").addClass(isValid ? "success" : "fail");
            status.adminPwValid = isValid;
        });

        // 비밀번호 확인 검사
        $("#password-check").blur(function() {
            var isValid = $("[name=adminPw]").val().length
                && $(this).val() == $("[name=adminPw]").val();
            $(this).removeClass("success fail").addClass(isValid ? "success" : "fail");
            status.adminPwCheckValid = isValid;
        });

        // 사업자 번호 형식 검사
        $("[name=adminNo]").blur(function() {
            var regex = /^[0-9]{3}-[0-9]{2}-[0-9]{5}$/;
            var isValid = regex.test($(this).val());
            $(this).removeClass("success fail").addClass(isValid ? "success" : "fail");
            status.adminNoValid = isValid;
        });

        // 이메일 형식 검사
        $("[name=adminEmail]").blur(function() {
            var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
            var isValid = regex.test($(this).val());
            $(this).removeClass("success fail")
                .addClass(isValid ? "success" : "fail");
            status.adminEmailValid = isValid;
        });

        // 폼 제출 검사
        $(".check-form").submit(function() {
            $("[name], #password-check").trigger("blur");
            return status.ok();
        });
    });
    
  //체크박스 처리 모듈
    //- 전체선택 - .check-all
    //- 필수선택 - .check-required-all
    //- 전체항목 - .check-item
    //- 필수항목 - .check-required-item
    $(function(){
        //전체선택
        $(".check-all").change(function(){
            var checked = $(this).prop("checked");//this.checked
            $(".check-item").prop("checked", checked);

            //change를 강제로 발생시켜서 연쇄적인 처리
            $(".check-item").trigger("change");
        });
        $(".check-required-all").change(function(){
            var checked = $(this).prop("checked");//this.checked
            $(".check-required-item").prop("checked", checked);

            //change를 강제로 발생시켜서 연쇄적인 처리
            $(".check-item").trigger("change");
        });
        $(".check-item").change(function(){
            var requiredCount = $(".check-required-item").length;
            var checkRequiredCount = $(".check-required-item:checked").length;
            var checkRequiredAll = requiredCount == checkRequiredCount;

            var allCount = $(".check-item").length;
            var checkAllCount = $(".check-item:checked").length;
            var checkAll = allCount == checkAllCount;

            $(".check-required-all").prop("checked", checkRequiredAll);
            $(".check-all").prop("checked", checkAll);
        });
    });
</script>

<div class="container w-500 my-50">
    <div class="row center">
        <h1>회원가입</h1>
    </div>
    <div class="row">
        <div class="progressbar">
            <div class="guage"></div>
        </div>
    </div>

    <form class="check-form" action="join" method="post" autocomplete="off"
        enctype="multipart/form-data">
        <div class="row">
            <div class="multipage">
            	<div class="page">
            		  <div class="container w-400 my-50">
						    <div class="row">
						        <h1>이용약관 동의</h1>
						    </div>
						    <div class="row">
						        <label>
						            <input type="checkbox" class="check-item check-required-item">
						            <span>(필수) 개인정보 취급방침에 동의합니다</span>
						        </label>
						        <textarea class="field w-100" rows="5" readonly>
개인정보 취급방침
제1조 목적
이 약관은 회사(이하 "회사")가 제공하는 모든 서비스(이하 "서비스")의 이용 조건 및 절차에 관한 사항과 기타 필요한 사항을 규정함을 목적으로 합니다.
						
제2조 개인정보의 수집 및 이용
회사는 서비스 제공을 위해 필요한 최소한의 개인정보만을 수집하며, 수집된 개인정보는 이용자의 동의 없이 목적 외의 용도로 이용하거나 제3자에게 제공되지 않습니다.
						
제3조 개인정보의 보유 및 이용기간
회사는 수집된 개인정보를 수집 및 이용 목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.
						
제4조 이용자의 권리
이용자는 언제든지 개인정보의 열람, 정정, 삭제를 요구할 수 있으며, 회사는 이에 대해 지체 없이 조치하겠습니다.
						        </textarea>
						    </div> 
						    <div class="row">
						        <label>
						            <input type="checkbox" class="check-item check-required-item">
						            <span>(필수) 홈페이지 이용규칙을 준수합니다</span>
						        </label>
						        <textarea class="field w-100" rows="5" readonly>
홈페이지 이용규칙
제1조 목적
이 규칙은 회사가 운영하는 홈페이지(이하 "홈페이지")의 이용 조건 및 절차에 관한 사항과 기타 필요한 사항을 규정함을 목적으로 합니다.
						
제2조 이용자의 의무
이용자는 홈페이지 이용 시 본 규칙 및 관계 법령을 준수해야 하며, 타인의 권리나 명예를 침해하는 행위를 해서는 안 됩니다.
						
제3조 서비스의 제공
회사는 이용자에게 안정적이고 지속적인 서비스를 제공하기 위해 최선을 다하며, 정기 점검 또는 긴급 조치가 필요한 경우 서비스 제공을 일시 중단할 수 있습니다.
						
제4조 서비스의 변경 및 중단
회사는 불가피한 사정으로 인해 서비스의 내용을 변경하거나 중단할 수 있으며, 이 경우 홈페이지를 통해 사전에 공지합니다.
						        </textarea>
						    </div> 
						    <div class="row">
						        <label>
						            <input type="checkbox" class="check-item">
						            <span>(선택) 이벤트성 정보 수신에 동의합니다</span>
						        </label>
						        <textarea class="field w-100" rows="5" readonly>
이벤트성 정보 수신 동의
이용자는 회사가 제공하는 이벤트성 정보(할인 쿠폰, 이벤트 소식 등)를 수신하는 것에 동의할 수 있으며, 동의하지 않아도 서비스 이용에는 영향이 없습니다.
						        </textarea>
						    </div> 
						    <div class="row">
						        <label>
						            <input type="checkbox" class="check-item">
						            <span>(선택) 개인정보의 제 3자 제공에 대해 동의합니다</span>
						        </label>
						        <textarea class="field w-100" rows="5" readonly>
개인정보의 제 3자 제공 동의
회사는 서비스 제공을 위해 이용자의 개인정보를 제3자에게 제공할 수 있으며, 이 경우 제공받는 자, 제공 목적, 제공 항목 등을 사전에 고지하고 동의를 받습니다.
						        </textarea>
						    </div> 
						    <hr>
						    <div class="row">
						        <label>
						            <input type="checkbox" class="check-required-all" id="agreeMust">
						            <span>필수 이용약관에 동의합니다</span>
						        </label>
						    </div> 
						    <div class="row">
						        <label>
						            <input type="checkbox" class="check-all" id="agreeAll">
						            <span>전체 이용약관에 동의합니다</span>
						        </label>
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
            	</div>
                <div class="page">
                    <div class="row">
                        <label>아이디</label>
                        <input name="adminId" type="text" class="field w-100"
                            placeholder="영문소문자 시작, 숫자 포함 8~20자">
                        <div class="success-feedback">올바른 형식입니다!</div>
                        <div class="fail-feedback">형식에 맞춰 8~20자로 작성하세요</div>
                        <div class="fail2-feedback">중복된 아이디입니다</div>
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
                        <label>비밀번호</label>
                        <input name="adminPw" type="password" class="field w-100"
                            placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함">
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
                        <label>사업자 번호</label>
                        <input name="adminNo" type="text" class="field w-100"
                            placeholder="***-**-*****">
                        <div class="success-feedback">올바른 형식입니다</div>
                        <div class="fail-feedback">***-**-***** 형태로 작성하십시오</div>
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
                        <label>이메일</label>
                        <input name="adminEmail" type="text" class="field w-100"
                            placeholder="sample@kh.com">
                        <div class="fail-feedback">형식에 맞춰 작성하십시오</div>
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
                                    등록하기<i class="fa-solid fa-right-to-bracket"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
