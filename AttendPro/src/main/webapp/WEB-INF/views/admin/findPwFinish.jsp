<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.findPw-finish{
		color:#7199d0; 
	}

.btn-my {
	background-color: #659ad5;
	color: white;
	border-radius: 0.3em;
	border: none;
}
</style>

<div class="container w-600 my-50">

	<div class="findPw-finish row center">
		<h1>비밀번호 재설정 링크 발송 완료</h1>
	</div>
	
	<div class="row center">
		<p>이메일을 확인하시고 링크를 눌러 비밀번호를 재설정 하시기 바랍니다</p>
	</div>
	
</div>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/footer.jsp"></jsp:include>