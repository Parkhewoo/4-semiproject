<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 
	<style>
       .btn-my{ 
        background-color: #659ad5;
        color: white;
        border-radius: 0.3em;
        border: none;
        }        
    </style>
    
<c:choose>
    <c:when test="${sessionScope.createdUser != null}">
     <h1>${sessionScope.createdUser}님 홈페이지 방문을 환영합니다 !</h1>
          로그인한 경우 
        <c:choose>
            <c:when test="${sessionScope.createdRank == '시스템 관리자'}">
            <div class="container w-350 my-50">
                <div class="row center">
                	<a href="sysadmin/list">유저 현황</a>
                </div>
                <div class="row center">
                	<a href="qna/list">Q&A 게시판</a>
                </div>
            </div>
            </c:when>

            <c:when test="${sessionScope.createdRank == '일반 관리자'}">
            	<div class="container w-350 my-50">
                일반 관리자를 위한 콘텐츠
	                <div class="row center">
	                <a href="admin/worker/list">사원 현황(매핑 미완성)</a>
	                </div>
	                <div class="row center">
	                <a href="admin/company/info?companyId=${sessionScope.createdUser}">내 업장 정보</a>
	                </div>
	                <div class="row center">
	                <a href="admin/company/set?companyId=${sessionScope.createdUser}">내 업장 설정하기</a>
	                </div>
                </div>
            </c:when>
            
            <c:otherwise>
                사원을 위한 콘텐츠 
                <div class="container w-350 my-50">
	           
			            <div class="row mt-30">
			            	<a href="record/check">출퇴근 하기</a>
			            </div>

		            <div class="row mt-30">
		            	<a href="#">내 출근기록보기</a>
		            </div>
		            
	            </div>
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:otherwise>
    	비로그인시
    	 <h1>홈페이지 방문을 환영합니다 !</h1>
    	<div class="container w-350 my-50">
            <div class="row mt-30">
                <button class="btn btn-my w-100" onclick="window.location.href='/admin/login'">관리자 로그인</button>
            </div>
            <div class="row mt-30">
                <button class="btn btn-my w-100" onclick="window.location.href='/worker/login'">사원 로그인</button>
            </div>
         </div>
    </c:otherwise>
</c:choose>
<h1>새 소식</h1>
<div class="row flex-box">

</div>

		


<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
