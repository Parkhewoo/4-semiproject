<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<div class="container w-500 my-50">
		<div class="row center" >
			<h1>사업주 정보 수정페이지</h1>
		</div>


	<div class="row">
	<label>사업자 번호* </label>
	<input type="text" name="adminNo" value="${adminDto.adminNo}" class="field w-100" required> 
	</div>

	<div class="row">
	<label>이메일* </label>
	<input type="email" name="adminEmail" value="${adminDto.adminEmail}" class="field w-100" required> 
	</div>

	<div class="row">
	<label>사업자 번호* </label>
	<input type="text" name="adminNo" value="${adminDto.adminNo}" class="field w-100" required> 
	</div>
	
	<div class="row">
	<label>이메일* </label>
	<input type="email" name="adminEmail" value="${adminDto.adminEmail}" class="field w-100" required> 
	</div>
	
	<div class="row">
	<label>등급</label> 
	<select name="memberLevel" class="field w-100">
		<option value="일반 관리자" <c:if test="${adminDto.adminRank == '일반 관리자'}">selected</c:if>>일반 관리자</option>
		<option value="시스템 관리자" <c:if test="${adminDto.adminRank == '시스템 관리자'}">selected</c:if>>시스템 관리자</option>
	</select>
	</div><br>
	
	<div class="row">
	<label>최종로그인</label>
		<fmt:formatDate value="${memberDto.memberLogin}" class="field w-100" pattern="y년 M월 d일 E H시 m분 s초"/>
	</div><br>
	<button>변경하기</button>	<div class="btn btn-positive w-100 ">변경하기</div>			
	
	<div class="btn btn-positive w-100 ">변경하기</div>			
		
</div>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>