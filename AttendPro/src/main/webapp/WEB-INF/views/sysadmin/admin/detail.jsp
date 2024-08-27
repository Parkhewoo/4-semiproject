<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

.table-info {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.table-info th, .table-info td {
    padding: 12px;
    text-align: left;
}

.table-info th {
    background-color: #f4f4f4;
    border-bottom: 2px solid #ddd;
}

.table-info td {
    border-bottom: 1px solid #ddd;
}

.table-info tr:last-child td {
    border-bottom: none;
}

.links {
    text-align: center;
}

.links a {
    text-decoration: none;
    color: black;
    font-weight: bold;
    margin: 0 15px;
}

.links a:hover {
    text-decoration: underline;
}

.info-message {
    text-align: center;
    font-size: 18px;
    color: #e74c3c;
}

.btn {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 10px 20px;
    margin: 5px;
    font-size: 16px;
    color: #fff;
    background-color: none;
    border: none;
    border-radius: 4px;
    text-align: center;
    text-decoration: none;
    cursor: pointer;
    transition: background-color 0.3s; /* 배경색 변경 시 부드러운 효과 */
}

.btn:hover {
    background-color: lightgray;
}

</style>

<div class="container w-500 my-50">
    <div class="row center">
        <h1>사업주 상세페이지</h1>
    </div>

    <c:choose>
        <c:when test="${dto == null}">
            <!-- 없을 때 화면 -->
            <div class="row">
                <h2>존재하지 않는 아이디</h2>
            </div>
        </c:when>
        <c:otherwise>
        
            <table class="table-info">
                <h2>사업주 정보</h2>
                <tr>
                    <th>사업주 아이디</th>
                    <td>${dto.adminId}</td>
                </tr>
                <tr>
                    <th>사업자 번호</th>
                    <td>${dto.adminNo}</td>
                </tr>
                <tr>
                    <th>사업주 이메일</th>
                    <td>${dto.adminEmail}</td>
                </tr>
                <tr>
                    <th>최종 로그인일시</th>
                    <td>${dto.adminLogin}</td>
                </tr>
            </table>
        </c:otherwise>
    </c:choose>

    <div class="links">
        <a href="list">사업주 목록</a>
        <a href="delete?adminId=${dto.adminId}">사업주 삭제</a>
        <a href="edit?adminId=${dto.adminId}">정보 변경</a>
        <a href="block?blockTarget=${dto.adminId}">차단</a>
        <a href="cancel?blockTarget=${dto.adminId}">해제</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>