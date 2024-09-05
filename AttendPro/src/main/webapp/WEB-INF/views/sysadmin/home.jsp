<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<style>
    .container {
        width: 80%;
        max-width: 1200px;
        margin: 50px auto;
        padding: 20px;
    }

    .row {
        margin-bottom: 15px;
        text-align: center;
    }

    .info-message {
        text-align: center;
        font-size: 18px;
        color: #e74c3c;
    }

    .links {
        text-align: center;
    }

    .links a {
        text-decoration: none;
        color: #3498db;
        font-weight: bold;
        margin: 0 15px;
    }

    .links a:hover {
        text-decoration: underline;
    }
</style>

<div class="center">
			<img src="/images/logoVer2.png" style="width: 30%">
		</div>

<div class="container w-800 my-80">

    <div class="row">
        <h2><a href="list" class="link link-animation">사업주 목록</a></h2>
    </div>
    <div class="row">
        <h2><a href="/sysadmin/status" class="link link-animation">데이터베이스 현황</a></h2>
    </div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
