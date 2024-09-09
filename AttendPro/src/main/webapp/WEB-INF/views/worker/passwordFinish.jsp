<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.password-finish{
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

	<div class="password-finish row center">
		<h1>비밀번호 변경 완료</h1>
	</div>
	
	<div class="row center">
			<p> 변경 된 비밀번호로 로그인 해주세요.</p>			 
	</div>
	
	<div class="row center mt-50">
		<h2><a href="${pageContext.request.contextPath}/"  class="btn btn-my">메인페이지로 이동</a></h2>
	</div>
	
</div>
	
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/footer.jsp"></jsp:include>