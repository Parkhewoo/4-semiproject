<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style> 
    .field.field-underline, 
    .btn.btn-underline { 
        border-color: #0984e3;
    }
    
    .custom-btn {
        border: 1px #33CC66 solid;
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
</style>

<div class="container w-1000 my-50">
    <div class="row">
        <h1>안내글</h1>
        <p>안내글은 모든 사용자에게 공개됩니다.</p>
    </div>

    <!-- 글쓰기 버튼 -->
    <div class="row right">
        <c:if test="${sessionScope.createdRank == '시스템 관리자'}">
            <a href="write" class="btn btn-neutral bounce">안내글 작성</a>
        </c:if>
    </div>

    <!-- 글 목록 -->
    <!-- 1 / 9페이지 (?개 중 ?~?번째) -->
    <div class="row right">
        ${pageVO.page} / ${pageVO.lastBlock} 페이지
        (${pageVO.beginRow} - ${pageVO.endRow} / ${pageVO.count} 개)
    </div>
    
    <div class="row">
        <table class="table table-border table-stripe table-hover">
            <thead>
                <tr>
                    <th>번호</th>
                    <th width="40%">제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="noticeDto" items="${noticeList}">
                <tr>
                    <td>${noticeDto.noticeNo}</td>
                    <td class="left">
                        <!-- 제목에 링크를 부여해서 상세 페이지로 이동하도록 구현 -->
                        <a class="link link-animation" href="detail?noticeNo=${noticeDto.noticeNo}">${noticeDto.noticeTitle}</a>
                    </td>
                    <td>${noticeDto.noticeWriter}</td>
                    <td>${noticeDto.noticeWtime}</td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="row">
        <!-- 네비게이터 불러오는 코드 -->
        <jsp:include page="/WEB-INF/views/template/navigator.jsp"/>
    </div>

    <br>
    <!-- 검색창 -->
    <div class="row center">
        <form action="list" method="get" autocomplete="off">
            <select name="column" class="field">
                <option value="notice_title" <c:if test="${param.column == 'notice_title'}">selected</c:if>>제목</option>
                <option value="notice_writer" <c:if test="${param.column == 'notice_writer'}">selected</c:if>>작성자</option>
            </select>
            <input class="field field-underline" type="text" name="keyword" placeholder="검색어" value="${param.keyword}">
            <button class="btn custom-btn" type="submit">검색</button>
        </form>
    </div>
    
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
