<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.join-finish{
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
	
	<div class="join-finish row center">		
		<h2>회원가입이 완료되었습니다!</h2>
	</div>
	<div class="row center">
			<p> 이제부터 AttandPro의 다양한 서비스를<br>
			 자유롭게 이용하실 수 있습니다.
			</p>
	</div>
	<div class="row center">
		<a href="/admin/login" class="btn btn-my">로그인 페이지가기</a>
	</div>
	
</div>	

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>