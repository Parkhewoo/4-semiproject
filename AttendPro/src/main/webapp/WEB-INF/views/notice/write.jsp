<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/editor/editor.css">
<script src="${pageContext.request.contextPath}/editor/editorNotice.js"></script>

<form action="${pageContext.request.contextPath}/notice/write" method="post" autocomplete="off">
	
	<div class="container w-800" >
		<div class="row"> 
			<h1>게시글 작성</h1>
		</div>
		<div class="row">
			욕설 또는 무분별한 광고, 비방은 예고 없이 삭제될 수 있습니다
		</div>
		<div class="row">
			<label>제목</label>
			<input type="text" name="noticeTitle" class="field w-100">
		</div>
		<div class="row">
			<label>내용</label>
			<textarea name="noticeContent" rows="10" class="field w-100"></textarea>		
		</div>
		<div class="row right">
			<button type="submit" class="btn">작성하기</button>
			<a class="btn btn-neutral" href="${pageContext.request.contextPath}/notice/list">목록으로</a>
		</div>
	</div>
	
</form>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/footer.jsp"></jsp:include>