<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.1/main.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.1/main.min.css">

<style>
    /* 기존 스타일 */
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

    .table-info td.status-admin, .block-list-table td {
        text-align: center; /* 가운데 정렬 */
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

    /* 새로운 스타일 */
    .block-list-table th, .block-list-table td {
        width: 33.33%; /* 각 열의 너비를 동일하게 설정 */
        text-align: center; /* 가운데 정렬 */
    }

    .pagination {
        text-align: center;
        margin: 20px 0;
    }

    .pagination a, .pagination strong {
        display: inline-block;
        margin: 0 5px;
        padding: 5px 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        color: #3498db;
        text-decoration: none;
    }

    .pagination a:hover {
        background-color: #f4f4f4;
    }

    .pagination strong {
        font-weight: bold;
        color: #333;
        background-color: #f4f4f4;
    }
</style>





<script>
function confirmDelete() {
    return confirm('정말 삭제하시겠습니까?');
}
</script>
<div class="container">
    <h1>관리자 상세페이지</h1>

    <!-- 에러 메시지 표시 -->
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <c:choose>
        <c:when test="${empty adminDto}">
            <!-- 없을 때 화면 -->
            <div class="row">
                <h2>존재하지 않는 아이디</h2>
            </div>
        </c:when>
        <c:otherwise>
            <h2>관리자 정보</h2>
            <table class="table-info">
                <tr>
                    <th>관리자 아이디</th>
                    <td class="status-admin">${adminDto.adminId}</td>
                </tr>
                <tr>
                    <th>사업자 번호</th>
                    <td class="status-admin">${adminDto.adminNo}</td>
                </tr>
                <tr>
                    <th>관리등급</th>
                    <td class="status-admin">${adminDto.adminRank}</td>
                </tr>
                <tr>
                    <th>관리자 이메일</th>
                    <td class="status-admin">${adminDto.adminEmail}</td>
                </tr>
                <tr>
                    <th>최종 로그인</th>
                    <td class="status-admin">
                        <c:choose>
                            <c:when test="${adminDto.adminLogin != null}">
                                <fmt:formatDate value="${adminDto.adminLogin}" pattern="yyyy년 MM월 dd일 E요일 HH시 mm분 ss초"/>
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

            <!-- 회사 정보 표시 조건 -->
            <c:choose>
                <c:when test="${adminDto.adminRank == '일반 관리자'}">
                    <c:choose>
                        <c:when test="${companyDto.companyId == null}">
                            <h2>회사 정보</h2>
                            <p class="info-message">등록된 사업장이 없습니다. </p>
                        </c:when>
                        <c:otherwise>
                            <h2>회사 정보</h2>
                            <table class="table-info">
                                <tr>
                                    <th>회사 아이디</th>
                                    <td class="status-admin">${companyDto.companyId}</td>
                                </tr>
                                <tr>
                                    <th>회사명</th>
                                    <td class="status-admin">${companyDto.companyName}</td>
                                </tr>
                                <tr>
                                    <th>대표자</th>
                                    <td class="status-admin">${companyDto.companyCeo}</td>
                                </tr>
                                <tr>
                                    <th>근무 시작 시간</th>
                                    <td class="status-admin">${companyDto.companyIn}</td>
                                </tr>
                                <tr>
                                    <th>근무 종료 시간</th>
                                    <td class="status-admin">${companyDto.companyOut}</td>
                                </tr>
                                <tr>
                                    <th>우편번호</th>
                                    <td class="status-admin">${companyDto.companyPost}</td>
                                </tr>
                                <tr>
                                    <th>주소</th>
                                    <td class="status-admin">${companyDto.companyAddress1} ${companyDto.companyAddress2}</td>
                                </tr>
                            </table>
                             <div class="row center">
                                <h2>휴일</h2>
                                <jsp:include page="/WEB-INF/views/template/calendar.jsp"></jsp:include>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:when test="${adminDto.adminRank == '시스템 관리자'}">
                    <!-- 시스템 관리자 전용 내용 추가 가능 -->
                </c:when>
            </c:choose>

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
                        <c:if test="${pageDto != null}">
                            <c:if test="${pageDto.page != 1}">
                                <a href="?page=1"><<</a>
                                <a href="?page=${pageDto.page - 1}"><</a>
                            </c:if>
                            <c:forEach var="pageNum" begin="1" end="${pageDto.totalPages}">
                                <c:choose>
                                    <c:when test="${pageNum == pageDto.page}">
                                        <strong>${pageNum}</strong>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="?page=${pageNum}">${pageNum}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:if test="${pageDto.page != pageDto.totalPages}">
                                <a href="?page=${pageDto.page + 1}">></a>
                                <a href="?page=${pageDto.totalPages}">>></a>
                            </c:if>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="links">
                <a href="list">관리자 목록</a>
                <a href="delete?adminId=${adminDto.adminId}" onclick="return confirmDelete();">관리자 삭제</a>
                <a href="edit?adminId=${adminDto.adminId}">정보 변경</a>
                 <c:if test="${not isBlocked}">
                    <a href="block?blockTarget=${adminDto.adminId}">차단</a>
                </c:if>
                <c:if test="${isBlocked}">
                    <a href="cancle?blockTarget=${adminDto.adminId}">해제</a>
                </c:if>
            </div>
        </c:otherwise>
    </c:choose>
</div>

    
</script>
