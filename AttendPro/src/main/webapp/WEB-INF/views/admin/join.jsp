<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<form action="join" method="post">
	<div class="container w-600 my-50">
		<div class="row center">
			<h1>회원가입</h1>
		</div>
		<div class="row">
			<label>아이디</label> <input name="adminId" type="text"
				placeholder="영문소문자 시작, 숫자 포함 8~20자">
		</div>
		<div class="row">
			<label>비밀번호</label> <input name="adminPw" type="password"
				placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함">
		</div>
		<div class="row">
		<label>사업자 번호</label>
		<input name="adminNo" type="text">
		</div>
		<div class="row">
			<button type="submit">등록하기</button>
		</div>
	</div>
</form>