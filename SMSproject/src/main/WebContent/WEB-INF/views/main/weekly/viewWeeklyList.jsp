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
								<th>제목</th>
								<th>기간</th>
								<th>상태</th>
								<th>등록일</th>
							</tr>
							<c:forEach items="${weeklyList}" begin="0" end="10" var="weekly" varStatus="status">
								<tr>
									<td><span id="viewOrEdit_${weekly.weeklyPlanId}" ></span></td>
									<td id="tdMonday_${weekly.weeklyPlanId}">${weekly.monday }</td>
									<td>${weekly.checked }</td>
									<td>${weekly.regDate }</td>
								</tr>
							</c:forEach>
					  </table>
				</div>
			</div>
			<div class="form-group">
				<div class="btn-toolbar col-sm-10" role="toolbar" aria-label="...">
					<c:if test="${begin!=1}">
						<c:choose>
							<c:when test="${page=='weeklyListEmp'}">
								<a href="weeklyListEmp?empId=${LOGIN_USER.empId}&rownum=${(begin-2)*10}" class="btn btn-default" role="button">...</a>
							</c:when>
							<c:when test="${page=='weeklyList'}">
								<a href="weeklyList?deptId=${LOGIN_USER.dept.deptId}&rownum=${(begin-2)*10}" class="btn btn-default" role="button">...</a>
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
						</c:choose>
					</c:if>
				</div>
				<div class="btn-group col-sm-2">
					<span id="button"></span>
				</div>
			</div>
	</form>

	<script type="text/javascript">
		$(document).ready(function(){
			addButton();
			viewOrEdit();
		});

		function viewOrEdit(){
			var date=new Date();
			var year=date.getFullYear();
			var month=date.getMonth()+1;
			if(month<10){
				month="0"+month;
			}
			var day=date.getDate();
			if(day<10){
				day="0"+day;
			}
			var dateString=year+"/"+month+"/"+day;
			<c:forEach items="${weeklyList}" begin="0" end="10" var="weekly" varStatus="status">
				var tdMonday=$('#tdMonday_${weekly.weeklyPlanId}').text();
					var monday=tdMonday.substring(0,10);
					var span=document.getElementById("viewOrEdit_${weekly.weeklyPlanId}");
					if(dateString<monday){
						span.innerHTML+="<a href=\"editWeeklyPlan?weeklyPlanId=${weekly.weeklyPlanId}\">${weekly.title}</a>";
					}else{
						span.innerHTML+="<a href=\"viewWeeklyPlan?weeklyPlanId=${weekly.weeklyPlanId}\">${weekly.title}</a>";
					}
			</c:forEach>
		}

		function addButton(){
			var date=new Date();
			var dayOfMonth=date.getDate();
			var day=date.getDay();
			// 현재를 기준으로 그 다음주의 monday 구하기
			switch(day){
			case 1:
				dayOfMonth+=7;
				break;
			case 2:
				dayOfMonth+=6;
				break;
			case 3:
				dayOfMonth+=5;
				break;
			case 4:
				dayOfMonth+=4;
				break;
			case 5:
				dayOfMonth+=3;
				break;
			}
			date.setDate(dayOfMonth);
			var year=date.getFullYear();
			var month=date.getMonth()+1;
			if(month<10){
				month="0"+month;
			}
			var day=date.getDate();
			if(day<10){
				day="0"+day;
			}
			var dateString=year + "/" + month + "/" + day;

			var span=document.getElementById("button");
			span.innerHTML+="<a href=\"checkWeeklyPlan?empId=${LOGIN_USER.empId}&monday="+dateString+"\" class=\"btn btn-primary btn-lg\" role=\"button\">작성</a>";

		}
	</script>
</body>
</html>