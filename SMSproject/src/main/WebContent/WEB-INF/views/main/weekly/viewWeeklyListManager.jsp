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

<style>
input:focus, textarea:focus{
    outline: none;
}
</style>
</head>
<body>
	<form class="form-horizontal">
			<h1 class="text-center">주간계획 리스트</h1>
			<hr>
			<div class="form-group">
				<div class="table-responsive">
						<table class="table table-bordered">
							<tr>
								<th>작성자</th>
								<th>제목</th>
								<th>기간</th>
								<th>상태</th>
								<th>등록일</th>
							</tr>
							<c:forEach items="${weeklyList}" begin="0" end="10" var="weekly" varStatus="status">
								<tr>
									<td><a href="weeklyListEmp?empId=${weekly.employee.empId}&rownum=0">${weekly.employee.empName}</a></td>
									<td><a href="viewWeeklyPlan?weeklyPlanId=${weekly.weeklyPlanId}">${weekly.title}</a></td>
									<td>${weekly.monday }</td>
									<td>${weekly.checked }</td>
									<td>${weekly.regDate }</td>
								</tr>
							</c:forEach>
					  </table>
				</div>
			</div>
			<div class="btn-group">
				<div class="btn-toolbar" role="toolbar" aria-label="...">
					<c:if test="${begin!=1}">
						<c:choose>
							<c:when test="${page=='weeklyListEmp'}">
								<a href="weeklyListEmp?empId=${LOGIN_USER.empId}&rownum=${(begin-2)*10}" class="btn btn-default" role="button">...</a>
							</c:when>
							<c:when test="${page=='weeklyList'}">
								<a href="weeklyList?deptId=${LOGIN_USER.dept.deptId}&rownum=${(begin-2)*10}" class="btn btn-default" role="button">...</a>
							</c:when>
							<c:when test="${page=='weeklyListWeek'}">
								<a href="weeklyListWeek?deptId=${LOGIN_USER.dept.deptId}&monday=${monday}&rownum=${(begin-2)*10}" class="btn btn-default" role="button">...</a>
							</c:when>
						</c:choose>
					</c:if>
					<c:forEach var="num" begin="${begin}" end="${end}">
						<div class="btn-group" role="group" aria-label="${num}">
							<c:choose>
								<c:when test="${page=='weeklyListEmp'}">
									<c:choose>
										<c:when test="${(rownum/10+1) == num}">
											<a href="weeklyListEmp?empId=${LOGIN_USER.empId}&rownum=${(num-1)*10}" style="color: #aaaaaa;" class="btn btn-default" role="button">${num}</a>
										</c:when>
										<c:otherwise>
											<a href="weeklyListEmp?empId=${LOGIN_USER.empId}&rownum=${(num-1)*10}" class="btn btn-default" role="button">${num}</a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${page=='weeklyList'}">
									<c:choose>
										<c:when test="${(rownum/10+1) == num}">
											<a href="weeklyList?deptId=${LOGIN_USER.dept.deptId}&rownum=${(num-1)*10}" style="color: #aaaaaa;" class="btn btn-default" role="button">${num}</a>
										</c:when>
										<c:otherwise>
											<a href="weeklyList?deptId=${LOGIN_USER.dept.deptId}&rownum=${(num-1)*10}" class="btn btn-default" role="button">${num}</a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${page=='weeklyListWeek'}">
									<c:choose>
										<c:when test="${(rownum/10+1) == num}">
											<a href="weeklyListWeek?deptId=${LOGIN_USER.dept.deptId}&monday=${monday}&rownum=${(begin-2)*10}" style="color: #aaaaaa;" class="btn btn-default" role="button">${num}</a>
										</c:when>
										<c:otherwise>
											<a href="weeklyListWeek?deptId=${LOGIN_USER.dept.deptId}&monday=${monday}&rownum=${(begin-2)*10}" class="btn btn-default" role="button">${num}</a>
										</c:otherwise>
									</c:choose>
								</c:when>
							</c:choose>
						</div>
					</c:forEach>
					<c:if test="${end<(count/10)}">
						<c:choose>
							<c:when test="${page=='weeklyListEmp'}">
								<a href="weeklyListEmp?empId=${LOGIN_USER.empId}&rownum=${end*10}" class="btn btn-default" role="button">...</a>
							</c:when>
							<c:when test="${page=='weeklyList'}">
								<a href="weeklyList?deptId=${LOGIN_USER.dept.deptId}&rownum=${end*10}" class="btn btn-default" role="button">...</a>
							</c:when>
							<c:when test="${page=='weeklyListWeek'}">
								<a href="weeklyListWeek?deptId=${LOGIN_USER.dept.deptId}&monday=${monday}&rownum=${(begin-2)*10}" class="btn btn-default" role="button">...</a>
							</c:when>
						</c:choose>
					</c:if>
				</div>
			</div>
	</form>

</body>
</html>