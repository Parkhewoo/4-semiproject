<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<body>

<h2>Status List</h2>

<table border="1" class="table table-border table-stripe">
    
    <tbody>
        <c:forEach var="statusVO" items="${list}">
            <tr>
                <td>${statusVO.title}</td>
                <td>${statusVO.cnt}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>