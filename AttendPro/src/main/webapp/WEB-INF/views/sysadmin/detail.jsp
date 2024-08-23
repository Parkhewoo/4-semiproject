<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container w-500 my-50">
    <div class="header">
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
            <div class="row">
                <h2>사업주 정보</h2>
                <div class="row">
                    <table style="width: 100%; border-collapse: collapse;">
                        <tr>
                            <th>사업주 아이디</th>
                            <td>${dto.adminId}</td>
                        </tr>
                        <tr>
                            <th>사업자번호</th>
                            <td>${dto.adminNo}</td>
                        </tr>
                        <tr>
                            <th>사업주 이메일</th>
                            <td>${dto.adminEmail}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="links">
        <a href="list">사업주 목록</a>
        <a href="delete?adminId=${dto.adminId}">사업주 삭제</a>
        <a href="edit?adminId=${dto.adminId}">정보 변경</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
