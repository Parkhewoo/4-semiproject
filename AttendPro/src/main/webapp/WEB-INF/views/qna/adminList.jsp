<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
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
        width: 100%;
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
</style>

<div class="container">
    <div class="row center">
        <h1>문의글</h1>
        <p>글은 자신의 인격입니다</p>
    </div>
    
    <div class="row right">
        <a href="write" class="btn btn-neutral bounce">글쓰기</a>
    </div>
    
    <div class="row">
        <table class="table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th width="40%">제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>번호</th>
                    <th>답변</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="qnaDto" items="${list}">
                    <!-- 시스템 관리자는 모든 글을 보고, 일반 사용자는 본인이 쓴 글만 보기 -->
                    
                            <tr>
                                <td>${qnaDto.qnaNo}</td>
                                <td class="left" style="padding-left:${qnaDto.qnaDepth*15 + 20}px">
                                    <c:if test="${qnaDto.qnaDepth > 0}">
                                        <img src="/images/reply.png" width="16" height="16">
                                    </c:if>
                                    <!-- 제목에 링크를 부여해서 상세 페이지로 이동하도록 구현 -->
                                    <a class="link link-animation" href="detail?qnaNo=${qnaDto.qnaNo}">${qnaDto.qnaTitle}</a>
                                </td>
                                <td>${qnaDto.qnaWriterString}</td>
                                <td>${qnaDto.qnaWTimeString}</td>
                                <td>${qnaDto.qnaNo}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${qnaDto.qnaDepth == 1}">
                                            ${qnaDto.qnaTarget}번글 답변
                                        </c:when>        
                                        <c:when test="${qnaDto.qnaReply == null}">
                                            답변 대기중 입니다!
                                        </c:when>
                                        <c:when test="${qnaDto.qnaReply != null}">
                                                답변 완료
                                        </c:when>
                                    </c:choose>
                                </td>
                            </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <br>
    <!-- 검색창 -->
    <div class="row center">
        <form action="adminList" method="get" autocomplete="off">
            <select name="column" class="field">
                <option value="qna_title" <c:if test="${param.column == 'qna_title'}">selected</c:if>>제목</option>
                <option value="qna_writer" <c:if test="${param.column == 'qna_writer'}">selected</c:if>>작성자</option>
            </select>
            <input class="field field-underline" type="text" name="keyword" placeholder="검색어" value="${param.keyword}">
            <button type="submit" class="btn">
                <i class="fa-solid fa-magnifying-glass"></i>
                검색
            </button>
        </form>
    </div>
    
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
