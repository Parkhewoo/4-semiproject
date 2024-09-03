<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.add-finish{
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
	
	<div class="add-finish row center">		
		<h1>사원 등록 완료!</h1>
	</div>
	<div class="row center">
			<p> 이제부터 AttandPro의 다양한 서비스를<br>
			 자유롭게 이용하실 수 있습니다.
	</div>
	<div class="row center mt-50">
		<a href="/admin/worker/list?workerNo=${workerDto.workerNo}"  class="btn btn-my">사원 목록으로 가기</a>
	</div>
	
</div>	

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>