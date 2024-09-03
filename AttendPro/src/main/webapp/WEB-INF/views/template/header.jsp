<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <!-- google font cdn .-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <!-- font awesome icon cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <!-- my css -->
    <link rel="stylesheet" type="text/css" href="/css/commons.css">
    <!--<link rel="stylesheet" type="text/css" href="/css/test.css">-->
    
    <style>
    	.profile-wrapper{
    		position:relative;
    		width: 100px;
    		height: 100px;
    	}
    	.profile-wrapper > .user-image{
        	width: 100%;
        	height: 100%; 
        }
        .profile-wrapper > label{
        	background-color: rgba(0, 0, 0, 0.3);
        	position: absolute;
        	top:0;
        	left:0;
        	right:0;
        	bottom:0;
        	border-radius: 50%;
        	justify-content: center;
        	align-items: center;
        	color:white;
/*         	display:flex; */
        	cursor: pointer;
        	
        	display:none;        	
        }
        .profile-wrapper:hover > label{
        	display:flex;
        }    
        
        /* 왼쪽 고정 메뉴 스타일 */
.right-fixed-menu {
    position: fixed;  /* 스크롤을 따라 고정 */
    top: 50%;         /* 화면의 중앙에 위치 */
    right: 0;          /* 화면의 오른쪽 에 붙이기 */
    transform: translateY(-50%); /* 완전히 가운데 정렬 */
    width: 150px;     /* 메뉴 너비 설정 */
    background-color: #fff;  /* 배경색 */
    border: 1px solid #ddd;  /* 테두리 */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    z-index: 1000;    /* 다른 요소보다 위에 위치 */
    text-align: center;  /* 텍스트 가운데 정렬 */
    padding: 10px 0;     /* 메뉴 아이템 간의 간격 */
}

.right-fixed-menu .row {
    margin: 10px 0; /* 메뉴 항목 간의 간격 */
}

.right-fixed-menu .link {
    display: block; /* 블록 요소로 설정 */
    text-decoration: none; /* 링크 밑줄 제거 */
    color: #333; /* 텍스트 색상 */
}

.right-fixed-menu .link:hover {
    background-color: #f5f5f5; /* 호버 시 배경색 변경 */
}
        
    </style>
    
    <!-- moment JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js" ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/locale/ko.min.js" ></script>
    
    <!-- jquery cdn -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- 내가만든 jQuery 라이브러리 -->
    <script src="/js/checkbox.js"></script>
    <script src="/js/confirm-link.js"></script>
    <script src="/js/multipage.js"></script>
 
 <%--   
     <script type="text/javascript"> -->
     	//이미지 선택 태그가 변경된 경우 사용자 이미지를 변경하도록 처리(사원전용)
     	$(function(){
    		$("#change-image").change(function(){
     			//this == 파일선택 태그
    			//파일을 선택하지 않았다면 중단
    			if(this.files.length ==0) return;
    			
     			//전송 데이터 준비
     			var form = new FormData();
   			form.append("attach", this.files[0]);
    			

    			//ajax를 통한 파일 업로드
    			$.ajax({
    				processData:false,
    				contentType:false,
    				url:"/rest/worker/profile",
    				method:"post",
    				data:form,
    				success:function(response){
    					//프로필 이미지 주소를 재설정한다
    					
    					//자바스크립트에서 겹치지 않는 시리얼 번호를 생성하는 코드
    					var uuid = crypto.randomUUID();
    					console.log("uuid", uuid);

     			//ajax를 통한 파일 업로드
     			$.ajax({
     				processData:false,
     				contentType:false,
     				url:"/rest/worker/profile",
     				method:"post",
     				data:form,
     				success:function(response){
     					//프로필 이미지 주소를 재설정한다
  					
     					//자바스크립트에서 겹치지 않는 시리얼 번호를 생성하는 코드
     					var uuid = crypto.randomUUID();
     					console.log("uuid", uuid);

    					
     					$(".user-image")
     						.attr("src", "/admin/worker/mypage?uuid="+uuid);//재설정    					
     				},
     			});
  			
     		});
     	});
     </script> -->
 --%>    
    
    <!-- 홈페이지 크기를 결정하는 외부 영역(main) -->
    <div class="container w-1200">

        <!-- 헤더 영역 -->
        <div class="row my-30 flex-box">
        <a href="/">
            <img src="/images/mainLogo.png" style="width:85px">
        </a>
        <!-- 메뉴 영역 -->
        <div class="my-0 w-100">
			<jsp:include page="/WEB-INF/views/template/menu.jsp"></jsp:include>
		</div>
        </div>
		
		<!-- 컨텐츠 영역 -->
        <div class="row my-0 flex-box" style="min-height: 400px;">
            <div class="w-200 pt-20">
            	<div class="right-fixed-menu">
            	<c:choose>
    <c:when test="${sessionScope.createdUser != null}">
            	
    <c:choose>
     <c:when test="${sessionScope.createdRank == '시스템 관리자'}">
     <div class="row center">
                ${sessionScope.createdUser}<br>
                (${sessionScope.createdRank})
            </div>
            <div class="row center">
                <a href="/sysadmin/list" class="link link-animation">
                    관리자 정보 보기<i class="fa-solid fa-square-arrow-up-right"></i>
                </a>
            </div>
            <div class="row center">
                <a href="/admin/logout" class="link link-animation">
                    로그아웃<i class="fa-solid fa-right-from-bracket"></i>
                </a>
            </div>
     </c:when>
    
        <c:when test="${sessionScope.createdRank == '일반 관리자'}">
            <!-- 일반관리자인 경우 -->
            <div class="row center">
                <a href="/admin/mypage">${sessionScope.createdUser} </a><br>
                (${sessionScope.createdRank})
            </div>
            <div class="row center">
                <a href="/admin/worker/list?adminId=${sessionScope.createdUser}" class="link link-animation">
                    사원정보보기<i class="fa-solid fa-square-arrow-up-right"></i>
                </a>
            </div>
            <div class="row center">
                <a href="/admin/logout" class="link link-animation">
                    로그아웃<i class="fa-solid fa-right-from-bracket"></i>
                </a>
            </div>
        </c:when>
        
        <c:otherwise>
        <div class="row center">
                <a href="/worker/mypage">${sessionScope.createdUser} </a><br>
                (${sessionScope.createdRank})
            </div>
                    <div class="row center">
                <a href="/worker/attendance" class="link link-animation">
                    출근기록 보기<i class="fa-solid fa-poo"></i>
                </a>
            </div>   
                <div class="row center">
                <a href="/worker/logout" class="link link-animation">
                    로그아웃<i class="fa-solid fa-right-from-bracket"></i>
                </a>
            </div>
				</c:otherwise>
            </c:choose>
            </c:when>
        
        
        <c:otherwise>
            <!-- 비로그인 시 -->
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
</div>
             <div style="flex-grow: 1;">
				
		
		
		<!-- 중단(Container) -->
		<div>