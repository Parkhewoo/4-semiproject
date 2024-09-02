<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<style>
.field.field-underline, .btn.btn-underline {
    border-color: #0984e3;
}
.field {
    padding: 8px;
    border-radius: 4px;
    border: 1px solid #ddd;
    box-sizing: border-box; 
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

.button-search-container {
    display: flex;
    justify-content: center; 
    align-items: center;
    gap: 130px;
    margin-bottom: 20px;
}

.search {
    display: flex;
    align-items: center; 
    gap: 10px; 
}

.search select, .search input, .search button {
    height: 36px; 
    line-height: 36px; 
}

.search select {
    width: 150px; 
}

.search input {
    width: 300px; 
}

.custom-btn {
     background-color: #659ad5 !important;
    color: white;
    border-radius: 0.3em;
    border: none;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 36px; 
    padding: 0 16px; 
    font-size: 14px; 
}
.custom-btn:hover {
    background-color: #2980b9 !important;
}

.table {
    width: 100%;
    border-collapse: collapse;
}

.table th, .table td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

.table th {
    background-color: #f4f4f4;
}
</style>

<div class="container">
    <div class="row center">
        <h1>공지글</h1>
        <p>공지글은 모든 사용자에게 공개됩니다.</p>
    </div>

    <div class="button-search-container">
        <!-- 검색창 및 버튼을 가운데 정렬 -->
        <div class="search">
            <form action="/" method="get" autocomplete="off" style="display: flex; align-items: center;">
                <select name="column" class="field">
                    <option value="notice_title"
                        <c:if test="${param.column == 'notice_title'}">selected</c:if>>제목</option>
                    <option value="notice_writer"
                        <c:if test="${param.column == 'notice_writer'}">selected</c:if>>작성자</option>
                </select>
                <input class="field field-underline" type="text" name="keyword"
                    placeholder="검색어" value="${param.keyword}">
                <button class="btn custom-btn" type="submit">검색</button>
            </form>
        </div>
        <!-- 글쓰기 버튼을 검색창 옆에 배치 -->
        <div>
            <c:if test="${sessionScope.createdRank == '시스템 관리자'}">
                <a href="/notice/write" class="btn btn-neutral bounce custom-btn">글쓰기</a>
            </c:if>
        </div>
    </div>

    <!-- 글 목록 -->
    <!-- 1 / 9페이지 (?개 중 ?~?번째) -->
    <div class="row right">${pageVO.page}/ ${pageVO.lastBlock} 페이지
        (${pageVO.beginRow} - ${pageVO.endRow} / ${pageVO.count} 개)</div>

    <div class="row">
        <table class="table">
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
                        <td>
                            <!-- 제목에 링크를 부여해서 상세 페이지로 이동하도록 구현 -->
                            <a class="link link-animation" href="/notice/detail?noticeNo=${noticeDto.noticeNo}">
                                ${noticeDto.noticeTitle}
                                <c:if test="${noticeDto.noticeUtime != null && noticeDto.noticeWtime.before(noticeDto.noticeUtime)}">
                                    <span class="modified-tag">(수정됨)</span>
                                </c:if>
                            </a>
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
</div>


