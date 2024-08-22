<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 제목 -->
<c:choose>
	<c:when test="${isSearch}">
		<h1>사원검색</h1>
	</c:when>
	<c:otherwise>
		<h1>사원목록</h1>
	</c:otherwise>
</c:choose>

<!-- 검색화면 -->
<form action="list" method="get" autocomplete="off">
	<select name="column">
		<option value="admin_id">관리자아이디</option>
		
		<c:choose>
			<c:when test="${column == 'admin_rank'}">
				<option value="admin_rank" selected>관리등급</option>
			</c:when>
			<c:otherwise>
				<option value="admin_rank">관리등급</option>
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${column == 'admin_no'}">
				<option value="admin_no" selected>사업자등록번호</option>
			</c:when>
			<c:otherwise>
				<option value="admin_no">사업자등록번호</option>
			</c:otherwise>
		</c:choose>
	</select>
	<input type="search" name="keyword" value="${keyword}">
	<button>검색</button>
</form>

<!-- 결과 -->

<c:choose>
	<c:when test="${list.isEmpty()}">
		<h2>데이터가 존재하지 않습니다</h2>
	</c:when>
	<c:otherwise>
		<table border="1"width="500">
			<thead>
				<tr>
					<td>관리자아이디</td>
					<td>사업자등록번호</td>
					<td>이메일</td>
					<td>관리등급</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${list}">
				<tr>
					<td>${dto.adminId}</td>
					<td>${dto.adminNo}</td>
					<td>${dto.adminEmail}</td>
					<td>${dto.adminRank}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:otherwise>
</c:choose>
