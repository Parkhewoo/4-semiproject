<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    /* 기존 스타일 */
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

    .table-info, .block-list-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    .table-info th, .table-info td,
    .block-list-table th, .block-list-table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    .table-info th, .block-list-table th {
        background-color: #f4f4f4;
        border-bottom: 2px solid #ddd;
    }

    .table-info tr:last-child td,
    .block-list-table tr:last-child td {
        border-bottom: none;
    }

    .info-message, .status-message-negative, .status-message-positive {
        text-align: center;
        font-size: 18px;
        margin: 0;
        padding: 10px;
    }

    .table-info td.status-admin {
        text-align: center;
    }

    .status-admin {
        text-align: center;
        font-size: 18px;
        margin: 0;
        padding: 10px;
    }

    .info-message {
        color: #e74c3c;
    }

    .status-message-negative {
        color: #e74c3c;
    }

    .status-message-positive {
        color: #3498db;
    }

    .links {
        text-align: center;
    }

    .links a {
        text-decoration: none;
        color: #3498db;
        font-weight: bold;
        margin: 0 15px;
    }

    .links a:hover {
        text-decoration: underline;
    }
</style>

<div class="container">
    <h1>사업주 상세페이지</h1>

    <!-- 에러 메시지 표시 -->
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <c:choose>
        <c:when test="${dto == null}">
            <!-- 없을 때 화면 -->
            <div class="row">
                <h2>존재하지 않는 아이디</h2>
            </div>
        </c:when>
        <c:otherwise>
            <h2>사업주 정보</h2>
            <table class="table-info">
                <tr>
                    <th>사업주 아이디</th>
                    <td class="status-admin">${dto.adminId}</td>
                </tr>
                <tr>
                    <th>사업자 번호</th>
                    <td class="status-admin">${dto.adminNo}</td>
                </tr>
                <tr>
                    <th>관리등급</th>
                    <td class="status-admin">${dto.adminRank}</td>
                </tr>
                <tr>
                    <th>사업주 이메일</th>
                    <td class="status-admin">${dto.adminEmail}</td>
                </tr>
                <tr>
                    <th>최종 로그인</th>
                    <td class="status-admin">
                        <c:choose>
                            <c:when test="${dto.adminLogin != null}">
                                <fmt:formatDate value="${dto.adminLogin}" pattern="yyyy년 MM월 dd일 E요일 HH시 mm분 ss초"/>
                            </c:when>
                            <c:otherwise>
                                데이터가 없습니다
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>차단상태</th>
                    <td>
                        <c:choose>
                            <c:when test="${isBlocked}">
                                <p class="status-message-negative">현재 차단된 회원입니다.</p>
                            </c:when>
                            <c:otherwise>
                                <p class="status-message-positive">차단 해제된 회원입니다.</p>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>

            <h2>차단 이력</h2>
            <c:choose>
                <c:when test="${empty blockList}">
                    <p class="info-message">차단이력이 존재하지 않습니다</p>
                </c:when>
                <c:otherwise>
                    <table class="block-list-table">
                        <thead>
                            <tr>
                                <th>일시</th>
                                <th>구분</th>
                                <th>사유</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="blockDto" items="${blockList}">
                                <tr>
                                    <td>
                                        <fmt:formatDate value="${blockDto.blockTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>${blockDto.blockType}</td>
                                    <td>${blockDto.blockMemo}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- 페이지 네비게이터 -->
                    <div class="pagination">
                        <c:if test="${pageVO.hasPrev()}">
                            <a href="?adminId=${dto.adminId}&page=${pageVO.getPrevBlock()}">&laquo; 이전</a>
                        </c:if>

                        <c:forEach var="i" begin="${pageVO.getStartBlock()}" end="${pageVO.getFinishBlock()}">
                            <c:choose>
                                <c:when test="${i == pageVO.getPage()}">
                                    <strong>${i}</strong>
                                </c:when>
                                <c:otherwise>
                                    <a href="?adminId=${dto.adminId}&page=${i}">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <c:if test="${pageVO.hasNext()}">
                            <a href="?adminId=${dto.adminId}&page=${pageVO.getNextBlock()}">다음 &raquo;</a>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose> 

            <div class="links"> 
                <a href="list">사업주 목록</a>
                <a href="delete?adminId=${dto.adminId}">사업주 삭제</a>
                <a href="edit?adminId=${dto.adminId}">정보 변경</a>
                <c:if test="${not isBlocked}">
                    <a href="block?blockTarget=${dto.adminId}">차단</a>
                </c:if>
                <c:if test="${isBlocked}">
                    <a href="cancle?blockTarget=${dto.adminId}">해제</a>
                </c:if>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
