<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

<link rel="stylesheet" type="text/css" href="/editor/editor.css">
<script src="/editor/editor.js"></script>
 
<style>
.btn-positive {
 	background-color: #659ad5 !important;
    color: white;
    border-radius: 0.3em;
    border: none;
}
.btn-positive:hover {
	background-color: #2980b9 !important;
}
.btn-neutral {
 	background-color:#7e8a91 !important;
	border-radius: 0.3em;
    border: none;
}
.btn-neutral:hover {
	background-color: #5f686e !important;
}
</style> 
 
<script type="text/javascript">
$(document).ready(function() {
    $('textarea[name="noticeContent"]').summernote({
      height: 200 // 에디터 높이
    });
  });
</script>

<form action="/notice/write" method="post" autocomplete="off">

<div class="container w-800">
	<div class="row center">
		<h1>공지글 작성</h1>
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
		<button type="submit" class="btn btn-positive">작성하기</button>
		<a class="btn btn-neutral" href="/">목록으로</a>
	</div>
</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>