<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 댓글 스타일 -->
<style>
	.reply-wrapper {
		display:flex;
	}
	.reply-wrapper > .image-wrapper {
		width:100px;
		padding:10px;
	}
	.reply-wrapper > .image-wrapper > img {
		width:100%;
	}
	.reply-wrapper > .content-wrapper {
		flex-grow: 1;
		font-size: 16px;
	}
	.reply-wrapper > .content-wrapper > .reply-title {
		font-size: 1.25em;
	}
	.reply-wrapper > .content-wrapper > .reply-content {
		font-size: 0.95em;
		min-height: 50px;
	}
	.reply-wrapper > .content-wrapper > .reply-info {
		
	}
</style>


<div class="container w-800">
	<!-- 제목 -->
	<div class="row">
		<h1>
			${qnaDto.qnaTitle}
			<c:if test="${qnaDto.qnaUTime != null}">
				(수정됨)
			</c:if>
		</h1>
	</div>
	
	<!-- 작성자 -->
	<div class="row">
		<img src="https://cdn.pixabay.com/photo/2017/11/10/05/48/user-2935527_1280.png"
					width="25" height="25">
		${qnaDto.qnaWriterString}
	</div>
	
	<!-- 작성일 -->
	<div class="row right">
		<fmt:formatDate value="${qnaDto.qnaWTime}" 
									pattern="y년 M월 d일 E a h시 m분 s초"/>
	</div>
	
	<!-- 내용 -->
	<div class="row" style="min-height:200px">
		<!-- pre 태그는 내용을 작성된 형태 그대로 출력한다
				Rich Text Editor를 쓸 경우는 할 필요가 없다 -->
		${qnaDto.qnaContent}
	</div>
	
	
	
	<!-- 정보 -->
	<!--  <div class="row">
		답변 
		<fmt:formatNumber value="${qnaDto.qnaReplies}"
										pattern="#,##0"/>
	</div> -->
	
	<!-- 댓글 목록 	<div class="row reply-list-wrapper"></div> -->


<!-- 댓글 목록 -->
<c:choose>
 
    <c:when test="${qnaDto.qnaDepth == 0}">
        <div class="row">
            답변 대기중입니다
        </div>
    </c:when>
    

    <c:when test="${qnaDto.qnaDepth == 1}">
        <div class="row">
            ${qnaDto.qnaContent} 
        </div>
    </c:when>
    
</c:choose>
	
	<!-- 댓글 작성 -->
	<!--<c:choose>
	<c:when test="${sessionScope.createdRank == '시스템관리자'}">

	</c:when>
	</c:choose>-->
	
	<form action="write" method="post" autocomplete="off">
	<c:if test="${qnaDto.qnaTarget == null}">
	<!-- qnaNo를 hidden input으로 폼에 포함 -->
	  <input type="hidden" name="qnaTarget" value="${qnaDto.qnaNo}">
	  
	<div class="row">
            <label>내용</label>
            <input type="text" name="qnaTitle" class="field w-100" placeholder="제목">
            <textarea name="qnaContent" class="field w-100 reply-input" placeholder="내용"></textarea>
        </div>
        <div class="row right">
            <button type="submit" class="btn btn-positive w-100 reply-add-btn">답글 작성</button>
        </div>
	</c:if>
    </form>
	
	
	<!-- 각종 이동버튼들 -->
	<div class="row right">
		
		<%-- 본인 글만 표시되도록 조건 설정 --%>
		<c:set var="isAdmin" value="${sessionScope.createdLevel == '일반 관리자'}"/>
		<c:set var="isLogin" value="${sessionScope.createdUser != null}"/>
		<c:set var="isOwner" value="${sessionScope.createdUser == qnaDto.qnaWriter}"/>
		
		<c:if test="${isLogin}">
			<c:if test="${isOwner}">
				<a class="btn btn-negative" href="edit?qnaNo=${qnaDto.qnaNo}">수정</a>
			</c:if>
			<c:if test="${isOwner || isAdmin}">
				<a class="btn btn-negative" href="delete?qnaNo=${qnaDto.qnaNo}">삭제</a>
			</c:if>
		</c:if>
		
		<a class="btn btn-neutral" href="list">목록</a>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>






