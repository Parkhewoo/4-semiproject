<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<body>
    <h2>${sessionScope.createdUser}님의 근태 기록</h2>
	
    <div class="row center">누적 근태 기록</div>
    <table border="1" class="table table-border table-stripe">
        <thead>
            <tr>
                <th>출근</th>
                <th>지각</th>
                <th>조퇴</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>${attendance.attend}</td>
                <td>${attendance.late}</td>
                <td>${attendance.leave}</td>
            </tr>
        </tbody>
    </table>

    <div class="row center" id="currentYearText">년 근태기록</div>
	${attendanceYearly.workday}
    <table border="1" class="table table-border table-stripe">
        <thead>
            <tr>
                <th>출근</th>
                <th>지각</th>
                <th>조퇴</th>
                <th>결근</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>${attendanceYearly.attend}</td>
                <td>${attendanceYearly.late}</td>
                <td>${attendanceYearly.leave}</td>
                <td>${attendanceYearly.absent}</td>
            </tr>
        </tbody>
    </table>

    <div class="row center" id="lastYearText">작년 근태기록</div>
    ${attendanceYearly2.workday}
    <table border="1" class="table table-border table-stripe">
        <thead>
            <tr>
                <th>출근</th>
                <th>지각</th>
                <th>조퇴</th>
                <th>결근</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>${attendanceYearly2.attend}</td>
                <td>${attendanceYearly2.late}</td>
                <td>${attendanceYearly2.leave}</td>
                <td>${attendanceYearly2.absent}</td>
            </tr>
        </tbody>
    </table>

    <div class="row center" id="currentMonthText">이번 달 근태기록</div>
    <table border="1" class="table table-border table-stripe">
        <thead>
            <tr>
                <th>출근</th>
                <th>지각</th>
                <th>조퇴</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>${attendanceMonthly.attend}</td>
                <td>${attendanceMonthly.late}</td>
                <td>${attendanceMonthly.leave}</td>
            </tr>
        </tbody>
    </table>

    <div class="row center" id="lastMonthText">저번달 근태기록</div>
    <table border="1" class="table table-border table-stripe">
        <thead>
            <tr>
                <th>출근</th>
                <th>지각</th>
                <th>조퇴</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>${attendanceMonthly2.attend}</td>
                <td>${attendanceMonthly2.late}</td>
                <td>${attendanceMonthly2.leave}</td>
            </tr>
        </tbody>
    </table>

    <div class="row center" id="twoMonthsAgoText">저저번달 근태기록</div>
    <table border="1" class="table table-border table-stripe">
        <thead>
            <tr>
                <th>출근</th>
                <th>지각</th>
                <th>조퇴</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>${attendanceMonthly3.attend}</td>
                <td>${attendanceMonthly3.late}</td>
                <td>${attendanceMonthly3.leave}</td>
            </tr>
        </tbody>
    </table>
	
    <script type="text/javascript">
        window.onload = function() {
            const now = new Date();
            const currentYear = now.getFullYear();
            const lastYear = currentYear - 1;

            const currentMonth = now.getMonth() + 1;
            const lastMonthDate = new Date(now.getFullYear(), now.getMonth() - 1, 1);
            const twoMonthsAgoDate = new Date(now.getFullYear(), now.getMonth() - 2, 1);

            const lastMonth = lastMonthDate.getMonth() + 1;
            const twoMonthsAgo = twoMonthsAgoDate.getMonth() + 1;
            
                currentYearText.textContent = currentYear+'년 근태 기록';
                lastYearText.textContent = lastYear+'년 근태 기록';
                currentMonthText.textContent = currentYear+'년 '+currentMonth+'월 근태 기록';
                lastMonthText.textContent = currentYear+'년 '+ lastMonth + '월 근태기록';
                twoMonthsAgoText.textContent = currentYear+'년 '+twoMonthsAgo+'월 근태 기록';
        };
    </script>
</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
