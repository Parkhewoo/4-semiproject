<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="row center">
    <h1>업장 상세 정보</h1>
</div>

<c:choose>
    <c:when test="${companyDto == null}">
        <h2>존재하지 않는 업장입니다</h2>
    </c:when>
    <c:otherwise>
        <table class="center-table" border="1" width="400">
            <tr>
                <th width="30%">번호</th>
                <td>${companyDto.companyId}</td>
            </tr>
            <tr>
                <th width="30%">이름</th>
                <td>${companyDto.companyName}</td>
            </tr>
            <tr>
                <th>출근시간</th>
                <td>${companyDto.companyInTime}</td>
            </tr>
            <tr>
                <th>퇴근시간</th>
                <td>${companyDto.companyOutTime}</td>
            </tr>
            <tr>
                <th>휴일</th>
                <td>${companyDto.companyHoliday}</td>
            </tr>
        </table>
        
        <!-- 다른 페이지로 이동할 수 있는 링크 -->
        <div class="center">
            <c:if test="${companyDto != null}">
                <h2><a href="set?companyId=${companyDto.companyId}">업장정보 수정</a></h2>
            </c:if>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
