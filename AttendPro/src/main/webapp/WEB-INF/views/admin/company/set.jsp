<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
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
        gap: 20px;
        justify-content: space-between;
    }
    .form-card {
        flex: 1;
        padding: 20px;
        border-radius: 8px;
        border: 1px solid #ddd;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        background-color: #f9f9f9;
    }
    .form-card h3 {
        margin-bottom: 15px;
        color: #333;
    }
    .form-card label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #555;
    }
    .form-card input[type="date"] {
        width: 100%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        margin-bottom: 15px;
    }
    .form-card button {
        padding: 10px 15px;
        font-size: 16px;
        color: #fff;
        background-color: #3498db;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        width: 100%;
    }
    .form-card button:hover {
        background-color: #2980b9;
    }
    .hidden {
        display: none;
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
    .btn-del {
        padding: 8px 15px;
        font-size: 16px;
        color: #fff;
        background-color: red;
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
    .input-group {
        display: flex;
        gap: 10px;
        align-items: center;
    }
    .btn-my {
        padding: 8px 15px;
        font-size: 16px;
        color: #fff;
        background-color: #3498db;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn-my:hover {
        background-color: #2980b9;
    }
    .btn-ani {
        transition: transform 0.5s ease-out;
    }
    .btn-ani:active {
        transform: scale(1.1); /* 클릭 시 10% 확대 */
    }
</style>

<script>
function showForm(formId) {
    const forms = document.querySelectorAll('.form-card');
    forms.forEach(form => {
        if (form.id === formId) {
            form.classList.toggle('hidden');
        } else {
            form.classList.add('hidden');
        }
    });
}

function deleteHoliday(companyId, holidayDate) {
    $.ajax({
        url: '/rest/holi/delete',
        type: 'POST',
        data: {
            companyId: companyId,
            holidayDate: holidayDate
        },
        success: function(response) {
            alert(response); // 성공 메시지 표시
            window.location.reload(); // 페이지 새로 고침
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
            alert('Failed to delete holiday'); // 오류 메시지 표시
        }
    });
}

function addHoliday(companyId, holidayDate) {
    $.ajax({
        url: '/rest/holi/add',
        type: 'POST',
        data: {
            companyId: companyId,
            holidayDate: holidayDate
        },
        success: function(response) {
            alert(response); // 성공 메시지 표시
            window.location.reload(); // 페이지 새로 고침
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
            alert('Failed to add holiday'); // 오류 메시지 표시
        }
    });
}
</script>

<form action="set" method="post" autocomplete="off">
    <input type="hidden" name="companyId" value="${sessionScope.createdUser}">

    <div class="container">
        <div class="row center">
            <h1>업장정보 수정</h1>
        </div>
        <div class="row">
            <label>회사이름</label>
            <input name="companyName" type="text" class="field w-100" value="${companyDto.companyName}">
        </div>
        <div class="row">
            <label>대표자명</label>
            <input name="companyCeo" type="text" class="field w-100" value="${companyDto.companyCeo}">
        </div>
        <div class="row">
            <label>출근시간</label>
            <input name="companyIn" type="time" class="field w-100" value="${companyDto.companyIn}">
        </div>
        <div class="row">
            <label>퇴근시간</label>
            <input name="companyOut" type="time" class="field w-100" value="${companyDto.companyOut}">
        </div>
        <div class="row">
            <label>주소</label>
            <div class="input-group">
                <input type="text" id="post" name="companyPost" class="field w-22" placeholder="우편번호" value="${companyDto.companyPost}" readonly />
                <button type="button" class="btn-my" onclick="openPostcode()">우편번호 검색</button>
            </div>
        </div>
        <div class="row">
            <input type="text" id="address1" name="companyAddress1" class="field w-50" placeholder="주소" value="${companyDto.companyAddress1}" readonly />
        </div>
        <div class="row">
            <input type="text" id="address2" name="companyAddress2" class="field w-50" placeholder="상세 주소" value="${companyDto.companyAddress2}" />
        </div>

        <!-- 휴일 목록만 표시 -->
        <div class="row center">
            <h2>휴일 목록</h2>
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>휴일 날짜</th>
<!--                     <th>추가</th>  -->
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="holidayDate" items="${holidayDates}">
                    <fmt:formatDate value="${holidayDate}" pattern="yyyy-MM-dd" var="formattedHolidayDate"/>
                    <tr>
                        <td>${formattedHolidayDate}</td>
<!--                         <td> -->
<%--                             <button type="button" class="btn" onclick="addHoliday('${sessionScope.createdUser}', '${formattedHolidayDate}')">X</button> --%>
<!--                         </td> -->
                        <td>
                            <button type="button" class="btn btn-del" onclick="deleteHoliday('${sessionScope.createdUser}', '${formattedHolidayDate}')">X</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="row">
            <label>휴일추가</label>
            <input name="addHolidayDate" type="date" class="field w-100">
        </div>
        
        <div class="row mt-30">
            <button class="btn w-100" type="submit">수정하기</button>
        </div>
    </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
