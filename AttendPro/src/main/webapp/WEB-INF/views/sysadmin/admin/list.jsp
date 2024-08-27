<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .container {
        width: 100%;
        max-width: 1400px;
        margin: 50px auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .row {
        margin-bottom: 15px;
    }

    .field {
        width: 100%;
        padding: 8px;
        border-radius: 4px;
        border: 1px solid #ddd;
        box-sizing: border-box;
    }

    .btn {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 10px 20px;
        margin: 5px;
        font-size: 16px;
        color: #fff;
        background-color: #3498db;
        border: none;
        border-radius: 4px;
        text-align: center;
        text-decoration: none;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .btn:hover {
        background-color: #2980b9;
    }

    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }

    .table-info, .table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    .table-info th, .table-info td, .table th, .table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    .table-info th, .table th {
        background-color: #f4f4f4;
        border-bottom: 2px solid #ddd;
    }

    .table-info tr:last-child td, .table tr:last-child td {
        border-bottom: none;
    }

    .info-message {
        text-align: center;
        font-size: 18px;
        color: #e74c3c;
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

    .block-list-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    .block-list-table th, .block-list-table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    .block-list-table th {
        background-color: #f4f4f4;
        border-bottom: 2px solid #ddd;
    }

    .block-list-table tr:last-child td {
        border-bottom: none;
    }

    /* Flexbox 스타일 추가 */
    .form-container {
        display: flex;
        align-items: center;
        gap: 10px; /* 요소들 사이에 간격 추가 */
    }

    .field {
        flex: 1; /* 입력 필드가 가능한 만큼의 공간을 차지하도록 설정 */
    }

    .field.w-22 {
        flex: 0 1 22%; /* select 박스의 기본 너비 설정 */
    }

    .field.w-50 {
        flex: 0 1 50%; /* 검색 입력 필드의 기본 너비 설정 */
    }

    .btn {
        flex: 0 1 auto; /* 버튼이 기본 크기만큼 차지하도록 설정 */
    }

    .link.link-animation {
        color: #3498db;
        text-decoration: none;
    }

    .link.link-animation:hover {
        text-decoration: underline;
        color: #2980b9;
    }

    .center {
        text-align: center;
    }
</style>

<div class="container">
    <div class="row center">
        <h1>사업주 목록</h1>
        <!-- 검색창 -->
        <form action="list" method="get" autocomplete="off">
            <div class="form-container">
                <select name="column" class="field w-22">
                    <option value="admin_id" <c:if test="${param.column == 'admin_id'}">selected</c:if>>아이디</option>
                    <option value="admin_no" <c:if test="${param.column == 'admin_no'}">selected</c:if>>사업자번호</option>
                    <option value="admin_rank" <c:if test="${param.column == 'admin_rank'}">selected</c:if>>관리등급</option>
                </select>
                <input type="text" name="keyword" value="${keyword}" class="field w-50">
                <button type="submit" class="btn bn-positive">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    검색
                </button>
            </div>
        </form>
    </div>

    <div class="row">
        <table class="table table-border table-hover">
            <thead>
                <tr>
                    <th>업주아이디</th>
                    <th>사업자번호</th>
                    <th>업주이메일</th>
                    <th>상세</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="dto" items="${list}">
                    <tr>
                        <td>${dto.adminId}</td>
                        <td>${dto.adminNo}</td>
                        <td>${dto.adminEmail}</td>
                        <td>
                            <a href="detail?adminId=${dto.adminId}" class="link link-animation">상세</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="row">
    <!-- 네비게이터 불러오는 코드 -->
    <jsp:include page="/WEB-INF/views/template/navigator.jsp"/>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>