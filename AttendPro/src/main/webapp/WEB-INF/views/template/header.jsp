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
<%--
					<div class="row center flex-core">
						<div class="profile-wrapper">
							<img src="/admin/worker/myImage" width="50%"
									class="image image-circle image-left user-image">
							<label for="change-image">변경하기</label>
							<input type="file" id="change-image" accept="image/*" 
										style="display:none;">
						</div>
					</div>					
 --%>
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