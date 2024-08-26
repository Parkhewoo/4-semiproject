


<%-- <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-500 my-50">
    <div class="row center">
    <h1>사업주목록</h1>
        <!-- 검색창 -->
        <form action="list" method="get" autocomplete="off">
            <input type="text" name="keyword" value="${keyword}" class="field">
            <button type="submit" class="btn bn-positive">
                <i class="fa-solid fa-magnifying-glass"></i>
                검색
            </button>
        </form>
    </div>

    <div class="row">
        <table class="table table-border table-hover">
            <thead>
                <tr>
                    <th>업주아이디</th>
                    <th>사업자번호</th>	
                    <th>업주이메일</th>
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