<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    /* 위의 CSS 스타일을 여기에 포함시키세요 */
    .container {
        width: 80%;
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
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    $(function() {
        var status = {
            currentAdminNoValid: false,
            currentAdminEmailValid: false,
            ok: function() {
                return this.currentAdminNoValid && this.currentAdminEmailValid;
            }
        };

        function validateAdminNo() {
            var regex = /^[0-9]{3}-[0-9]{2}-[0-9]{5}$/;
            var isValid = regex.test($("[name=adminNo]").val());
            $("[name=adminNo]").removeClass("success fail")
                               .addClass(isValid ? "success" : "fail");
            $("[name=adminNo]").siblings(".success-feedback").toggle(isValid);
            $("[name=adminNo]").siblings(".fail-feedback").toggle(!isValid);
            status.currentAdminNoValid = isValid;
        }

        function validateAdminEmail() {
            var regex = /^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$/;
            var isValid = regex.test($("[name=adminEmail]").val());
            $("[name=adminEmail]").removeClass("success fail")
                                  .addClass(isValid ? "success" : "fail");
            $("[name=adminEmail]").siblings(".success-feedback").toggle(isValid);
            $("[name=adminEmail]").siblings(".fail-feedback").toggle(!isValid);
            status.currentAdminEmailValid = isValid;
        }

        $("[name=adminNo]").blur(validateAdminNo);
        $("[name=adminEmail]").blur(validateAdminEmail);

        $("form").submit(function() {
            $("[name]").trigger("blur");
            return status.ok();
        });
    });
</script>

<div class="container">
    <h1>사업주 정보 수정 페이지</h1>
    
    <c:choose>
        <c:when test="${adminDto == null}">
            <div class="info-message">
                <h2>존재하지 않는 사업주</h2>
            </div>
        </c:when>
        <c:otherwise>
            <form action="${pageContext.request.contextPath}/edit" method="post">
                <input type="hidden" name="adminId" value="${adminDto.adminId}">
                <div class="row">
                    <label>사업자 번호*</label>
                    <input type="text" name="adminNo" value="${adminDto.adminNo}" class="field"
                           placeholder="xxx-xx-xxxxx 형식의 10자리 숫자" required>
                    <div class="success-feedback">올바른 형식입니다!</div>
                    <div class="fail-feedback">형식에 맞춰서 작성하세요</div>
                </div>

                <div class="row">
                    <label>이메일*</label>
                    <input type="email" name="adminEmail" value="${adminDto.adminEmail}" class="field" required>
                    <div class="success-feedback">올바른 이메일 형식입니다!</div>
                    <div class="fail-feedback">유효한 이메일 주소를 입력하세요</div>
                </div>

                <div class="row">
                    <label>관리등급</label>
                    <select name="adminRank" class="field">
                        <option value="일반 관리자" <c:if test="${adminDto.adminRank == '일반 관리자'}">selected</c:if>>일반 관리자</option>
                        <option value="시스템 관리자" <c:if test="${adminDto.adminRank == '시스템 관리자'}">selected</c:if>>시스템 관리자</option>
                    </select>
                </div>
                <button type="submit" class="btn">변경하기</button>
            </form>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/footer.jsp"></jsp:include>
