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
		<a href="/">
            <img src="/images/mainLogo.png" style="width:85px">
        </a>
    <c:choose>
        <c:when test="${sessionScope.createdUser != null}">
            <ul class="menu">
                <!-- 사용자 등급별 메뉴 -->
                <c:choose>
                    <c:when test="${sessionScope.createdRank == '시스템 관리자'}">
                        <li>
                            <a href="/sysadmin/home">시스템관리자 메뉴</a>
                        </li>
                    </c:when>

                    <c:when test="${sessionScope.createdRank == '일반 관리자'}">
                        <li>
                            <a href="/admin/mypage">마이페이지</a>
                        </li>
                        <li>
                            <a href="/admin/worker/list">사원 관리</a>
                        </li>
                        <li>
                            <a href="#">QNA</a>
                            <ul>
                                <li><a href="/qna/list">문의목록</a></li>
                                <li><a href="/qna/write">문의하기</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">관리자 메뉴</a>
                            <ul>
                                <li>
                                    <a href="/admin/worker/list">사원정보보기</a>
                                </li>
                            </ul>
                        </li>
                    </c:when>
                    
                    <c:otherwise>
                        <li><a href="/worker/attendance">나의 출석률<br>보기</a></li>
                        <li><a href="/worker/mypage">마이 페이지</a></li>
                    </c:otherwise>
                </c:choose>

                <!-- 모든 사용자 공통 메뉴 -->
                <li class="right-menu">
                    <a href="#">
                        ${sessionScope.createdUser} 님
                    </a>
                    <ul>
                        <li>
                            <a href="/admin/logout">로그아웃</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </c:when>
        
        <c:otherwise>
            <!-- 비로그인 상태일 때 회원가입 메뉴 -->
            <ul class="menu">
                <li class="right-menu">
                    <a href="/admin/join">회원가입</a>
                </li>
            </ul>
        </c:otherwise>
    </c:choose>
</div>
