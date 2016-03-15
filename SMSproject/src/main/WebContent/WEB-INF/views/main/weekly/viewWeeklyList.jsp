<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>Bootstrap 101 Template</title>

<!-- Bootstrap -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link href="/assets/css/simple-sidebar.css" rel="stylesheet">
<link href="/assets/css/header.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

<style>
input:focus, textarea:focus{
    outline: none;
}
</style>
</head>
<body>
	<jsp:include page="../../include/header.jsp" />
	<div id="wrapper" class="">
		<!-- Sidebar -->
		<jsp:include page="../../include/sidebar.jsp" />
		<!-- Page Content -->
		<div id="page-content-wrapper">
			<div class="container-fluid xyz">
				<form class="form-horizontal">
					<div class="col-lg-6">
						<h1 class="text-center">주간계획 리스트</h1>
						<hr>
						<div class="form-group">
							<div class="table-responsive">
  							<table class="table table-bordered">
  								<tr>
  									<th>제목</th>
  									<th>기간</th>
  									<th>상태</th>
  									<th>등록일</th>
  								</tr>
  								<c:forEach items="${weeklyList}" begin="0" end="10" var="weekly" varStatus="status">
	  								<tr>
	  									<td><a href="viewWeeklyPlan?weeklyPlanId=${weekly.weeklyPlanId}">${weekly.title}</a></td>
	  									<td>${weekly.monday }</td>
	  									<td>${weekly.checked }</td>
	  									<td>${weekly.regDate }</td>
	  								</tr>
  								</c:forEach>
 							  </table>
							</div>
						</div>
						<div class="form-group">
							<div class="btn-toolbar col-sm-10" role="toolbar" aria-label="...">
								<c:forEach var="num" begin="1" end="${fn:length(weeklyList)/10 + 1}">
									<div class="btn-group" role="group" aria-label="${num}">
										<c:choose>
											<c:when test="${page=='weeklyListEmp'}">
												<a href="weeklyListEmp?empId=${weeklyList[0].employee.empId}&rownum=${(num-1)*10}" class="btn btn-default" role="button">${num}</a>
											</c:when>
											<c:when test="${page=='weeklyList'}">
												<a href="weeklyList?deptId=${weeklyList[0].employee.dept.deptId}&rownum=${(num-1)*10}" class="btn btn-default" role="button">${num}</a>
											</c:when>
										</c:choose>
									</div>
								</c:forEach>
							</div>
							<div class="btn-group col-sm-2">
								<a href="inputWeeklyPlan?empId=1&monday=16/03/21" class="btn btn-primary btn-lg" value="작성" role="button">작성</a>
							</div>
						</div>
					</div>
					<div class="col-lg-6"></div>
				</form>
			</div>
		</div>
	</div>


	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script src="/assets/js/sidebar_menu.js"></script>
</body>
</html>