<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<!-- jQuery 라이브러리 포함 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- chart js 라이브러리 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


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

.table-info th, .table-info td, .block-list-table th, .block-list-table td
	{
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

.table-info th, .block-list-table th {
	background-color: #f4f4f4;
	border-bottom: 2px solid #ddd;
}

.table-info tr:last-child td, .block-list-table tr:last-child td {
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

<script type="text/javascript">
	// 차트 생성 함수
	function createChart(url, selector, legend='', type='bar') {
	    //step 1 - 차트를 만들기 위해 필요한 데이터를 요청
	    //step 2 - 데이터를 이용하여 차트를 생성
	    
	    //step 1
	    $.ajax({
	        url : url,
	        method : "post",
	        success : function(response) {
	            //response는 객체 배열 형태 - [ {...} , {...} , {...} ]
	            //console.log(response);
	
	            //response를 두 개의 배열로 분리
	            var names = [];//title이 담길 배열 
	            var values = [];//cnt가 담길 배열
	
	            for(var i=0; i < response.length; i++) {//전체를 반복하며
	                names.push(response[i].title);//title을 names에 추가
	                values.push(response[i].cnt);//cnt를 values에 추가
	            }
	            //console.log(names, values);
	
	            //step 2
	            //차트를 그릴 대상 선택
	            const ctx = document.querySelector(selector);
	
	            //차트 생성 코드
	            //new Chart(캔버스태그, {옵션객체});
	            new Chart(ctx, {
	                type: type,//차트 유형(bar/pie/doughnut/line)
	                data: {//차트에 표시될 데이터
	
	                    //label은 차트에 표시되는 항목(x축)
	                    labels: names,
	
	                    //실제로 차트에 표시될 값
	                    datasets: [
	                        {
	                            label: legend,//범례
	                            data: values,//데이터
	                            borderWidth: 1//디자인 속성(테두리 두께)
	                        },
	                    ]
	                },
	                options: {
	                    scales: {
	                        y: {
	                            beginAtZero: true//차트를 0부터 표기
	                        }
	                    }
	                }
	            });
	        }
	    });
	}
	
	
	$(function() {
	    // 차트 생성
		createChart("/rest/admin/status", ".admin-chart", "관리자 수");
	    createChart("/rest/worker/status",".worker-chart", "사원 수");
	});
	</script>

<div class="container w-800 my-50">
	<div class="row center">
		<h1>데이터베이스 현황</h1>
	</div>

	<div class="row flex-box">
		<div class="w-33">
			<div class="row center">
				<h2>관리자 현황</h2>
			</div>

			<div class="row">
				<!-- 차트 표시를 위한 캔버스 요소 -->
				<canvas class="admin-chart" width="400" height="200"></canvas>
			</div>
			<div class="row">
				<table class="table table-border">
					<thead>
						<tr>
							<th width="50%">관리자 등급</th>
							<th>관리자 수</th>
						</tr>
					</thead>
					<tbody align="center">
						<c:forEach var="statusVO" items="${adminStatusList}">
							<tr>
								<td>${statusVO.title}</td>
								<td>${statusVO.cnt}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<div class="w-33">
			<div class="row center">
				<h2>사원 현황</h2>
			</div>
			<div class="row">
				<!-- 차트 표시를 위한 캔버스 요소 -->
				<canvas class="worker-chart" width="400" height="200"></canvas>
			</div>
			<div class="row">
				<table class="table table-border">
					<thead>
						<tr>
							<th width="50%">사원 직급</th>
							<th>사원 수</th>
						</tr>
					</thead>
					<tbody align="center">
						<c:forEach var="statusVO" items="${workerStatusList}">
							<tr>
								<td>${statusVO.title}</td>
								<td>${statusVO.cnt}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>



</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>