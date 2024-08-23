<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<div class="container w-350 my-50">
			<h1>시스템관리자페이지</h1>
		<div class="row center">
		<h2><a href="/admin/member/list" class="link link-animation">사업주목록</a></h2>
		</div>
		<div class="row center">
		<h2><a href="detail?adminId=${dto.adminId}" class="link link-animation">상세</a></h2>
		</div>
		
</div>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>