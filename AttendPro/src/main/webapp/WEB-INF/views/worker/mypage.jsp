<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w- 900">
	<h1>${workerDto.workerNo} 님의 개인 정보</h1>

	<div class="row">
		<table class="table table-horizontal table-stripe">
		
			<tr>
				<th width="25%">사원 이름</th>
				<td class="left">${workerDto.workerName}</td>
			</tr>
			
			<tr>
				<th>출석</th>
				<td class="left">${workerDto.workerAttend}</td>
			</tr>
			
			<tr>
				<th>결석</th>
				<td class="left">${workerDto.workerAbsent}</td>
			</tr>
			
			<tr>
				<th>지각</th>
				<td class="left">${workerDto.workerLate}</td>
			</tr>
			
			<tr>
				<th>조퇴</th>
				<td class="left">${workerDto.workerLeave}</td>
			</tr>
			
			<tr>
				<th>입사일</th>
				<td class="left">${workerDto.workerJoin}</td>
			</tr>
			
			<tr>
				<th>이메일</th>
				<td class="left">${workerDto.workerEmail}</td>
			</tr>
			
			<tr>
				<th>생년월일</th>
				<td class="left">${workerDto.workerBirthday}</td>
			</tr>
			
			<tr>
				<th>직급</th>
				<td class="left">${workerDto.workerRank}</td>
			</tr>
			
			<tr>
				<th>연락처</th>
				<td class="left">${workerDto.workerContact}</td>
			</tr>
			
			<tr>
				<th>주소</th>
				<td class="left">
					[${workerDto.workerPost}]
					${workerDto.workerAddress1}
					${workerDto.workerAddress2}
				</td>
			</tr>			
			
		</table>
	</div>


	<!-- 각종 메뉴를 배치 -->
	<div class="row">
		<div class="row">
			<h2>
				<a href="password" class="btn btn-neutral">비밀번호 변경하기</a>
				<a href="/admin/worker/edit?workerNo=${workerDto.workerNo}"  class="btn btn-neutral ms-10">개인정보 변경하기</a>			
			</h2>
		</div>
	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    