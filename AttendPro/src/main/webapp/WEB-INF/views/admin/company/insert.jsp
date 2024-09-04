<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
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
    .center {
        text-align: center;
    }
    .form-container {
        display: flex;
        gap: 10px;
        justify-content: center;
        margin-bottom: 20px;
    }
    .field {
        padding: 8px;
        border-radius: 4px;
        border: 1px solid #ddd;
    }
    .w-22 {
        width: 22%;
    }
    .w-50 {
        width: 50%;
    }
    .btn {
        padding: 8px 15px;
        font-size: 16px;
        color: #fff;
        background-color: #3498db;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn:hover {
        background-color: #2980b9;
    }
    .table {
        width: 100%;
        border-collapse: collapse;
    }
    .table th, .table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    .table th {
        background-color: #f4f4f4;
    }
    .link {
        color: #3498db;
        text-decoration: none;
    }
    .link:hover {
        text-decoration: underline;
    }
    .input-group {
        display: flex;
        gap: 10px;
        align-items: center;
    }
    .btn-my {
        padding: 8px 15px;
        font-size: 16px;
        color: #fff;
        background-color: #3498db;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn-my:hover {
        background-color: #2980b9;
    }
</style>

  <!-- 기존의 head 내용 -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    function openPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 우편번호와 주소 필드를 업데이트
                document.getElementById('post').value = data.zonecode;
                document.getElementById('address1').value = data.address;
                // 상세 주소 필드로 포커스를 이동
                document.getElementById('address2').focus();
            }
        }).open();
    }
    </script>
</head>

<form action="insert" method="post" autocomplete="off">
    <!-- companyId는 기본적으로 입력 폼에서 제공되지 않으므로 새로운 CompanyDto 객체에 대해 빈 값으로 처리됩니다 -->
    <input type="hidden" name="companyId" value="${sessionScope.createdUser}">
    
    <div class="container w-400 my-50">
        <div class="row center">
            <h1>업장정보 등록</h1>
        </div>
        <div class="row">
            <label>회사이름</label>
            <input name="companyName" type="text" class="field w-100" value="${companyDto.companyName}">
        </div>
        <div class="row">
            <label>대표자명</label>
            <input name="companyCeo" type="text" class="field w-100" value="${companyDto.companyCeo}">
        </div>        
        <div class="row">
            <label>출근시간</label>
            <input name="companyIn" type="time" class="field w-100" value="${companyDto.companyIn}">
        </div>
        <div class="row">
            <label>퇴근시간</label>
            <input name="companyOut" type="time" class="field w-100" value="${companyDto.companyOut}">
        </div>
        <div class="row">
            <label>주소</label>
            <div class="input-group">
                <input type="text" id="post" name="companyPost" class="field w-22" placeholder="우편번호" value="${companyDto.companyPost}" readonly />
                <button type="button" class="btn-my" onclick="openPostcode()">우편번호 검색</button>
            </div>
        </div>
        <div class="row">
            <input type="text" id="address1" name="companyAddress1" class="field w-50" placeholder="주소" value="${companyDto.companyAddress1}" readonly />
        </div>
        <div class="row">
            <input type="text" id="address2" name="companyAddress2" class="field w-50" placeholder="상세 주소" value="${companyDto.companyAddress2}" />
        </div>
<!--         <div class="row"> -->
<!--         	<label>휴일</label> -->
<%--       	 	 <input name="holidayDate" type="date" class="field w-100" value="${holidayDto.holidayDate}"> --%>
<!--    		</div> -->
        <div class="row mt-30">
            <button class="btn w-100" type="submit">등록하기</button>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
