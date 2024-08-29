<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp를 이용한 달력</title>
</head>
<body>
<%
Calendar cr = Calendar.getInstance();
int year = cr.get(Calendar.YEAR);
int month = cr.get(Calendar.MONTH);
int date = cr.get(Calendar.DATE);
String today = year + ":" +(month+1)+ ":"+date; // 오늘 날짜
// 1일부터 시작하는 달력을 만들기 위해 오늘의 연도,월을 셋팅하고 일부분은 1을 셋팅한다.
cr.set(year, month, 1);

// 셋팅한 날짜로 부터 아래 내용을 구함

// 해당 월의 첫날를 구함
int startDate = cr.getMinimum(Calendar.DATE);

// 해당 월의 마지막 날을 구함
int endDate = cr.getActualMaximum(Calendar.DATE);

// 1일의 요일을 구함
int startDay = cr.get(Calendar.DAY_OF_WEEK);
int count = 0;
%>
<table width="400" cellpadding="2" cellspacing="0" border="1" align="center">
 <tr height="30">
  <td><font size="2">일</font></td>
  <td><font size="2">월</font></td>
  <td><font size="2">화</font></td>
  <td><font size="2">수</font></td>
  <td><font size="2">목</font></td>
  <td><font size="2">금</font></td>
  <td><font size="2">토</font></td>
 </tr>
 <tr height="30">
<%
for (int i=1;i<startDay;i++){
 count++;
%>
        <td>&nbsp;</td>
<% 
}
for (int i=startDate;i<=endDate;i++){
 String bgcolor = (today.equals(year+":"+(month+1)+":"+i))? "#CCCCCC" : "#FFFFFF";
 String color = (count%7 == 0 || count%7 == 6)? "red" : "black";
 count++;
%> 
  <td bgcolor="<%=bgcolor %>"><font size="2" color=<%=color %>><%=i %></font></td>
<%
  if(count%7 == 0 && i < endDate){
%> 
 </tr>
 <tr height="30">
<%
  }
}
while(count%7 != 0){
%>
       <td>&nbsp;</td>
<% 
count++;
 }
%>
</tr>  
</table>
</body>
</html> 
출처: https://gusfree.tistory.com/937 [Bohemian life:티스토리]