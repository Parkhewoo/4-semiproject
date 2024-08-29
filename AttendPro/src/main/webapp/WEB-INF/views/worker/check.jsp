<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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
$(function(){
    function showSuccessMessage(message) {
        $(".success-message").text(message).fadeIn(300).delay(1000).fadeOut(300);
    }

    $(".btn-checkIn").click(function(event){
        event.preventDefault(); // 폼의 기본 동작(서버로의 폼 제출)을 막음
        var createdUser = $("input[name='createdUser']").val(); // input에서 createdUser 값을 가져옴
        $.ajax({
            url: "/rest/record/checkIn",
            method: "post",
            data: { workerNoStr: createdUser }, // createdUser 값을 전달
            success: function(){
                showSuccessMessage("출근 완료!");
            },
            error: function(){
                alert("출근 처리에 실패했습니다. 다시 시도해주세요.");
            }
        });
    });

    $(".btn-checkOut").click(function(event){
        event.preventDefault(); // 폼의 기본 동작(서버로의 폼 제출)을 막음
        var createdUser = $("input[name='createdUser']").val(); // input에서 createdUser 값을 가져옴
        $.ajax({
            url: "/rest/record/checkOut",
            method: "post",
            data: { workerNoStr: createdUser }, // createdUser 값을 전달
            success: function(){
                showSuccessMessage("퇴근 완료!");
            },
            error: function(){
                alert("퇴근 처리에 실패했습니다. 다시 시도해주세요.");
            }
        });
    });
});
</script>


<div class="container w-350 my-50">
    <c:choose>
        <c:when test="${!isCome}">
            <!-- 출근 버튼만 보이게 처리 -->
            <form action="/checkIn" method="post">
                <div class="row mt-30">
                    <input type="hidden" name="createdUser" value="${sessionScope.createdUser}">
                    <button class="w-100 btn btn-my btn-checkIn">출근 해버리기!</button>
                </div>
            </form>
        </c:when>
        <c:otherwise>
            <!-- 퇴근 버튼만 보이게 처리 -->
            <form action="/checkOut" method="post">
                <div class="row mt-30">
                    <input type="hidden" name="createdUser" value="${sessionScope.createdUser}">
                    <button class="w-100 btn btn-my btn-checkOut">퇴근 해버리기!</button>
                </div>
            </form>
        </c:otherwise>
    </c:choose>
    <div class="success-message"></div> <!-- 성공 메시지를 표시할 요소 -->
</div>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
