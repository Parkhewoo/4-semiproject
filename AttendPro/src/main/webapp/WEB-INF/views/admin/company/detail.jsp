<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .container {    
       	width: 80%;
        max-width: 1200px;
        margin: 40px auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .row {
        margin-bottom: 20px;
    }

    .table-info, .block-list-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px;
    }

    .table-info th, .table-info td,
    .block-list-table th, .block-list-table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
        font-size: 16px;
    }

    .table-info th, .block-list-table th {
        background-color: #f4f4f4;
        border-bottom: 2px solid #ddd;
        font-size: 18px;
    }

    .table-info tr:last-child td,
    .block-list-table tr:last-child td {
        border-bottom: none;
    }

    .info-message, .status-message-negative, .status-message-positive {
        text-align: center;
        font-size: 16px;
        margin: 10px 0;
        padding: 10px;
    }

    .status-admin {
        text-align: center;
        font-size: 16px;
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
        margin-top: 20px;
    }

    .links a {
        text-decoration: none;
        color: #3498db;
        font-weight: bold;
        margin: 0 10px;
        font-size: 16px;
    }

    .links a:hover {
        text-decoration: underline;
    }

    .pagination {
        text-align: center;
        margin-top: 20px;
    }

    .pagination a {
        text-decoration: none;
        color: #3498db;
        margin: 0 5px;
        font-size: 16px;
    }

    .pagination strong {
        font-size: 16px;
        font-weight: bold;
    }

    .kakao-map {
        width: 100%;
        height: 400px;
        margin-top: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
    }
    
/*     .btn { */
/*         padding: 8px 15px; */
/*         font-size: 16px; */
/*         color: #fff; */
/*         background-color: #3498db; */
/*         border: none; */
/*         border-radius: 4px; */
/*         cursor: pointer; */
/*     } */
     .btn {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 10px 20px;
    margin: 5px;
    font-size: 16px;
    color: #fff;
    background-color: none;
    border: none;
    border-radius: 4px;
    text-align: center;
    text-decoration: none;
    cursor: pointer;
    transition: background-color 0.3s; /* 배경색 변경 시 부드러운 효과 */
}

.btn:hover {
    background-color: lightgray;
}
.links {
    text-align: center;
}

.links a {
    text-decoration: none;
    color: black;
    font-weight: bold;
    margin: 0 15px;
}

.links a:hover {
    text-decoration: underline;
}

</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a52f3e01da4d8f6dba534fb01a2c42ef&libraries=services"></script>
<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        var container = document.querySelector(".kakao-map");
        var options = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567),
            level: 3
        };

        var map = new kakao.maps.Map(container, options);
        var geocoder = new kakao.maps.services.Geocoder();

        // 회사 주소 정보
        var companyPost = '${companyDto.companyPost}'.trim();
        var companyAddress = '${companyDto.companyAddress1}'.trim();

        // 주소 검색 함수
        function searchAddress(address) {
            console.log('Searching for address:', address);
            return new Promise((resolve, reject) => {
                geocoder.addressSearch(address, function(result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        resolve(result[0]);
                    } else {
                        reject(status);
                    }
                });
            });
        }

        // 주소 검색 시도
        async function tryAddressSearch() {
            try {
                // 첫 번째 시도: 우편번호 + 주소
                let result = await searchAddress(companyPost + ' ' + companyAddress);
                return result;
            } catch (error) {
                console.log('First attempt failed, trying without postcode...');
                try {
                    // 두 번째 시도: 주소만
                    let result = await searchAddress(companyAddress);
                    return result;
                } catch (error) {
                    console.log('Second attempt failed, trying with modified address...');
                    // 세 번째 시도: 주소 수정 (예: '2로' -> '2길')
                    let modifiedAddress = companyAddress.replace('2로', '2길');
                    try {
                        let result = await searchAddress(modifiedAddress);
                        return result;
                    } catch (error) {
                        throw new Error('모든 주소 검색 시도가 실패했습니다.');
                    }
                }
            }
        }

        // 주소 검색 실행 및 결과 처리
        tryAddressSearch()
            .then((data) => {
                var coords = new kakao.maps.LatLng(data.y, data.x);
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:200px;text-align:center;padding:6px 0;">' +
                             '<strong>${companyDto.companyName}</strong><br>' +
                             data.address.address_name +
                             '</div>'
                });
                infowindow.open(map, marker);

                map.setCenter(coords);
            })
            .catch((error) => {
                console.error('주소를 찾을 수 없습니다:', error);
                alert('회사 주소를 찾을 수 없습니다. 입력된 주소를 확인해 주세요.');
                container.innerHTML = '<p style="text-align:center;padding:20px;">주소를 찾을 수 없습니다: ' + companyPost + ' ' + companyAddress + '</p>';
            });
    });
</script>

<head>
<div class="container">
<div class="center">
    <h1>${companyDto.companyName}</h1>
</div>

    <!-- 에러 메시지 표시 -->
    <c:if test="${not empty error}">
        <div class="info-message">${error}</div>
    </c:if>

    <c:choose>
        <c:when test="${companyDto == null}">
            <div class="row">
                <h2>사업장이 존재하지 않습니다.</h2>
            </div>
        </c:when>
        <c:otherwise>
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
                    <th>출근시간 </th>
                    <td class="status-admin">${companyDto.companyIn}</td>
                </tr>
                <tr>
                    <th>퇴근시간 </th>
                    <td class="status-admin">${companyDto.companyOut}</td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td class="status-admin">${companyDto.companyPost} ${companyDto.companyAddress1} ${companyDto.companyAddress2}</td>
                </tr>
            </table>

            <!-- 지도 표시 -->
            <div class="kakao-map"></div>

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
            <div class="row center">
            <h2>휴일</h2>
            <jsp:include page="/WEB-INF/views/template/calendar.jsp"></jsp:include>
			</div>
<!-- 			<div class="links"> -->
<%-- 			<a href="/admin/company/set?companyId=${sessionScope.createdUser}" class="btn">수정하기</a> --%>
<!-- 			</div> -->
<!--            
 <div class="links"> -->
<%--                 <h2><a href="set?companyId=${companyDto.companyId}">회사정보 수정</a></h2> --%>
<!--             </div> -->
            
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>