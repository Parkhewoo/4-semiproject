<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.btn-my {
	background-color: #659ad5;
	color: white;
	border-radius: 0.3em;
	border: none;
}

.success-message {
	display: none;
	color: green;
	margin-top: 10px;
	position: fixed; /* 화면 고정 위치 */
	top: 50%; /* 화면 중앙 상단 위치 */
	left: 50%; /* 화면 중앙 왼쪽 위치 */
	color: green;
	margin-top: 10px;
	transform: translate(-50%, -50%); /* 중앙 정렬 */
	background-color: rgba(0, 0, 0, 0.4); /* 성공 색상, 투명도 0.9 */
	color: white;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	font-size: 16px;
	z-index: 1000; /* 다른 요소 위에 표시 */
}

</style>

<script>
	$(function() {
		var createdUser = "${sessionScope.createdUser}";

		function showSuccessMessage(message) {
			$(".success-message").text(message).fadeIn(300).delay(1000)
					.fadeOut(300);
		}

		// 퇴근 여부 확인
		$.ajax({
			url : "${pageContext.request.contextPath}/rest/worker/getIsGo",
			method : "post",
			data : {
				workerNoStr : createdUser
			},
			success : function(response) {
				if (response === true) {
					// 퇴근 기록이 있을 경우 모든 버튼을 숨기고 "출퇴근 완료" 텍스트 보여주기
					$(".btn-checkIn, .btn-checkOut").hide();
					$(".complete-message").text("당일 출근·퇴근 완료").show();
					$(".complete-message-wrapper").show();
					
				} else {
					// 퇴근 기록이 없을 경우 출근 여부 확인
					checkIsCome();
				}
			}
		});

		// 출근 여부 확인 함수
		function checkIsCome() {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/worker/getIsCome",
				method : "post",
				data : {
					workerNoStr : createdUser
				},
				success : function(response) {
					if (response === true) {
						// 출근 기록이 있을 경우 퇴근 버튼만 보이기
						$(".btn-checkIn").hide();
						$(".btn-checkOut").show();
					} else {
						// 출근 기록이 없을 경우 출근 버튼만 보이기
						$(".btn-checkIn").show();
						$(".btn-checkOut").hide();
					}
				}
			});
		}

		$(".btn-checkIn").click(function(event) {
			event.preventDefault();
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/worker/checkIn",
				method : "post",
				data : {
					workerNo : createdUser
				},
				success : function() {
					showSuccessMessage("출근 완료!");
					$(".btn-checkIn").hide();
					$(".btn-checkOut").show();
				},
				error : function() {
					alert("출근 처리에 실패했습니다. 다시 시도해주세요.");
				}
			});
		});

		$(".btn-checkOut").click(function(event) {
			event.preventDefault();
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/worker/checkOut",
				method : "post",
				data : {
					workerNo : createdUser
				},
				success : function() {
					showSuccessMessage("퇴근 완료!");
					$(".btn-checkOut").hide();
					$(".complete-message").text("당일 출근·퇴근 완료").show();
					$(".complete-message-wrapper").show();
				},
				error : function() {
					alert("퇴근 처리에 실패했습니다. 다시 시도해주세요.");
				}
			});
		});
	});
</script>
<div class="center">
			<img src="${pageContext.request.contextPath}/images/logoVer2.png" style="width: 30%">
		</div>

<div class="center container w-350 my-50" style="height: 200px">
    <!-- 출근 버튼 -->
    <div class="row mt-30">
        <button class="w-100 btn btn-my btn-checkIn" style="display:none;">출근하기</button>
    </div>

    <!-- 퇴근 버튼 -->
    <div class="row mt-30">
        <button class="w-100 btn btn-my btn-checkOut" style="display:none;">퇴근하기</button>
    </div>

    <!-- 출퇴근 완료 메시지 -->
    <div class="container-my row center mt-30 complete-message-wrapper" style="display:none">
        <span class="complete-message center" style="display:none;"></span>
    </div>
    
    <div class="row center success-message"></div> <!-- 성공 메시지를 표시할 요소 -->
</div>


<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/footer.jsp"></jsp:include>
