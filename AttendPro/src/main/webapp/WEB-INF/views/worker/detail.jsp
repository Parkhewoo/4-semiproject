<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="row center">
	<h1>사원 상세 정보</h1>
</div>
<c:choose>
    <c:when test="${workerDto == null}">
        <h2>존재하지 않는 사원번호</h2>
    </c:when>
    <c:otherwise>
        <table class="center-table" border="1" width="400">
            <tr>
                <th width="30%">번호</th>
                <td>${workerDto.workerNo}</td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td>${workerDto.workerPw}</td>
            </tr>
            <tr>
                <th>이름</th>
                <td>${workerDto.workerName}</td>
            </tr>
            <tr>
                <th>출석</th>
                <td>${workerDto.workerAttend}</td>
            </tr>
            <tr>
                <th>결석</th>
                <td>${workerDto.workerAbsent}</td>
            </tr>
            <tr>
                <th>지각</th>
                <td>${workerDto.workerLate}</td>
            </tr>
            <tr>
                <th>조퇴</th>
                <td>${workerDto.workerLeave}</td>
            </tr>
            <tr>
                <th>입사일</th>
                <td>${workerDto.workerJoin}</td>
            </tr>
            <tr>
                <th>등급</th>
                <td>${workerDto.workerRank}</td>
            </tr>
            <tr>
                <th>생일</th>
                <td>${workerDto.workerBirthday}</td>
            </tr>
            <tr>
                <th>연락처</th>
                <td>${workerDto.workerContact}</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${workerDto.workerEmail}</td>
            </tr>
            <tr>
                <th>우편번호</th>
                <td>${workerDto.workerPost}</td>
            </tr>
            <tr>
                <th>기본주소</th>
                <td>${workerDto.workerAddress1}</td>
            </tr>
            <tr>
                <th>상세주소</th>
                <td>${workerDto.workerAddress2}</td>
            </tr>
        </table>
    </c:otherwise>
</c:choose>

<!-- 다른 페이지로 이동할 수 있는 링크 -->
<div class="center">
<h2><a href="add">신규 사원 등록</a></h2>
<h2><a href="list">목록으로 이동</a></h2>

<c:if test="${workerDto != null}">
    <h2><a href="edit?workerNo=${workerDto.workerNo}">이 사원 정보 수정</a></h2>
    <h2><a href="delete?workerNo=${workerDto.workerNo}">이 사원 삭제하기</a></h2>
</c:if>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
