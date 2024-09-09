<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    /* 통일된 스타일 */
    .container {
        width: 80%; 
        max-width: 1200px; /* 기존 스타일과 동일한 최대 너비 */
        margin: 50px auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .header {
        text-align: center;
        margin-bottom: 50px;
    }

    .table-info {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    .table-info th, .table-info td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    .table-info th {
        background-color: #f4f4f4;
        border-bottom: 2px solid #ddd;
    }

    .table-info tr:last-child td {
        border-bottom: none;
    }

    .links {
        text-align: center;
    }

    .links a {
        text-decoration: none;
        color: #3498db; /* 버튼 텍스트 색상 통일 */
        font-weight: bold;
        margin: 0 15px;
        padding: 10px 20px;
        display: inline-block;  }

    .links a:hover {
        text-decoration: underline;
    }

    .info-message {
        text-align: center;
        font-size: 18px;
        color: #e74c3c;
        margin: 20px 0; /* 여백 추가 */
    }

    img {
        display: block;
        margin: 0 auto;
        border-radius: 8px;
    }
</style>

<div class="container">
    <div class="header">
        <h1>사원 상세 정보</h1>
    </div>
    <c:choose>
        <c:when test="${workerDto == null}">
            <div class="info-message">존재하지 않는 사원번호</div>
        </c:when>
        <c:otherwise>
        
        <!-- 이미지가 존재한다면 이미지를 출력 -->
<img id="profileImage" src="${pageContext.request.contextPath}/worker/image?workerNo=${workerDto.workerNo}" width="150" height="150">
            <table class="table-info">
                <tr>
                    <th>번호</th>
                    <td>${workerDto.workerNo}</td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td>${workerDto.workerName}</td>
                </tr>
                <!-- 비활성화된 부분은 주석으로 남김 -->
                <!-- <tr>
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
                </tr> -->
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
    <div class="links">
        <a href="${pageContext.request.contextPath}/add">사원 등록</a>
        <a href="${pageContext.request.contextPath}/list?adminId=${workerDto.adminId}">사원 목록</a>

        <c:if test="${workerDto != null}">
            <a href="${pageContext.request.contextPath}/edit?workerNo=${workerDto.workerNo}">정보 수정</a>
            <a href="${pageContext.request.contextPath}/delete?workerNo=${workerDto.workerNo}">사원 삭제</a>
            <a href="${pageContext.request.contextPath}/attendance?workerNo=${workerDto.workerNo}">출결 현황</a>
        </c:if>
    </div>
</div>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/footer.jsp"></jsp:include>
