<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    /* 컨테이너 설정 */
    .fa-asterisk {
        color: #d63031;
    }
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
  .success { border: 2px solid green; }
    .fail { border: 2px solid red; }
    
     .btn-my {
        background-color: #659ad5;
        color: white;
        border-radius: 0.3em;
        border: none;
        }
</style>

<div class="container">
    <h1>${adminDto.adminId} 님의 계정 정보</h1>

  <table class="table-info">   	
     <tr>
        <th>사업자 번호</th>
        <td class="status-admin">${adminDto.adminNo}</td>
     </tr>
  
    <tr>
         <th>이메일</th>
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
         
 </table>

 
	
	<!-- 각종 메뉴를 배치 -->
	<div class="row center"> 
       <a href="/admin/password" class="btn btn-my">비밀번호 변경하기</a>       
       <a href="/admin/change" class="btn btn-my">개인정보 변경하기</a> 
       
       <c:if test="${adminDto.adminRank == '일반 관리자'}">
                    <c:choose>
                        <c:when test="${companyDto.companyId != null}">
                            <a href="/admin/company/info?companyId=${adminDto.adminId}" class="btn btn-my">회사 정보</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/admin/company/insert?companyId=${adminDto.adminId}" class="btn btn-my">회사 등록</a>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                 
       <a href="/admin/exit" class="btn btn-my">회원탈퇴</a> 
	 </div>  
      
</div>

<script>
    function confirmDelete() {
        return confirm('정말 탈퇴 하시겠습니까?');
    }
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>