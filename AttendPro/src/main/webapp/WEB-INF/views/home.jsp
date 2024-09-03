
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!--swiper cdn-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<style>
.btn-my {
	background-color: #659ad5;
	color: white;
	border-radius: 0.3em;
	border: none;
}

.swiper {
	width: 100%;
	height: 300px;
}
 .notice-section {
    width: 50%; /* 섹션이 페이지의 절반을 차지하도록 설정 */
    padding: 10px; /* 패딩 조정 */
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 추가로 시각적 강조 */
    max-height: 500px;
    box-sizing: border-box; /* 패딩과 보더를 포함하여 박스의 전체 크기 계산 */
}

.notice-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px; /* 제목과 항목 사이의 간격 조정 */
}

.notice-header h1 {
    font-size: 25px; /* 제목 폰트 크기 조정 */
    margin: 0;
    font-weight: bold; /* 제목을 두껍게 설정 */
    color: #333; /* 제목 색상 조정 */
}

.more-btn {
    font-size: 25px; /* 버튼 크기 조정 */
    color: #659ad5;
    text-decoration: none; /* 버튼의 밑줄 제거 */
    font-weight: bold;
}

.notice-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px; /* 패딩 추가 */
    border-bottom: none; /* 보더 제거 */
}

.notice-item:last-child {
    border-bottom: none; 
}

.notice-item h2 {
    font-size: 15px; /* 제목 폰트 크기 조정 */
    margin: 0;
    color: #333;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    /* text-decoration: none !important; 이 부분은 제거합니다 */
}

.notice-item a {
    text-decoration: none; /* 링크의 밑줄 제거 */
    color: inherit; /* 링크의 색상을 부모 요소와 동일하게 설정 */
}

.notice-date {
    font-size: 12px; /* 날짜 폰트 크기 조정 */
    color: #888;
    margin-left: 10px;
    padding: 5px; /* 날짜 영역 패딩 추가 */
}


</style>
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

<c:if test="${cookie.noPopup == null}">
	<!-- 모달 관련 코드 -->
	<script type="text/javascript">
	$(function(){
		//x버튼과 닫기버튼 이벤트 처리
		$(".btn-modal-close").click(function(e){
			e.preventDefault();//a 태그 기본이벤트 차단
			$(this).parents(".screen-wrapper").remove();
		});
		//배경(backdrop)을 클릭해도 닫기 처리되도록 구현
		$(".screen-wrapper").click(function(){
			$(this).remove();
		});
		
		//  오늘 하루 안보기				
		$(".btn-modal-nomore").click(function(e){
			e.preventDefault();//a태그 기본이벤트 차단
			
			var btn =this;
			
			$.ajax({
				url:"/rest/cookie/today",
				method:"post",
				data:{
					cookieName:"noPopup"
				},
				success:function(){
					//모달 제거
					$(btn).parents(".screen-wrapper").remove();
				},
			});
			
		});
	});
</script>

	<div class="screen-wrapper flex-core">
		<div class="container w-500"
			style="padding: 20px; background: white; height: 500px; display: flex; flex-direction: column; justify-content: space-between;">

			<div class="row center"
				style="display: grid; grid-template-columns: repeat(2, 200px); grid-template-rows: repeat(2, 200px); gap: 5px; justify-content: center;">
				<!-- 첫 번째 광고 모달 -->
				<div class="ad-modal1" style="width: 200px; height: 200px;">
					<img src="/modal/modal1.jpg" style="width: 100%; height: 100%;">
				</div>
				<!-- 두 번째 광고 모달 -->
				<div class="ad-modal2" style="width: 200px; height: 200px;">
					<img src="/modal/modal7.jpg" style="width: 100%; height: 100%;">
				</div>
				<!-- 세 번째 광고 모달 -->
				<div class="ad-modal3" style="width: 200px; height: 200px;">
					<img src="/modal/modal5.jpg" style="width: 100%; height: 100%;">
				</div>
				<!-- 네 번째 광고 모달 -->
				<div class="ad-modal4" style="width: 200px; height: 200px;">
					<img src="/modal/modal6.jpg" style="width: 100%; height: 100%;">
				</div>
			</div>

			<div class="row flex-box" style="margin-top: auto;">
				<div class="w-50 left">
					<a href="#" class="link link-animation btn-modal-nomore">오늘 하루
						안보기</a>
				</div>
				<div class="w-50 right">
					<a href="#" class="link link-animation btn-modal-close">닫기</a>
				</div>
			</div>

		</div>
	</div>
