<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="row center">
	<h1>회원 가입 정보 입력</h1>
</div>
<form action="add" method="post">
<div class="container w-600 my-50">

    사원번호* <input type="text" name="workerNo" required> <br><br>
    비밀번호* <input type="password" name="workerPw" required> <br><br>
    사원이름* <input type="text" name="workerName" required> <br><br>
    출석 <input type="number" name="workerAttend" value="0"> <br><br>
    결석 <input type="number" name="workerAbsent" value="0"> <br><br>
    지각 <input type="number" name="workerLate" value="0"> <br><br>
    조퇴 <input type="number" name="workerLeave" value="0"> <br><br>
    입사일 <input type="date" name="workerJoin" required> <br><br>
    등급 <input type="text" name="workerRank" required> <br><br>
    생일 <input type="date" name="workerBirthday"> <br><br>
    연락처 <input type="text" name="workerContact"> <br><br>
    이메일 <input type="email" name="workerEmail" required> <br><br>
    우편번호 <input type="text" name="workerPost"> <br><br>
    도로명주소 <input type="text" name="workerAddress1"> <br><br>
    상세주소 <input type="text" name="workerAddress2"> <br><br>
    
    <button type="submit">가입하기</button>
</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
