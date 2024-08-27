<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	 <script type="text/javascript">
        function Find() {
            new daum.Postcode({
                oncomplete: function (data) {
                    var addr = ''; // 주소 변수

                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    document.querySelector("[name=workerPost]").value = data.zonecode;
                    document.querySelector("[name=workerAddress1]").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.querySelector("[name=workerAddress2]").focus();
                }
            }).open();
        }
    </script>

<form action="edit" method="post" autocomplete="off">
	<!-- 수정에 필요하지만 보여지면 안되는 번호를 숨김 첨부 -->
	<input type="hidden" name="workerNo" value="${workerDto.workerNo}">

	<div class="container w-400 my-50">
		<div class="row center">
			<h1>사원 정보 수정</h1>
		</div>
		<div class="row">
			<label>사원명</label> <input name="workerName" type="text" required
				placeholder="(ex) 홍길동" class="field w-100"
				value="${workerDto.workerName}">
		</div>
		<div class="row">
			<label>비번</label> <input name="workerPw" type="password"
				required" class="field w-100" value="${workerDto.workerPw}">
		</div>
		<div class="row">
			<label>입사일</label> <input name="workerJoin" type="date" required
				placeholder="(ex) 2024-01-01" class="field w-100"
				value="${workerDto.workerJoin}">
		</div>
		<div class="row">
			<label>직급</label> <input name="workerRank" type="text" required
				placeholder="(ex) 사원" class="field w-100"
				value="${workerDto.workerRank}">
		</div>
		<div class="row">
			<label>연락처</label> <input name="workerContact" type="text"
				placeholder="(ex) 010-1234-5678" class="field w-100"
				value="${workerDto.workerContact}">
		</div>
		<div class="row">
			<label>이메일</label> <input name="workerEmail" type="email" required
				placeholder="(ex) example@example.com" class="field w-100"
				value="${workerDto.workerEmail}">
		</div>
		<div class="row">
			<label>우편번호</label> <input type="text" name="workerPost">
			<label>우편번호 찾기</label> <input type="button"
				onclick="Find()" value="우편번호 찾기">
		</div>
		<div class="row">
			<label>기본주소</label> <input name="workerAddress1" type="text"
				placeholder="(ex) 서울시 강남구" class="field w-100"
				value="${workerDto.workerAddress1}">
		</div>
		<div class="row">
			<label>상세주소</label> <input name="workerAddress2" type="text"
				placeholder="(ex) 1234번지" class="field w-100"
				value="${workerDto.workerAddress2}">
		</div>
		<div class="row mt-30">
			<button class="btn btn-positive w-100" type="submit">수정하기</button>
		</div>
	</div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
