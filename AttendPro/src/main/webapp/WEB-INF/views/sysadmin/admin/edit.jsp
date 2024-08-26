<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<div class="container w-350 my-50">
			<h1>사업주 정보 수정페이지</h1>

<form action="edit" method="post">
	<input type="hidden" name="adminId" value="${adminDto.adminId}">

	사업자 번호* <input type="text" name="adminNo" value="${adminDto.adminNo}" required> <br><br>
	이메일* <input type="email" name="adminEmail" value="${adminDto.adminEmail}" required> <br><br>
	등급 
	<select name="memberLevel">
		<option value="일반 관리자" <c:if test="${adminDto.adminRank == '일반 관리자'}">selected</c:if>>일반 관리자</option>
		<option value="시스템 관리자" <c:if test="${adminDto.adminRank == '시스템 관리자'}">selected</c:if>>시스템 관리자</option>
	</select>
	<br><br>
	
	<th>최종로그인</th>
		<td>
			<fmt:formatDate value="${adminDto.adminLogin}" 
									pattern="y년 M월 d일 E H시 m분 s초"/>
			
		</td>
	
	<button>변경하기</button>			
</form>
		
</div>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>