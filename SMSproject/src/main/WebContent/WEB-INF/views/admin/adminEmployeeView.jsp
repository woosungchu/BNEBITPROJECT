<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<style type='text/css'>

/*-------------------------
	General Styles
--------------------------*/

td#profileTd{
	background: url('${contextPath}/assets/image/adminEmployeeBackGround.jpg') #383839;
	background-attachment:fixed;
}

section{
	display:block;
}

/*----------------------------
		Headers
-----------------------------*/

header{
	display: block;
	margin-bottom: 12px;
}

h5{
	font-size:64px;
	font-weight:normal;
	margin-bottom: 12px;
	line-height:1;
	text-shadow:2px 2px 0 rgba(22,22,22,0.5);
	color: aqua;
}

h2{
	color: #202020;
	font-size: 18px;
	font-weight: normal;
	text-shadow: 1px 1px 0 rgba(255, 255, 255, 0.1);
	padding: 15px 0;
	font-style: oblique;
}

/*----------------------------
		Content Area
-----------------------------*/

#infoPage img{
	float:left;
	margin-left:-200px;

	-moz-box-shadow: 2px 2px 0 #303030;
	-webkit-box-shadow: 2px 2px 0 #303030;
	box-shadow: 2px 2px 0 #303030;
}

#infoPage{
	width:455px;
	margin:20px;
	padding: 0 0 100px 200px;
	border-bottom:1px solid #333;
	background:url('${contextPath}/assets/image/adminEmployeeBackGround2.jpg');
}

p.description{
	background-color: rgba(255, 255, 255, 0.05);
	padding: 25px;
	text-shadow: 1px 1px 0 #333333;
	margin-bottom: 35px;

	-webkit-box-shadow: 2px 2px 0 rgba(22, 22, 22, 0.1);
	-moz-box-shadow: 2px 2px 0 rgba(22, 22, 22, 0.1);
	box-shadow: 2px 2px 0 rgba(22, 22, 22, 0.1);

	color: white;
}

/*----------------------------
	The Footer
-----------------------------*/

footer{
	display:block;
	background-color:#212121;
	box-shadow: 0 -1px 2px #111;
	position:fixed;
	width:100%;
	height:70px;
	bottom:0;
	left:0;
	z-index: 100000;
}

footer h2{
	font-size:20px;
	font-weight:normal;
	left:50%;
	margin-left:-400px;
	padding:22px 0;
	position:absolute;
	width:400px;
	color:#eee;
}

footer a.tzine,a.tzine:visited{
	border:none;
	text-decoration:none;
	color:#FCFCFC;
	font-size:12px;
	height:70px;
	left:50%;
	line-height:31px;
	margin:23px 0 0 110px;
	position:absolute;
	top:0;
	width:290px;
}

	</style>
		<title>직원 상세 정보</title>
		<h1 align="center" style="color: gray;">${requestScope.EMPLOYEE.empName} 직원 정보</h1>
		<hr width="700"><br>
			<table>
			<tr>
				<td id="profileTd">
					<section id="infoPage">
						<c:choose>
							<c:when test="${requestScope.EMPLOYEE.imgName  != 'NONAME'}">
								<img src="/Upload/${requestScope.EMPLOYEE.imgName}" width="164" height="164">
							</c:when>
							<c:otherwise>
								<img src="<c:url  value='${contextPath}/assets/image/noname.png'/>" width="164" height="164">
							</c:otherwise>
						</c:choose>
			            <header>
			                <h5>${requestScope.EMPLOYEE.empName}</h5>
			                <h2>BBT Company. ${requestScope.EMPLOYEE.position}.</h2>
			            </header>
			            <p class="description">
			            	E-mail : ${requestScope.EMPLOYEE.email}<br>
			            	성명 : ${requestScope.EMPLOYEE.empName}<br>
			            	직급 : ${requestScope.EMPLOYEE.position}<br>
			            	소속 : ${requestScope.EMPLOYEE.dept.deptName}<br>
			            	연락처 : ${requestScope.EMPLOYEE.phone}<br>
			            	계정 상태 : ${requestScope.EMPLOYEE.state}<br>
			            </p>
					</section>
				</td>
		    </tr>
			</table><br/>
			<p align="center">
				<a href="/admin/employee/employeeList"><button class="basicButton">돌아가기</button></a>
				<a href="/admin/employee/viewEmployeeUpdateForm?empId=${requestScope.EMPLOYEE.empId}"><button id="updateEmployee" class="basicButton">수정</button></a>
				<a href="/admin/employee/deleteEmployee?empId=${requestScope.EMPLOYEE.empId}"><button class="basicButton">삭제</button></a>
			</p>
