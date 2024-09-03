<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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

<div class="container w-600 my-50">
	<div class="row center">
		<h1>등록완료</h1>
	</div>
	<div class="row center">
		<a href="/admin/worker/list?adminId=${sessionScope.createdUser}">목록으로돌아가기</a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>