<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
 <form action="checkIn" method="post">
	<input type="number" name="no">
  	<button type="submit">출근</button>
  </form>
  
  <%--출근 기록 있을때만 가능하게 처리 --%>
   <form action="checkOut" method="post">
	<input type="number" name="no">
  	<button type="submit">퇴근</button>
  </form>
		
		


<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
