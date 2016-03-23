<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>직원 상세 정보</title>
	</head>
	<body>
		<h1 align="center" style="color: gray;">${requestScope.EMPLOYEE.empName} 직원 정보</h1>
		<hr width="700"><br>
			<table style="border-color: white;" border="1">
			<tr bgcolor="white">
				 <td>
				 	<c:choose>
						<c:when test="${requestScope.EMPLOYEE.imgName  != 'NONAME'}">
							<img src="/Upload/${requestScope.EMPLOYEE.imgName}" width="150px">
						</c:when>
						<c:otherwise>
							<img src="<c:url  value='${contextPath}/assets/image/noname.png'/>" width="150px">
						</c:otherwise>
					</c:choose>
				 </td>
			     <td width="80">
					<strong>E-mail<br>
							성명<br>
							직급<br>
							소속<br>
							연락처<br>
							계정상태<br></strong>
				</td>
				<td>
			        :&nbsp;&nbsp;${requestScope.EMPLOYEE.email}<br>
			        :&nbsp;&nbsp;${requestScope.EMPLOYEE.empName}<br>
			        :&nbsp;&nbsp;${requestScope.EMPLOYEE.position}<br>
			        :&nbsp;&nbsp;${requestScope.EMPLOYEE.dept.deptName}<br>
			        :&nbsp;&nbsp;${requestScope.EMPLOYEE.phone}<br>
			        :&nbsp;&nbsp;${requestScope.EMPLOYEE.state}<br>
				</td>
		        <td width="500"></td>
		    </tr>
			</table><br/>
			<p align="center">
				<a href="/admin/employee/employeeList"><button style="width: 120px; height: 25px">돌아가기</button></a>
				<a href="/admin/employee/viewEmployeeUpdateForm?empId=${requestScope.EMPLOYEE.empId}"><button id="updateEmployee" style="width: 120px; height: 25px">수정</button></a>
				<a href="/admin/employee/deleteEmployee?empId=${requestScope.EMPLOYEE.empId}"><button style="width: 120px; height: 25px">삭제</button></a>
			</p>
	</body>
</html>