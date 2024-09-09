<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/header.jsp"></jsp:include>
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
    
    .center {
        text-align: center;
    }
    .form-container {
        display: flex;
        gap: 10px;
        justify-content: center;
        margin-bottom: 20px;
    }
    .field {
        padding: 8px;
        border-radius: 4px;
        border: 1px solid #ddd;
    }
    .w-22 {
        width: 22%;
    }
    .w-50 {
        width: 50%;
    }
    .btn {
        padding: 8px 15px;
        font-size: 16px;
        color: #fff;
        background-color: #3498db;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn:hover {
        background-color: #2980b9;
    }
    .table {
        width: 100%;
        border-collapse: collapse;
    }
    .table th, .table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    .table th {
        background-color: #f4f4f4;
    }
    .link {
        color: #3498db;
        text-decoration: none;
    }
    .link:hover {
        text-decoration: underline;
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
<!-- 검색화면 -->
<form action="${pageContext.request.contextPath}/list" method="get" autocomplete="off">
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
		<table class="center-table" border="1" width="500">
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
						<a href="${pageContext.request.contextPath}/detail?workerNo=${workerDto.workerNo}">${workerDto.workerName}</a>
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
						<a href="${pageContext.request.contextPath}/add">신규등록</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</c:otherwise>
</c:choose>
</div>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/footer.jsp"></jsp:include>

