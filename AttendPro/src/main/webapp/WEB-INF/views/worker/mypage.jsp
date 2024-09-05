<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    /* 기존 스타일 */
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

    .table-info, .block-list-table, .table-horizontal {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    .table-info th, .table-info td,
    .block-list-table th, .block-list-table td,
    .table-horizontal th, .table-horizontal td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    .table-info th, .block-list-table th, .table-horizontal th {
        background-color: #f4f4f4;
        border-bottom: 2px solid #ddd;
    }

    .table-info tr:last-child td,
    .block-list-table tr:last-child td,
    .table-horizontal tr:last-child td {
        border-bottom: none;
    }

    .info-message, .status-message-negative, .status-message-positive {
        text-align: center;
        font-size: 18px;
        margin: 0;
        padding: 10px;
    }

    .status-admin {
        text-align: center;
        font-size: 18px;
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

    .links {
        text-align: center;
    }

    .links a {
        text-decoration: none;
        color: #3498db;
        font-weight: bold;
        margin: 0 15px;
    }

    .links a:hover {
        text-decoration: underline;
    }

    /* 새로운 스타일 */
    .block-list-table th, .block-list-table td,
    .table-horizontal th, .table-horizontal td {
        width: 33.33%; /* 각 열의 너비를 동일하게 설정 */
        text-align: center; /* 가운데 정렬 */
    }

    .pagination {
        text-align: center;
        margin: 20px 0;
    }

    .pagination a, .pagination strong {
        display: inline-block;
        margin: 0 5px;
        padding: 5px 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        color: #3498db;
        text-decoration: none;
    }

    .pagination a:hover {
        background-color: #f4f4f4;
    }

    .pagination strong {
        font-weight: bold;
        color: #333;
        background-color: #f4f4f4;
    }

    #profileImage {
        border-radius: 50%;
    }

    .btn {
        display: inline-block;
        padding: 10px 20px;
        margin: 0 5px;
        border-radius: 4px;
        text-decoration: none;
        font-weight: bold;
        text-align: center;
        color: #fff;
        background-color: #3498db;
    }


    .btn-neutral:hover {
        background-color: #95a5a6;
    }
    .btn-my {
    background-color: #659ad5;
    color: white;
    border-radius: 0.3em;
    border: none;
}
</style>

<div class="container">
    <h1>${workerDto.workerNo} 님의 개인 정보</h1>

    <!-- 이미지가 존재한다면 이미지를 출력 -->
    <img id="profileImage" src="${pageContext.request.contextPath}/worker/image?workerNo=${workerDto.workerNo}" width="150" height="150">

    <div class="row">
        <table class="table-horizontal table-stripe">
            <tr>
                <th>사원 이름</th>
                <td class="left">${workerDto.workerName}</td>
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
                    ${workerDto.workerPost}
                    ${workerDto.workerAddress1} ${workerDto.workerAddress2}
                </td>
            </tr>
        </table>
    </div>

    <!-- 각종 메뉴를 배치 -->
    <div class="row center">
        <h2>
            <a href="password" class="btn btn-my">비밀번호 변경하기</a>
            <a href="/worker/edit?workerNo=${workerDto.workerNo}" class="btn btn-my ms-10">개인정보 변경하기</a>
        </h2>
    </div>

    <!-- 기존 관리자 상세 페이지 코드 유지 -->
    <!-- 여기에 관리자 상세 페이지 코드를 붙여넣기 -->
    <!-- 기존 코드를 여기에 붙여넣습니다. -->

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

<script>
    
</script>
