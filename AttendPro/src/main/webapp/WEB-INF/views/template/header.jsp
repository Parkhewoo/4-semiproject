<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <!-- google font cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <!-- font awesome icon cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <!-- my css -->
    <link rel="stylesheet" type="text/css" href="/css/commons.css">
    <!--<link rel="stylesheet" type="text/css" href="/css/test.css">-->
    <!-- 홈페이지 크기를 결정하는 외부 영역(main) -->
    <div class="container w-1200">

        <!-- 헤더 영역 -->
        <div class="row my-0">
            <div class="w-50">
                <h2 class="center">KH 정보교육원 4조 세미프로젝트</h2>
            </div>
        </div>

        <!-- 메뉴 영역 -->
        <div class="row my-0">
			<jsp:include page="/WEB-INF/views/template/menu.jsp"></jsp:include>
		</div>
		
		<!-- 컨텐츠 영역 -->
        <div class="row my-0 flex-box" style="min-height: 400px;">
            <div class="w-200 pt-20">
            	<c:choose>
					<c:when test="${sessionScope.createdUser != null}">
					 <div class="row center">
		                	${sessionScope.createdUser}
		                	(${sessionScope.createdRank})
		                </div>
		                 <div class="row center">
		                	<a href="/admin/worker/list" class="link link-animation">
		                		사원정보보기<i class="fa-solid fa-square-arrow-up-right"></i>
		                	</a>
		                </div>
					</c:when>
				<c:otherwise>
						<div class="row center">
							<a href="/admin/login" class="link link-animation">
								관리자<i class="fa-solid fa-square-arrow-up-right"></i>
							</a> 로그인
						</div>
						<div class="row center">
							<a href="/worker/login" class="link link-animation">
								일반회원<i class="fa-solid fa-square-arrow-up-right"></i>
							</a> 로그인
						</div>
					</c:otherwise>
					</c:choose>
            </div>
             <div style="flex-grow: 1;">
				
		<hr>
		
		
		<!-- 중단(Container) -->
		<div>