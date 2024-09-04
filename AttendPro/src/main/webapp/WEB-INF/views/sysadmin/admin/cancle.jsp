<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .container {
        width: 80%;
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
        color: white;
        background-color: #3498db;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    
    .btn:hover {
        background-color: #2980b9;
    }
    
    .error-message {
        color: red;
        text-align: center; /* Ensure text is centered */
        margin-bottom: 15px; /* Space between error message and other elements */
    }
</style>


<form action="cancle" method="post" autocomplete="off">
	<input type="hidden" name="blockTarget" value="${param.blockTarget}">
<div class="container w-600 my-50">
	<div class="row center">
		<h1>${param.blockTarget} 차단 해제페이지</h1>
	</div>
	<c:if test="${not empty error}">
		<div class="row center">
			<p style="color: red;">${error}</p>
		</div>
	</c:if>
		<div class="row">	
			<textarea name="blockMemo" placeholder="차단 해제사유" rows="10" class="field w-100"></textarea>
		</div>
		<div class="row">
			<button class="btn w-100">차단해제</button>
		</div>
	</div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>