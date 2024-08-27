<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>




<div class="row center">
	<h1>회원 가입 정보 입력</h1>
</div>

<form action="add" method="post" enctype="multipart/form-data">
	<div class="container w-600 my-50">
		<div class="form-group">
			<label for="workerNo">사원번호*</label> <input type="text" id="workerNo"
				name="workerNo" required>
		</div>

		<div class="form-group">
			<label for="workerPw">비밀번호*</label> <input type="password"
				id="workerPw" name="workerPw" required>
		</div>

		<div class="form-group">
			<label for="workerName">사원이름*</label> <input type="text"
				id="workerName" name="workerName" required>
		</div>

		<div class="form-group">
			<label for="workerAttend">출석</label> <input type="number"
				id="workerAttend" name="workerAttend" value="0">
		</div>

		<div class="form-group">
			<label for="workerAbsent">결석</label> <input type="number"
				id="workerAbsent" name="workerAbsent" value="0">
		</div>

		<div class="form-group">
			<label for="workerLate">지각</label> <input type="number"
				id="workerLate" name="workerLate" value="0">
		</div>

		<div class="form-group">
			<label for="workerLeave">조퇴</label> <input type="number"
				id="workerLeave" name="workerLeave" value="0">
		</div>

		<div class="form-group">
			<label for="workerJoin">입사일</label> <input type="date"
				id="workerJoin" name="workerJoin" required>
		</div>

		<div class="form-group">
			<label for="workerRank">등급</label> <input type="text" id="workerRank"
				name="workerRank" required>
		</div>

		<div class="form-group">
			<label for="workerBirthday">생일</label> <input type="date"
				id="workerBirthday" name="workerBirthday">
		</div>

		<div class="form-group">
			<label for="workerContact">연락처</label> <input type="text"
				id="workerContact" name="workerContact">
		</div>

		<div class="form-group">
			<label for="workerEmail">이메일</label> <input type="email"
				id="workerEmail" name="workerEmail" required>
		</div>

		<div class="form-group">
			<label>우편번호</label> 
			<input type="text" name="workerPost">
		 <label>우편번호 찾기</label> 
			<input type="button" onclick="Find()" value="우편번호 찾기">
		</div>
		<div class="form-group">
			<label>도로명 주소</label> 
			<input type="text" name="workerAddress1">
			 <label>상세주소</label>
			 <input type="text" name="workerAddress2">
		</div>

		<div class="form-group">
			<label>프로필 이미지</label> <input type="file" name="attach"
				accept="image/*" class="field w-100">
		</div>

		<div class="row center">
			<img src="https://placehold.co/150?text=NO" width="150" height="150">
		</div>

		<button type="submit" class="btn btn-positive w-100">가입하기</button>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
