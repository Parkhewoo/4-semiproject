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
	
	.field.field-underline, 
        .btn.btn-underline
        { 
            border-color: #0984e3;
        }
        
      .custom-btn {
            border:1px #33CC66 solid;
            color: #33CC66;
            background-color: transparent;
            border-radius: 0.25em;
            vertical-align: top;
            cursor: pointer;
        }
        .custom-btn:hover {
            color: white;
            background-color: #33CC66;
        }
        
          .container {
        width: 80%;
        max-width: 1200px;
        margin: 50px auto;
        padding: 20px;
   		border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .row {
        margin-bottom: 15px;
    }
    
    .center {
        text-align: center;
    }
    .form-container {
        display: flex;
        gap: 10px;
        justify-content: center;
        margin-bottom: 20px;
    }
    .field {
        padding: 8px;
        border-radius: 4px;
        border: 1px solid #ddd;
    }
    .w-22 {
        width: 22%;
    }
    .w-50 {
        width: 50%;
    }
    .btn {
        padding: 8px 15px;
        font-size: 16px;
        color: #fff;
        background-color: #3498db;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn:hover {
        background-color: #2980b9;
    }
    .table {
        width: 100%;
        border-collapse: collapse;
    }
    .table th, .table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    .table th {
        background-color: #f4f4f4;
    }
    .link {
        color: #3498db;
        text-decoration: none;
    }
    .link:hover {
        text-decoration: underline;
    }
    
  /* 내용 및 답글 영역 */
.content-section, .reply-section {
    padding: 20px;
    border-radius: 8px;
    border: 1px solid #ddd;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}

.content-section {
    background-color: #ffffff;
}

.reply-section {
    background-color: #f9f9f9;
}

.reply-section h2 {
    font-size: 1.5em;
    margin-bottom: 10px;
}

.reply-body, .content-body {
    min-height: 200px;
}

.reply-add-btn {
    background-color: #27ae60;
}

.reply-add-btn:hover {
    background-color: #2ecc71;
}

</style>

<script>
    function confirmDelete() {
        return confirm("정말로 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.");
    }
</script>


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
        <img src="https://cdn.pixabay.com/photo/2017/11/10/05/48/user-2935527_1280.png" width="25" height="25">
        ${qnaDto.qnaWriterString}
    </div>

    <!-- 작성일 -->
    <div class="row right">
        <fmt:formatDate value="${qnaDto.qnaWTime}" pattern="y년 M월 d일 E a h시 m분 s초"/>
    </div>

    <!-- 내용 -->
    <div class="row content-section">
        <h2>내용</h2>
        <div class="content-body" style="min-height:200px">
            ${qnaDto.qnaContent}
        </div>
    </div>

    <!-- 답글 영역 -->
    <c:choose>
        <c:when test="${qnaDto.qnaReply != null}">
            <div class="row reply-section">
                <h2>QNA 답변</h2>
                <div class="reply-body" style="min-height:200px">
                    ${qnaDto.qnaReply}
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row reply-section">
                <form action="write" method="post" autocomplete="off">
                    <c:if test="${sessionScope.createdRank == '시스템 관리자'}">
                        <!-- qnaNo를 hidden input으로 폼에 포함 -->
                        <input type="hidden" name="qnaTarget" value="${qnaDto.qnaNo}">
                        
                        <div class="row">
                            <label>제목</label>
                            <input type="text" name="qnaTitle" class="field w-100" placeholder="제목">
                            <textarea name="qnaContent" class="field w-100 reply-input" placeholder="내용"></textarea>
                        </div>
                        <div class="row right">
                            <button type="submit" class="btn btn-positive w-100 reply-add-btn">답글 작성</button>
                        </div>
                    </c:if>
                </form>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- 각종 이동버튼들 -->
    <div class="row right">
        <c:set var="isAdmin" value="${sessionScope.createdLevel == '일반 관리자'}"/>
        <c:set var="isLogin" value="${sessionScope.createdUser != null}"/>
        <c:set var="isOwner" value="${sessionScope.createdUser == qnaDto.qnaWriter}"/>
        
        <c:if test="${isLogin}">
            <c:if test="${isOwner && qnaDto.qnaReply == null}">
                <a class="btn btn-negative" href="edit?qnaNo=${qnaDto.qnaNo}">수정</a>
            </c:if>
            <c:if test="${isOwner || isAdmin}">
                <a class="btn btn-negative" href="delete?qnaNo=${qnaDto.qnaNo}" onclick="return confirmDelete()">삭제</a>
            </c:if>
        </c:if>
        <c:choose>
        	<c:when test="${sessionScope.createdRank == '일반 관리자'}">
        	<a class="btn" href="adminList">목록</a>
        	</c:when>
        	<c:otherwise>
        	<a class="btn" href="list">목록</a>
        	</c:otherwise>
        </c:choose>
        
    </div>
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>






