<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<form action="block" method="post" autocomplete="off">
	<input type="hidden" name="blockTarget" value="${param.blockTarget}">
<div class="container w-600 my-50">
	<div class="row center">
		<h1>${param.blockTarget} 차단페이지</h1>
	</div>
		<div class="row">
			<textarea name="blockMemo" placeholder="차단사유" rows="10" class="field w-100"></textarea>
		</div>
		<div class="row">
			<button class="btn btn-negative w-100">차단</button>
		</div>
	</div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>