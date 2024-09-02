<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="/css/commons.css">
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
        color: black;
        text-decoration: none;
    }
    .link:hover {
        color: #3498db;
        text-decoration: underline;
    }
    .link-animation {
        transition: color 0.3s ease;
    }
</style>

<div class="container">
    <div class="row center">
        <c:choose>
            <c:when test="${isSearch}">
                <h1>사원 검색</h1>
            </c:when>
            <c:otherwise>
                <h1>사원 목록</h1>
            </c:otherwise>
        </c:choose>
    </div>

    <form action="list" method="get" autocomplete="off">
        <div class="row center">
            <div class="form-container">
                <select name="column" class="field w-22">
                    <option value="worker_name" <c:if test="${param.column == 'worker_name'}">selected</c:if>>사원명</option>
                    <option value="worker_no" <c:if test="${param.column == 'worker_no'}">selected</c:if>>사원번호</option>
                    <option value="worker_rank" <c:if test="${param.column == 'worker_rank'}">selected</c:if>>직급</option>
                </select>
                <input type="text" name="keyword" value="${keyword}" class="field w-50">
                <button type="submit" class="btn">
                    검색
                </button>
            </div>
        </div>
    </form>

    <div class="row">
        <c:choose>
            <c:when test="${list.isEmpty()}">
                <h2 class="center">데이터가 존재하지 않습니다</h2>
            </c:when>
            <c:otherwise>
                <table class="table">
                    <thead>
                        <tr>
                            <th>사원명</th>
                            <th>사원번호</th>
                            <th>직급</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="workerDto" items="${list}">
                            <tr>
                                <td>
                                    <a href="detail?workerNo=${workerDto.workerNo}" class="link link-animation">${workerDto.workerName}</a>
                                </td>
                                <td>${workerDto.workerNo}</td>
                                <td>${workerDto.workerRank}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr align="right">
                            <td colspan="3">
                                <a href="add" class="link link-animation">신규등록</a>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="row center">
        <jsp:include page="/WEB-INF/views/template/navigator.jsp"/>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
