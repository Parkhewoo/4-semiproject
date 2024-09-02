<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    /* 컨테이너 설정 */
    .fa-asterisk {
        color: #d63031;
    }
    .container {    
        width: 100%;
        max-width: 1200px;
        margin: 40px auto; /* 상하 여백을 줄여서 중앙 정렬 */
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* 제목 및 행 간격 */
    .row {
        margin-bottom: 20px; /* 제목과 다음 내용 사이의 간격을 넓힘 */
    }

    /* 테이블 스타일링 */
    .table-info, .block-list-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px; /* 테이블과 다음 요소 사이의 간격을 넓힘 */
    }

    .table-info th, .table-info td,
    .block-list-table th, .block-list-table td {
        padding: 12px; /* 셀 내 여백을 약간 넓힘 */
        text-align: status-admin;
        border-bottom: 1px solid #ddd;
        font-size: 16px; /* 폰트 사이즈를 조정 */
    }

    .table-info th, .block-list-table th {
        background-color: #f4f4f4;
        border-bottom: 2px solid #ddd;
        font-size: 18px; /* 헤더 폰트 사이즈를 조정 */
    }

    .table-info tr:last-child td,
    .block-list-table tr:last-child td {
        border-bottom: none;
    }

    /* 메시지 스타일링 */
    .info-message, .status-message-negative, .status-message-positive {
        text-align: center;
        font-size: 16px; /* 메시지 폰트 사이즈 조정 */
        margin: 10px 0; /* 상하 여백 조정 */
        padding: 10px;
    }

    .status-admin {
        text-align: center;
        font-size: 16px; /* 상태 폰트 사이즈 조정 */
        margin: 0;
        padding: 10px;
    }

    .info-message {
        color: #e74c3c;
    }

    .status-message-negative {
        color: #e74c3c;
    }

    .status-message-positive {
        color: #3498db;
    }

    /* 링크 스타일링 */
    .links {
        text-align: center;
        margin-top: 20px; /* 링크와 위 요소 사이의 간격을 넓힘 */
    }

    .links a {
        text-decoration: none;
        color: #3498db;
        font-weight: bold;
        margin: 0 10px; /* 링크 사이 간격 조정 */
        font-size: 16px; /* 링크 폰트 사이즈 조정 */
    }

    .links a:hover {
        text-decoration: underline;
    }
  .success { border: 2px solid green; }
    .fail { border: 2px solid red; }
    
     .btn-my {
        background-color: #659ad5;
        color: white;
        border-radius: 0.3em;
        border: none;
</style>


<div class="container">
	<h1>${workerDto.workerNo} 님의 개인 정보</h1>

	 <!-- 이미지가 존재한다면 이미지를 출력 -->
        <img id="profileImage"  src="image?workerNo=${workerDto.workerNo}" width="150" height="150">
	
	<div class="row">
		<table class="table-info">
		
			<tr>
				<th>사원 이름</th>
				<td class="status-admin">${workerDto.workerName}</td>
			</tr>
			<%--
			<tr>
				<th>출석</th>
				<td class="status-admin">${workerDto.workerAttend}</td>
			</tr>
			
			<tr>
				<th>결석</th>
				<td class="status-admin">${workerDto.workerAbsent}</td>
			</tr>
			
			<tr>
				<th>지각</th>
				<td class="status-admin">${workerDto.workerLate}</td>
			</tr>
			
			<tr>
				<th>조퇴</th>
				<td class="status-admin">${workerDto.workerLeave}</td>
			</tr>
			 --%>
			<tr>
				<th>입사일</th>
				<td class="status-admin">${workerDto.workerJoin}</td>
			</tr>
			
			<tr>
				<th>이메일</th>
				<td class="status-admin">${workerDto.workerEmail}</td>
			</tr>
			
			<tr>
				<th>생년월일</th>
				<td class="status-admin">${workerDto.workerBirthday}</td>
			</tr>
			
			<tr>
				<th>직급</th>
				<td class="status-admin">${workerDto.workerRank}</td>
			</tr>
			
			<tr>
				<th>연락처</th>
				<td class="status-admin">${workerDto.workerContact}</td>
			</tr>
			
			<tr>
				<th>주소</th>
				<td class="status-admin">
					[${workerDto.workerPost}]
					${workerDto.workerAddress1}
					${workerDto.workerAddress2}
				</td>
			</tr>			
			
		</table>
	</div>


	<!-- 각종 메뉴를 배치 -->
	
		<div class="row center">			
			<a href="password" class="btn btn-my">비밀번호 변경하기</a>
			<a href="/admin/worker/edit?workerNo=${workerDto.workerNo}"  class="btn btn-my">개인정보 변경하기</a>	
		</div>
	

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    