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
<link rel="stylesheet" href="${contextPath }/assets/calendar/fullcalendar.css">
<style>
input:focus, textarea:focus{
    outline: none;
}
</style>
</head>
<body>
	<form class="form-horizontal">
			<h1 class="text-center">Calendar(팀장)</h1>
			<hr>
			<div class="form-group">
				<div id='calendar' align="left"></div>
			</div>
	</form>

<script type="text/javascript" src="${contextPath}/assets/calendar/lib/moment.min.js"></script>
<script type="text/javascript" src="${contextPath}/assets/calendar/fullcalendar.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			// 현재날짜 구하기
			var date=new Date();
			var d=date.getDate();
			var m=date.getMonth();
			var y=date.getFullYear();

			calendarEvent();
		});

		function calendarEvent(){
			var calendar=$('#calendar').fullCalendar({
						height : 650,
						header : {
							left : 'prev, next today',
							center : 'title',
							right : 'month'
						},
						editable : false,
						eventLimit : false,
						events : [
							<c:forEach var="event" items="${eventList}">
								{title : "${event.title}",
								start : "${event.eventDate}".substring(0,10),
								color: '#257e4a',
								className : "EVENT"},
							</c:forEach>
							<c:forEach var="daily" items="${dailyPlanList}">
									{title : "${daily.weeklyPlan.employee.empName}",
									start : "${daily.planDate}".substring(0,10),
									className : "PLAN",
									empId : "${daily.weeklyPlan.employee.empId}"},
							</c:forEach>
								{
									title:'Weekend\nReport',
								  dow:[0],
								  className:'button',
									rendering:'background'
									}],
						eventClick : function(event){
							alert(event.title);
							if(event.className=="PLAN"){
								location.href="calendarPlan?empId="+event.empId;
							}
						},
						dayClick:function(date){
							var dateString=new Date(date);
							var sun=dateString.getDay();
							if(sun=="0"){
								var dayOfMonth=dateString.getDate();
								dateString.setDate(dayOfMonth+1);
								var year=dateString.getFullYear();
								var month=dateString.getMonth()+1;
								if(month<10){
									month="0"+month;
								}
								var day=dateString.getDate();
								if(day<10){
									day="0"+day;
								}
								var monday=year+"/"+month+"/"+day;
								location.href="/weeklyListWeek?deptId=${LOGIN_USER.dept.deptId}&monday="+monday+"&rownum=0";
							}
						},
						eventLimit : true
				});
		}
	</script>
</body>
</html>