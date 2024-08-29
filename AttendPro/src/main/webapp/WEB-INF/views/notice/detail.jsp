<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

<link rel="stylesheet" type="text/css" href="/editor/editor.css">
<script src="/editor/editor.js"></script>

<!-- 공지글 스타일 -->
<style> 
    .notice-wrapper {
        display: flex;
    }
    .notice-wrapper > .image-wrapper {
        width: 100px;
        padding: 10px;
    }
    .notice-wrapper > .image-wrapper > img {
        width: 100%;
    }
    .notice-wrapper > .content-wrapper {
        flex-grow: 1;
        font-size: 16px;
    }
    .notice-wrapper > .content-wrapper > .notice-title {
        font-size: 1.25em;
    }
    .notice-wrapper > .content-wrapper > .notice-content {
        font-size: 0.95em;
        min-height: 50px;
    }
    .notice-wrapper > .content-wrapper > .notice-info {
        
    }
</style>

<div class="container w-800">
    <!-- 제목 -->
    <div class="row">
        <h1>
            ${noticeDto.noticeTitle}
            <c:if test="${noticeDto.noticeUtime != null}">
                (수정됨)
            </c:if>
        </h1>
    </div>
    
    <!-- 작성자 -->
    <div class="row">
        <img src="https://cdn.pixabay.com/photo/2017/11/10/05/48/user-2935527_1280.png"
             width="25" height="25">
        ${noticeDto.noticeWriter}
    </div>
    
    <!-- 작성일 -->
    <div class="row right">
        <fmt:formatDate value="${noticeDto.noticeWtime}" 
                        pattern="y년 M월 d일 E a h시 m분 s초"/>
    </div>
    
    <!-- 내용 -->
    <div class="row" style="min-height:200px">
        ${noticeDto.noticeContent}
    </div>
    
    <hr>
    
    <!-- 이동 버튼들 -->
    <div class="row right">
        <!-- 본인 글만 표시되도록 조건 설정 -->
        <c:set var="isAdmin" value="${sessionScope.createdLevel == '시스템 관리자'}"/>
        <c:set var="isLogin" value="${sessionScope.createdUser != null}"/>
        <c:set var="isOwner" value="${sessionScope.createdUser == noticeDto.noticeWriter}"/>
        
        <!-- 공지글 작성 버튼 (시스템 관리자만 가능) -->
        <c:if test="${isLogin && isAdmin}">
            <a class="btn btn-positive" href="write">안내글 작성</a>
        </c:if>
        
        <!-- 수정 및 삭제 버튼 (본인 글 또는 시스템 관리자만 가능) -->
        <c:if test="${isLogin && isOwner}">
            <a class="btn btn-negative" href="edit?noticeNo=${noticeDto.noticeNo}">수정</a>
        </c:if>
        <c:if test="${isLogin && (isOwner || isAdmin)}">
            <a class="btn btn-negative" href="delete?noticeNo=${noticeDto.noticeNo}">삭제</a>
        </c:if>
        
        <!-- 목록 버튼 (모든 사용자에게 표시) -->
        <a class="btn btn-neutral" href="list">목록</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
