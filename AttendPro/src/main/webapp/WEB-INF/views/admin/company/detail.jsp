<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    /* 컨테이너 설정 */
    .container {    
        width: 100%;
        max-width: 1200px;
        margin: 40px auto; /* 상하 여백을 줄여서 중앙 정렬 */
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* 제목 및 행 간격 */
    .row {
        margin-bottom: 20px; /* 제목과 다음 내용 사이의 간격을 넓힘 */
    }

    /* 테이블 스타일링 */
    .table-info, .block-list-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px; /* 테이블과 다음 요소 사이의 간격을 넓힘 */
    }

    .table-info th, .table-info td,
    .block-list-table th, .block-list-table td {
        padding: 12px; /* 셀 내 여백을 약간 넓힘 */
        text-align: left;
        border-bottom: 1px solid #ddd;
        font-size: 16px; /* 폰트 사이즈를 조정 */
    }

    .table-info th, .block-list-table th {
        background-color: #f4f4f4;
        border-bottom: 2px solid #ddd;
        font-size: 18px; /* 헤더 폰트 사이즈를 조정 */
    }

    .table-info tr:last-child td,
    .block-list-table tr:last-child td {
        border-bottom: none;
    }

    /* 메시지 스타일링 */
    .info-message, .status-message-negative, .status-message-positive {
        text-align: center;
        font-size: 16px; /* 메시지 폰트 사이즈 조정 */
        margin: 10px 0; /* 상하 여백 조정 */
        padding: 10px;
    }

    .status-admin {
        text-align: center;
        font-size: 16px; /* 상태 폰트 사이즈 조정 */
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

    /* 링크 스타일링 */
    .links {
        text-align: center;
        margin-top: 20px; /* 링크와 위 요소 사이의 간격을 넓힘 */
    }

    .links a {
        text-decoration: none;
        color: #3498db;
        font-weight: bold;
        margin: 0 10px; /* 링크 사이 간격 조정 */
        font-size: 16px; /* 링크 폰트 사이즈 조정 */
    }

    .links a:hover {
        text-decoration: underline;
    }

    /* 페이지 네비게이터 스타일링 */
    .pagination {
        text-align: center;
        margin-top: 20px;
    }

    .pagination a {
        text-decoration: none;
        color: #3498db;
        margin: 0 5px;
        font-size: 16px; /* 페이지 네비게이터 폰트 사이즈 조정 */
    }

    .pagination strong {
        font-size: 16px;
        font-weight: bold;
    }
</style>

<div class="container">
    <h1>업장 상세 정보</h1>

    <!-- 에러 메시지 표시 -->
    <c:if test="${not empty error}">
        <div class="info-message">${error}</div>
    </c:if>

    <c:choose>
        <c:when test="${companyDto == null}">
            <!-- 없을 때 화면 -->
            <div class="row">
                <h2>존재하지 않는 업장입니다</h2>
            </div>
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
                    <th>대표자명</th>
                    <td class="status-admin">${companyDto.companyCeo}</td>
                </tr>
                <tr>
                    <th>출근시간</th>
                    <td class="status-admin">${companyDto.companyIn}</td>
                </tr>
                <tr>
                    <th>퇴근시간</th>
                    <td class="status-admin">${companyDto.companyOut}</td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td class="status-admin">${companyDto.companyPost} ${companyDto.companyAddress1} ${companyDto.companyAddress2}</td>
                </tr>
                <tr>
                    <th>휴일</th>
                    <td class="status-admin">${companyDto.companyHoliday}</td>
                </tr>
            </table>

            <!-- 페이지 네비게이터 -->
            <c:choose>
                <c:when test="${not empty blockList}">
                    <h2>차단 이력</h2>
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
                </c:when>
            </c:choose> 
  <div class="links">
                <h2><a href="set?companyId=${companyDto.companyId}">회사정보 수정</a></h2>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function confirmDelete() {
        return confirm('정말 삭제하시겠습니까?');
    }
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
