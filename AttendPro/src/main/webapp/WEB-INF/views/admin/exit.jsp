<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/header.jsp"></jsp:include>

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
           
            adminPwValid: false,
            adminPwCheckValid: false,
            
            ok: function() {
                return this.adminPwValid && this.adminPwCheckValid;                 
            }
        };

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

        // 폼 제출 검사
        $(".check-form").submit(function() {
            $("[name], #password-check").trigger("blur");
            return status.ok();
        });
    });

    function confirmDelete() {
        return confirm('정말 탈퇴 하시겠습니까?');
    }
</script>

<div class="row center">
	<h1>회원 탈퇴 페이지</h1>
</div>
<form class="check-form" action="exit" method="post">
	 
	 <div class="row center">
         <label>비밀번호</label>
         <input name="adminPw" type="password" class="field w-50 center"
                            placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함">
         <div class="success-feedback">올바른 형식입니다!</div>
         <div class="fail-feedback">형식에 맞춰 8~16자로 작성하세요</div>
     </div>
     
     <div class="row center">
         <label>비밀번호 확인</label>
          <input type="password" id="password-check" class="field w-50 center"
                            placeholder="확인을 위해 비밀번호 한번 더 입력" required>
          <div class="success-feedback">비밀번호가 일치합니다</div>
          <div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
      </div>
	
	<div class="row center mt-50">
		<button type="submit" class="btn btn-my" onclick="return confirmDelete();">회원 탈퇴</button>
	</div>	
</form>



<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/footer.jsp"></jsp:include>