<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 
  <!--swiper cdn-->
  <link   rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/> 
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
 
 <script type="text/javascript">      
      $(function(){
        //var swiper = new Swiper('선택자', 옵션객체);
        var swiper = new Swiper('.swiper', {
        // Optional parameters
        direction: 'horizontal',//슬라이드의 방향(horizontal/vertical)
        loop: true, //슬라이드 종료지점과 시작지점을 연결
        
        // 페이징 표시를 원할 경우
        pagination: { 
          el: '.swiper-pagination', //적용 대상
          clickalble : true,// 클릭하여 이동 가능
          type : 'bullets', // 디자인 유형(progressbar / bullets/ fraction)
        },

        // Navigation arrows
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
        },

        // And if we need scrollbar
        //scrollbar: {
         // el: '.swiper-scrollbar',//적용대상          
        //},

        //추가로 부여할 수 있는 옵션들
        autoplay: {
          delay : 3000,//자동재생 간격(ms)
          disableOnInteraction:true,//사용자가 제어중일 경우 자동재생 해제
          pauseOnMounseEnter: true,//마우스를 올려둘 경우 자동재생 해제          
        },
        
        //전환효과(effect) 설정
        effect:"slide",//slide/fade/cube/coverflow/flip/cards
        //coverflowEffect: {
          //rotate: 75,
        //},
      });

      });

      document.addEventListener('DOMContentLoaded', function() {
         // 슬라이드 클릭 이벤트 처리
    const slides = document.querySelectorAll('.swiper-slide');
    slides.forEach(slide => {
        slide.addEventListener('click', function() {
            const href = this.getAttribute('data-href');
            if (href) {
                window.location.href = href;
            }
        });
    });
});
</script>

<style>
       .btn-my{ 
        background-color: #659ad5;
        color: white;
        border-radius: 0.3em;
        border: none;
        }   
       
        .swiper {
       width: 100%;
       height: 300px;
     }     
</style>
    
<c:choose>
    <c:when test="${sessionScope.createdUser != null}">
    <div class="center">
     <h1>${sessionScope.createdUser}님 홈페이지 방문을 환영합니다 !</h1>
    </div>
          <!-- 로그인한 경우  -->
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
                <!-- 일반 관리자를 위한 콘텐츠 -->
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
                <!--사원을 위한 콘텐츠 -->
                <div class="container w-350 my-50">
	           
			            <div class="row mt-30">
			            	<a href="/record/check">출퇴근 하기</a>
			            </div>

		            <div class="row mt-30">
		            	<a href="/worker/attendance">내 출근기록보기</a>
		            </div>
		            
	            </div>
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:otherwise>
    	<!-- 비로그인시 -->
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
<div class="container" >
      <div class="row center">
        <h1></h1>
      </div>
      <div class="row">
        
        <!-- Slider main container -->
        <div class="swiper" style="width: 1120px; height: 250px;">
          <!-- Slide가 존재하는 컨테이너 -->
          <div class="swiper-wrapper">
            <!-- Slides -->

            <div class="swiper-slide">
              <a href="https://www.naver.com">
                <img src="images/swipperImage1.jpg" style="width: 1120px; height: 220px;">
              </a>
            </div>
            <div class="swiper-slide">
              <a href="https://www.naver.com">
               <img src="images/swipperImage2.jpg" style="width: 1120px; height: 220px;">
              </a>
            </div>
            <div class="swiper-slide">
              <a href="https://www.naver.com">
                <img src="images/swipperImage3.jpg" style="width: 1120px; height: 220px;">
              </a>
            </div>
            <div class="swiper-slide">
              <a href="https://www.naver.com">
               <img src="images/swipperImage4.jpg" style="width: 1120px; height: 220px;">
              </a>
            </div>
            <div class="swiper-slide">
              <a href="https://www.naver.com">
                <img src="images/swipperImage5.jpg" style="width: 1120px; height: 220px;">
              </a>
            </div>        
          </div>
          <!-- 페이징 관련 영역 -->
          <div class="swiper-pagination"></div>

          <!-- If we need navigation buttons -->
          <div class="swiper-button-prev"></div>
          <div class="swiper-button-next"></div>

          <!-- 하단스크롤바 -->
          <!--<div class="swiper-scrollbar"> </div>-->
        </div>

      </div>
    </div>		


<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>