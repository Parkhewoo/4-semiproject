<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- my css -->
    <link rel="stylesheet" type="text/css" href="/css/commons.css">
    <style>
 ul. {
 font-size: 10px;
 }
</style>
<!-- 
	메뉴(Navbar)
-->
<div class="container w-1000 my-50">
        <div class="row">
            <ul class="menu">
            <li>
            <a href="/">홈으로</a>
            </li>

				<li>
                    <a href="#">데이터</a>
                    <ul>
                        <li>
                           <a href="admin/worker/list">사원목록</a>
                        </li>
                    </ul>
                </li>

                <li class="right-menu">
                    <a href="#">메뉴</a>
                    <ul>
                        <li>
                        	<a href="#">회원 로그인</a>
                           <a href="/admin/join">회원가입</a>
                           <a href="/admin/login">관리자 로그인</a>
                           <a href="/admin/logout">로그아웃</a>
                           
                        </li>
                    </ul>
                </li>
            </ul>
    </div>
    </div>