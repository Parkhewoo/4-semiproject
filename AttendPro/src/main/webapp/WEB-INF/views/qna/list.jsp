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
</style>
<div class="container w-1000 my-50">
	<div class="row">
		<h1>문의글</h1>
		<p>글은 자신의 인격입니다</p>
	</div>
<!-- 
	<div class="row right">
		<%-- 비회원일 때와 회원일 때 다르게 보이도록 처리 --%>
		<c:choose>
			<c:when test="${sessionScope.createdUser != null}">
				<a href="write" class="btn btn-neutral">글쓰기</a>	
			</c:when>
			<c:otherwise>
				<a title="로그인 하셔야 이용하실 수 있습니다" class="btn btn-neutral">글쓰기</a>
			</c:otherwise>
		</c:choose>
	</div>
  -->
  <div class="row right">
 <a href="write" class="btn btn-neutral bounce">글쓰기</a>
  </div>
	<!-- 글목록 -->
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
					<th>번호</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="qnaDto" items="${qnaList}">
				<tr>
					<td>${qnaDto.qnaNo}</td>
					<td class="left" style="padding-left:${qnaDto.qnaDepth*15 + 20}px">
						<c:if test="${qnaDto.qnaDepth > 0}">
							<img src="/images/reply.png" width="16" height="16">
						</c:if>
					<!-- 제목에 링크를 부여해서 상세 페이지로 이동하도록 구현 -->
					<a class="link link-animation" href="detail?qnaNo=${qnaDto.qnaNo}">${qnaDto.qnaTitle}</a>
					
				
					</td>
					<td>
						<%--
						<c:choose>
							<c:when test="${qnaDto.boardWriter == null}">
								탈퇴한사용자
							</c:when>
							<c:otherwise>${boardDto.boardWriter}</c:otherwise>
						</c:choose>
						 --%>
						 ${qnaDto.qnaWriterString}
					</td>
					<td>${qnaDto.qnaWTimeString}</td>
			
					<td>${qnaDto.qnaNo}</td>
					<td>
					
						<c:choose>
							<c:when test="${qnaDto.qnaDepth == 1}">
								답변 입니다
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
	
	
	<div class="row">
		<!-- 네비게이터 불러오는 코드 -->
		<jsp:include page="/WEB-INF/views/template/navigator.jsp"/>
	</div>

	<br>
	<!-- 검색창 -->
	<div class="row center">
		<form action="list" method="get" autocomplete="off">
			<select name="column" class="field">
				<option value="qna_title" <c:if test="${param.column == 'qna_title'}">selected</c:if>>제목</option>
				<option value="qna_writer" <c:if test="${param.column == 'qna_writer'}">selected</c:if>>작성자</option>
			</select>
			<input class="field field-underline" type="text" name="keyword" placeholder="검색어" value="${param.keyword}">
			<button class="btn custom-btn"  type="submit">검색</button>
		</form>
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>