</c:if>

<c:choose>
	<c:when test="${sessionScope.createdUser != null}">
		<div class="center">
			<h1>${sessionScope.createdUser}님홈페이지방문을환영합니다!</h1>
		</div>
		<!-- 로그인한 경우  -->
		<c:choose>
			<c:when test="${sessionScope.createdRank == '시스템 관리자'}">
				<div class="container w-350 my-50">
					<div class="row center mt-30">
						<a href="sysadmin/list">유저 현황</a>
					</div>
					<div class="row center mt-30">
						<a href="qna/list">Q&A 게시판</a>
					</div>
				</div>
			</c:when>

			<c:when test="${sessionScope.createdRank == '일반 관리자'}">
				<div class="container w-350 my-50">
					<!-- 일반 관리자를 위한 콘텐츠 -->
					<div class="row center mt-30">
						<a href="admin/worker/list">사원 현황(매핑 미완성)</a>
					</div>
					<div class="row center mt-30">
						<a href="admin/company/info?companyId=${sessionScope.createdUser}">내
							업장 정보</a>
					</div>
					<div class="row center mt-30">
						<a href="admin/company/set?companyId=${sessionScope.createdUser}">내
							업장 설정하기</a>
					</div>
				</div>
			</c:when>

			<c:otherwise>
				<!--사원을 위한 콘텐츠 -->
				<div class="container w-350 my-50">

					<div class="row center mt-30">
						<a href="/worker/check">출퇴근 하기</a>
					</div>

					<div class="row center mt-30">
						<a href="/worker/attendance">내 출근기록보기</a>
					</div>

				</div>
			</c:otherwise>
		</c:choose>
	</c:when>

	<c:otherwise>
		<!-- 비로그인시 -->
		<div class="center">
			<h1>홈페이지 방문을 환영합니다 !</h1>
		</div>
		<div class="container w-350 my-50">
			<div class="row mt-30">
				<button class="btn btn-my w-100"
					onclick="window.location.href='/admin/login'">관리자 로그인</button>
			</div>
			<div class="row mt-30">
				<button class="btn btn-my w-100"
					onclick="window.location.href='/worker/login'">사원 로그인</button>
			</div>
		</div>
	</c:otherwise>
</c:choose>
<h1>새 소식</h1>
<div class="notice-section">
    <div class="notice-header">
        <a href="${pageContext.request.contextPath}/notice/list" class="more-btn">
            공지사항 <i class="fa-solid fa-chevron-right"></i>
        </a>
    </div>
    <c:forEach var="notice" items="${noticeList}">
        <div class="notice-item">
            <a href="/notice/detail?noticeNo=${notice.noticeNo}">
                <h2><i class="fa-solid fa-caret-right"></i> ${notice.noticeTitle}</h2>
            </a>
            <span class="notice-date">
                <fmt:formatDate value="${notice.noticeWtime}" pattern="yyyy-MM-dd" />
            </span>
        </div>
    </c:forEach>
</div>


<div class="row flex-box"></div>
<div class="container">
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
					<a href="https://www.naver.com"> <img
						src="images/swipperImage1.jpg"
						style="width: 1120px; height: 220px;">
					</a>
				</div>
				<div class="swiper-slide">
					<a href="https://www.naver.com"> <img
						src="images/swipperImage2.jpg"
						style="width: 1120px; height: 220px;">
					</a>
				</div>
				<div class="swiper-slide">
					<a href="https://www.naver.com"> <img
						src="images/swipperImage3.jpg"
						style="width: 1120px; height: 220px;">
					</a>
				</div>
				<div class="swiper-slide">
					<a href="https://www.naver.com"> <img
						src="images/swipperImage4.jpg"
						style="width: 1120px; height: 220px;">
					</a>
				</div>
				<div class="swiper-slide">
					<a href="https://www.naver.com"> <img
						src="images/swipperImage5.jpg"
						style="width: 1120px; height: 220px;">
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