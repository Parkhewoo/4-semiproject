<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
	<div class="container w-350 my-50">
		
		<div class="row mt-30">
			<button class="btn btn-positive w-100" onclick="window.location.href='/admin/login'">관리자 로그인</button>
			
		</div>
		
		<div class="row mt-30">
			<button class="btn btn-positive w-100" onclick="window.location.href='/worker/login'">일반 로그인</button>
		</div>
		
</div>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
