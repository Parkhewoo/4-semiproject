<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

   .table {
        width: 100%;
        max-width: 1200px;
        margin: 20px auto;
        padding: 10px;
        border-radius: 10px;
   		border: 1px solid #ddd;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
   
</style>
    
<body>
	<div class="container w-800">
    <h2>
    <span style="color:#88a2d8">
    ${workerName}
    </span>
    님의 근태 기록</h2>
    
	<div class="flex-box">출근률<div class="px-10" id="workRate"></div></div>
	
    <div class="progressbar">
            <div class="guage" id="workRate"></div>
    </div>

	
    <div class="center">누적 근태 기록</div>
    <table border="1" class="table table-stripe">
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
	<br>
    <div class="center" id="currentYearText">년 근태기록</div>
    <table border="1" class="table table-stripe">
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
	<br>
    <div class="row center" id="lastYearText">작년 근태기록</div>
    <table border="1" class="table table-stripe">
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
	<br>
    <div class="row center" id="currentMonthText">이번 달 근태기록</div>
    <table border="1" class="table table-stripe">
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
	<br>
    <div class="row center" id="lastMonthText">저번달 근태기록</div>
    <table border="1" class="table table-stripe">
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
	<br>
    <div class="row center" id="twoMonthsAgoText">저저번달 근태기록</div>
    <table border="1" class="table table-stripe">
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
	</div>
   <br>
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
            
            const attend = ${attendanceYearly.attend}; 
            const workday = ${attendanceYearly.workday}; 
            
         	// Calculate work rate
            const workRate = (attend / workday) * 100;

            currentYearText.textContent = currentYear+'년 근태 기록';
            lastYearText.textContent = lastYear+'년 근태 기록';
            currentMonthText.textContent = currentYear+'년 '+currentMonth+'월 근태 기록';
            lastMonthText.textContent = currentYear+'년 '+ lastMonth + '월 근태기록';
            twoMonthsAgoText.textContent = currentYear+'년 '+twoMonthsAgo+'월 근태 기록';
            document.getElementById('workRate').textContent = workRate.toFixed(2)+'%';
            
            
            document.getElementById('workRate').textContent = workRate.toFixed(2)+'%';
            
            
            
            $(function(){
            	var percent = workRate.textContent;
            	$(".progressbar").children(".guage").css("width", workRate+"%");
            });
        };
        
        
        
    </script>
</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
