<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="/css/commons.css">
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
	a {
        text-decoration: none;
        color: black;
        font-weight: bold;
    }
    
</style>
<!-- 제목 -->
<div class="row center">
<c:choose>
	<c:when test="${isSearch}">
		<h1>사원 검색</h1>	
	</c:when>
	<c:otherwise>
		<h1>사원 목록</h1>	
	</c:otherwise>
</c:choose>
</div>

<div class="row right">
		${pageVO.page} / ${pageVO.lastBlock} 페이지
		(${pageVO.beginRow} - ${pageVO.endRow} / ${pageVO.count} 개)
	</div>
<!-- 검색화면 -->
<form action="list" method="get" autocomplete="off">
<div class="row center">
	<select name="column">
		<option value="worker_name">사원명</option>
		
		<c:choose>
			<c:when test="${column == 'worker_no'}">
				<option value="worker_no" selected>사원번호</option>
			</c:when>
			<c:otherwise>
				<option value="worker_no">사원번호</option>
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${column == 'worker_rank'}">
				<option value="worker_rank" selected>직급</option>
			</c:when>
			<c:otherwise>
				<option value="worker_rank">직급</option>
			</c:otherwise>
		</c:choose>
	</select>
	<input type="search" name="keyword" value="${keyword}">
	<button>검색</button>
	</div>
</form>

<!-- 결과 -->
<div class="row center">
<c:choose>
	<c:when test="${list.isEmpty()}">
		<h2>데이터가 존재하지 않습니다</h2>
	</c:when>
	<c:otherwise>
		<table class="table table-border table-stripe table-hover">
			<thead>
				<tr>
					<th>사원명</th>
					<th>사원번호</th>
					<th>직급</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="workerDto" items="${list}">
				<tr>
					<td>
						<a href="detail?workerNo=${workerDto.workerNo}">${workerDto.workerName}</a>
					</td>
					<td>${workerDto.workerNo}</td>
					<td>${workerDto.workerRank}</td>
				</tr>
				</c:forEach>
			</tbody>
			
			<!-- 
				사원등록 페이지로 이동하는 링크 구현
				- rowspan 속성은 칸을 아래로 늘리는 역할
				- colspan 속성은 칸을 우측으로 늘리는 역할
			-->
			<tfoot>
				<tr align="right">
					<td colspan="4">
						<a href="add">신규등록</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</c:otherwise>
</c:choose>
</div>

<div class="row">
		<!-- 네비게이터 불러오는 코드 -->
		<jsp:include page="/WEB-INF/views/template/navigator.jsp"/>
	</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

