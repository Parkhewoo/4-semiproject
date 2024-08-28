<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 
	메뉴(Navbar)
	- (중요) 템플릿 페이지의 모든 경로는 전부다 절대경로로 사용 
	- 로그인 상태일 때와 비로그인 상태일 때 다르게 표시
	- 로그인 상태 : sessionScope.createdUser != null
-->
<c:choose>
	<c:when test="${sessionScope.createdUser != null}">
		<ul class="menu">
		    <li>
		        <a href="/">홈으로</a>
		    </li>
		    <li>
		        <a href="#">데이터</a>
		        <ul>
		            <li><a href="#">나의 출석률보기</a></li>
		            <li><a href="/admin/worker/list">사원 관리</a></li>

		        </ul>
		    </li>
		    <li>
		        <a href="/sysadmin/home">시스템관리자</a>
		    </li>
		    
		    
		 	<c:choose>
		 		<c:when test="${sessionScope.createdRank == '일반 관리자'}">
		 		 <li>
		        <a href="/qna/write">문의하기</a>
		    </li>
		 		<li class="right-menu">
			    	<a href="/admin/home">관리자메뉴</a>
			    	<ul>
			    	 <li>
			                <a href="/admin/worker/list">사원정보보기</a>
			            </li>
			            <li>
			                <a href="/admin/logout">로그아웃</a>
			            </li>
			        </ul>
			    </li>
		 		</c:when>
		 		<c:otherwise>
		 		<li class="right-menu">
			        <a href="/member/mypage">
			        	${sessionScope.createdUser} 님
					</a>
			        <ul>
			            <li>
			                <a href="/admin/logout">로그아웃</a>
			            </li>
			        </ul>
			    </li>
		 		</c:otherwise>
		 	</c:choose>
		</ul>
	</c:when>
	<c:otherwise>
		<ul class="menu">
		    <li>
		        <a href="/">홈으로</a>
		    </li>

		    <li class="right-menu">
		        <a href="#">메뉴</a>
		        <ul>
		            <li>
		            <a href="/admin/login">관리자 로그인</a>
		            </li>
		            <li>
		            <a href="/worker/login">일반회원 로그인</a>
		            </li>
		            <li>
		                <a href="/admin/join">회원가입</a>
		            </li>
		        </ul>
		    </li>
		</ul>
	</c:otherwise>
</c:choose>