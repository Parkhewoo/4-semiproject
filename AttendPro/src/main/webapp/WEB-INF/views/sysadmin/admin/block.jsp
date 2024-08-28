<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .container {
        width: 100%;
        max-width: 1400px;
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
    .field {
        width: 100%;
        padding: 8px;
        border-radius: 4px;
        border: 1px solid #ddd;
        box-sizing: border-box;
    }
    .btn {
        display: block;
        width: 100%;
        padding: 10px;
        font-size: 16px;
        color: #fff;
        background-color: #e74c3c;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn:hover {
        background-color: #c0392b;
    }
</style>


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