<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="row center">
	<h1>업장 상세 정보</h1>
</div>
<c:choose>
    <c:when test="${companyDto == null}">
        <h2>존재하지 않는 업장이름</h2>
    </c:when>
    <c:otherwise>
        <table class="center-table" border="1" width="400">
        	<tr>
                <th width="30%">번호</th>
                <td>${CompanyDto.companyId}</td>
            </tr>
            <tr>
                <th width="30%">이름</th>
                <td>${CompanyDto.companyName}</td>
            </tr>
            <tr>
                <th>출근시간</th>
                <td>${CompanyDto.companyInTime}</td>
            </tr>
            <tr>
                <th>퇴근시간</th>
                <td>${CompanyDto.companyOutTime}</td>
            </tr>
            <tr>
                <th>출석</th>
                <td>${CompanyDto.companyHoliday}</td>
            </tr>
        </table>
    </c:otherwise>
</c:choose>

<!-- 다른 페이지로 이동할 수 있는 링크 -->
<div class="center">
<c:if test="${CompanyDto != null}">
    <h2><a href="edit?companyId=${companyDto.adminNo}">업장 정보 수정</a></h2>
</c:if>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
