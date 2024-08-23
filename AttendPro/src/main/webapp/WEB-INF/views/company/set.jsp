<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="edit" method="post" autocomplete="off">
    <!-- 수정에 필요하지만 보여지면 안되는 번호를 숨김 첨부 -->
    <input type="hidden" name="workerNo" value="${workerDto.workerNo}">
    
    <div class="container w-400 my-50">
        <div class="row center">
            <h1>업장정보 수정</h1>
        </div>
        <div class="row">
            <label>회사이름</label>
            <input name="companyName" type="text"  class="field w-100" value="${companyDto.companyName}">
        </div>
        <div class="row">
            <label>출근시간</label>
            <input name="companyInTime" type="time" class="field w-100" value="${companyDto.companyInTime}">
        </div>
        <div class="row">
            <label>퇴근시간</label>
            <input name="companyOutTime" type="time" class="field w-100" value="${companyDto.companyOutTime}">
        </div>
        <div class="row">
            <label>휴일</label>
            <input name="companyHoliday" type="date" class="field w-100" value="${companyDto.companyHoliday}">
        </div>
        
        <div class="row mt-30">
            <button class="btn btn-positive w-100" type="submit">수정하기</button>
        </div>
    </div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
