<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .container {
        width: 100%;
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
</style>
<form action="set" method="post" autocomplete="off" >
    <!-- 수정에 필요하지만 보여지면 안되는 번호를 숨김 첨부 -->
    <input type="hidden" name="companyId" value="${companyDto.companyId}">
    
    <div class="container w-400 my-50">
        <div class="row center">
            <h1>업장정보 수정</h1>
        </div>
        <div class="row">
            <label>회사이름</label>
            <input name="companyName" type="text"  class="field w-100" value="${companyDto.companyName}">
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
            <input name="companyPost" type="text" class="field w-100" value="${companyDto.companyPost}" size="6">
  		    <input name="CompanyAddress1" type="text" class="field w-100"  value="${companyDto.companyAddress1}" size="60"> <br>
	 		<input  name="CompanyAddress2" type="text" class="field w-100" value="${companyDto.companyAddress2}" size="60"> <br>
        <div class="row">
            <label>휴일</label>
            <input name="companyHoliday" type="date" class="field w-100" value="${companyDto.companyHoliday}">
        </div>
        
        <div class="row mt-30">
            <button class="btn w-100" type="submit">수정하기</button>
        </div>
    </div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
