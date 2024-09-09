<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
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
    
    .center {
        text-align: center;
    }
    .form-container {
        display: flex;
        gap: 10px;
        justify-content: center;
        margin-bottom: 20px;
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
        text-decoration: underline; /* 마우스를 올렸을 때 밑줄 추가 */
    }
    .link-animation {
        transition: color 0.3s ease; /* 색상 변경에 부드러운 전환 효과 추가 */
    }
</style>

<div class="container">
    <div class="row center">
        <h1>사업주 목록</h1>
        <form action="list" method="get" autocomplete="off">
            <div class="form-container"> 
                <select name="column" class="field w-22">
                    <option value="admin_id" <c:if test="${param.column == 'admin_id'}">selected</c:if>>아이디</option>
                    <option value="admin_no" <c:if test="${param.column == 'admin_no'}">selected</c:if>>사업자번호</option>
                    <option value="admin_rank" <c:if test="${param.column == 'admin_rank'}">selected</c:if>>관리등급</option>
                </select>
                <input type="text" name="keyword" value="${keyword}" class="field w-50">
               
                <button type="submit" class="btn">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    검색
                </button>
            </div>
        </form>
    </div>

    <div class="row">
        <table class="table">
            <thead>
                <tr>
                    <th>업주아이디</th>
                    <th>사업자번호</th>
                    <th>업주이메일</th>
                    <th>관리등급</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="adminDto" items="${list}">
                    <tr> 
                        <td>	
							
                            <a href="${pageContext.request.contextPath}/detail?adminId=${adminDto.adminId}&companyId=${adminDto.adminId}" class="link link-animation">${adminDto.adminId}</a>
 
                        </td>
                        <td>${adminDto.adminNo}</td>
                        <td>${adminDto.adminEmail}</td>
                     	<td>${adminDto.adminRank}</td>
                    </tr>
                </c:forEach>
            </tbody>  
        </table>  
    </div>
</div>

<div class="row center">
    <jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/navigator.jsp"/>
</div>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/footer.jsp"></jsp:include>