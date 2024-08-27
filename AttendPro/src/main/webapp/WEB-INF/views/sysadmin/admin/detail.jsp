<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

    .field {
        width: 100%;
        padding: 12px;
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
</style>

<div class="container">
    <h1>사업주 상세페이지</h1>
    
    <c:choose>
        <c:when test="${dto == null}">
            <!-- 없을 때 화면 -->
            <div class="row">
                <h2>존재하지 않는 아이디</h2>
            </div>
        </c:when>
        <c:otherwise>
            <h2>사업주 정보</h2>
            <table class="table-info">
                <tr>
                    <th>사업주 아이디</th>
                    <td>${dto.adminId}</td>
                </tr>
                <tr>
                    <th>사업자 번호</th>
                    <td>${dto.adminNo}</td>
                </tr>
                <tr>
                    <th>관리등급</th>
                    <td>${dto.adminRank}</td>
                </tr>
                <tr>
                    <th>사업주 이메일</th>
                    <td>${dto.adminEmail}</td>
                </tr>
				<tr>
			    <th>최종 로그인</th>
			    <td>
			        <c:choose>
			            <c:when test="${dto.adminLogin != null}">
			                <fmt:formatDate value="${dto.adminLogin}" pattern="yyyy년 MM월 dd일 E요일 HH시 mm분 ss초"/>
			            </c:when>
			            <c:otherwise>
			                데이터가 없습니다
			            </c:otherwise>
			     	  </c:choose>
			   		</td>
				</tr>
            </table>
        </c:otherwise>
    </c:choose>
    
    <!-- 회원의 차단이력을 출력 -->
    <c:choose>
        <c:when test="${blockList.isEmpty()}">
            <p class="info-message">차단이력이 존재하지 않습니다</p>
        </c:when>
        <c:otherwise>
            <table class="block-list-table">
                <thead>
                    <tr>
                        <th>일시</th>
                        <th>구분</th>
                        <th>사유</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="blockDto" items="${blockList}">
                        <tr>
                            <td>
                                <fmt:formatDate value="${blockDto.blockTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </td>
                            <td>${blockDto.blockType}</td>
                            <td>${blockDto.blockMemo}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <div class="links">
        <a href="list">사업주 목록</a>
        <a href="delete?adminId=${dto.adminId}">사업주 삭제</a>
        <a href="edit?adminId=${dto.adminId}">정보 변경</a>
        <a href="block?blockTarget=${dto.adminId}">차단</a>
        <a href="cancle?blockTarget=${dto.adminId}">해제</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>