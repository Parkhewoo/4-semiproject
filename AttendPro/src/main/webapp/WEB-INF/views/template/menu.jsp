<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 
    메뉴(Navbar)
    - 템플릿 페이지의 모든 경로는 전부 절대 경로로 사용 
    - 로그인 상태일 때와 비로그인 상태일 때 다르게 표시
    - 로그인 상태 : sessionScope.createdUser != null
-->

<!-- 메뉴를 감싸는 div -->
<div class="menu-container">

    <c:choose>
        <c:when test="${sessionScope.createdUser != null}">
            <ul class="menu">
            <li>
            <a href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/images/mainLogo.png" style="width:75px">
        </a>
            </li>
                <!-- 사용자 등급별 메뉴 -->
                <c:choose>
                    <c:when test="${sessionScope.createdRank == '시스템 관리자'}">
                       
                    </c:when>

                    <c:when test="${sessionScope.createdRank == '일반 관리자'}">
                        <li>
                            <a href="${pageContext.request.contextPath}/admin/mypage">마이페이지</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/admin/worker/list">사원 관리</a>
                        </li>
                        <li>
                            <a href="#">QNA</a>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/qna/adminList">문의목록</a></li>
                                <li><a href="${pageContext.request.contextPath}/qna/write">문의하기</a></li>
                            </ul>
                      </li>                       

                    </c:when>
                    
                    <c:otherwise>
                        <li><a href="${pageContext.request.contextPath}/worker/attendance">나의 출석률<br>보기</a></li>
                        <li><a href="${pageContext.request.contextPath}/worker/mypage">마이 페이지</a></li>
                    </c:otherwise>
                </c:choose>

                <!-- 모든 사용자 공통 메뉴 -->
                <li class="right-menu">
                    <a href="#">
                        ${sessionScope.createdUser} 님
                    </a>
                    <ul>
                        <li>
                            <a href="${pageContext.request.contextPath}/admin/logout">로그아웃</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </c:when>
        
        <c:otherwise>
            <!-- 비로그인 상태일 때 회원가입 메뉴 -->
            <ul class="menu">
            <li>
            <a href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/images/mainLogo.png" style="width:75px">
        </a>
            </li>
                <li class="right-menu">
                    <a href="${pageContext.request.contextPath}/admin/join">회원가입</a>
                </li>
            </ul>
        </c:otherwise>
    </c:choose>
</div>
