<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.container {
    width: 100%;
    max-width: 1200px; /* Adjust this value to match the design width of your detail page */
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
    width: 50%;
    padding: 8px; /* Increased padding */
    border-radius: 4px;
    border: 1px solid #ddd;
    height: 1px;
    box-sizing: border-box; /* Ensure padding is included in height */
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
</style>

<div class="container">
    <h1>사업주 정보 수정 페이지</h1>
    
    <c:choose>
        <c:when test="${adminDto == null}">
            <div class="info-message">
                <h2>존재하지 않는 사업주</h2>
            </div>
        </c:when>
        <c:otherwise>
            <form action="edit" method="post">
                <!-- adminId를 숨겨진 필드로 추가 -->
                <input type="hidden" name="adminId" value="${adminDto.adminId}">

                <div class="row">
                    <label>사업자 번호*</label>
                    <input type="text" name="adminNo" value="${adminDto.adminNo}" class="field" required>
                </div>

                <div class="row">
                    <label>이메일*</label>
                    <input type="email" name="adminEmail" value="${adminDto.adminEmail}" class="field" required>
                </div>

                <div class="row">
                    <label>관리등급</label>
                    <select name="adminRank" class="field">
                        <option value="일반 관리자" <c:if test="${adminDto.adminRank == '일반 관리자'}">selected</c:if>>일반 관리자</option>
                        <option value="시스템 관리자" <c:if test="${adminDto.adminRank == '시스템 관리자'}">selected</c:if>>시스템 관리자</option>
                    </select>
                </div>
                <button type="submit" class="btn">변경하기</button>
            </form>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>