<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>Bootstrap 101 Template</title>
<link rel="stylesheet"
	href="${contextPath }/assets/calendar/fullcalendar.css">
<style>
input:focus, textarea:focus {
	outline: none;
}
</style>
</head>
<body>

	<form class="form-horizontal">
			<div class="form-group">
				<div id='calendar' align="left"></div>
			</div>
	</form>
	<div class="modal fade bs-example-modal-sm" id="calendarModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
						<span class="sr-only">close</span>
					</button>
					<h4 id="modalTitle" class="modal-title">일정 입력</h4>
				</div>
				<div id="modalBody" class="modal-body">
					<form class="form-inline">
						<div class="form-group">
							<label for="modalInputDate">날짜: </label>
							<input type="date" class="form-control" id="modalInputDate">
						</div>
					</form>
					<br>
					<form class="form-inline">
						<div class="form-group">
							<label for="modalInputPlan">입력 : </label>
							<input type="text" class="form-control" id="modalInputContent" >
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="modalSaveButton" onclick="modalClick();">Save</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="errorModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">ERROR</h4>
				</div>
				<div class="modal-body">
					<p>One fine body&hellip;</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div> <!-- /.modal-content -->
		</div> <!-- /.modal-dialog -->
	</div> <!-- /.modal -->
	<script type="text/javascript"
		src="${contextPath}/assets/calendar/lib/moment.min.js"></script>
	<script type="text/javascript"
		src="${contextPath}/assets/calendar/fullcalendar.js"></script>
	<script src="http://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {

			if("Manager"=="${LOGIN_USER.position}"){
				calendarEventManager();
			}else{
				calendarEvent();
			}

		});

		function calendarEventManager(){
			var calendar=$('#calendar').fullCalendar({
						height : 650,
						header : {
							left : 'prev, next today',
							center : 'title',
							right : ''
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
									empId : "${daily.weeklyPlan.employee.empId}",
									id : "PLAN"},
							</c:forEach>
								{
									title:'Weekend\nReport',
								  dow:[0],
								  className:'button',
									rendering:'background'
									}],
						eventClick : function(event){
							if(event.className=="PLAN"){
								$.ajax({
									url:"/calendarGetPlan?empId="+event.empId,
									type:"post",
									dataType:'json',
									success:function(data){
										$('#calendar').fullCalendar('removeEvents', "PLAN");
										var plan=data.Plan;
										for(var i=0;i<plan.length;i++){
											var myPlan={};
											myPlan.title=plan[i].content;
											myPlan.start=plan[i].dailyPlan.planDate.substring(0, 10);
											$('#calendar').fullCalendar('renderEvent', myPlan, true);
										}

									}
								});
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
							}else{
								location.reload();
							}
						},
						eventLimit : true
				});
		}

		function checkDate(date){
			$.ajax({
				url:"/checkDailyPlan?empId=${LOGIN_USER.empId}&planDate="+date,
				type:"post",
				dataType:"json",
				success:function(data){
					var date=new Date();
					if(data==false){
						document.getElementById("modalInputContent").readonly="readonly";
						document.getElementById("modalInputContent").value="";
						document.getElementById("modalInputContent").disabled="disabled";
						document.getElementById("modalInputContent").placeholder="일정을 등록할 수 없습니다.";
						document.getElementById("modalSaveButton").disabled="disabled";
					}else{
						document.getElementById("modalInputContent").readonly=false;
						document.getElementById("modalInputContent").disabled=false;
						document.getElementById("modalInputContent").placeholder="";
						document.getElementById("modalSaveButton").disabled=false;
					}
				}
			});
		}

		$('input[type="date"]').change(function(){
			checkDate(this.value);
		});


		function calendarEvent() {
			var calendar = $('#calendar')
					.fullCalendar(
							{
								height : 650,
								header : {
									left : 'prev, next today',
									center : 'title',
									right : ''
								},
								editable : false,
								events : [
									   <c:forEach var="plan" items="${planList}">
											{title : "${plan.content}",
											start : "${plan.dailyPlan.planDate}".substring(0, 10),
											className : "PLAN"},
										</c:forEach>
										<c:forEach var="event" items="${eventList}">
											{title : "${event.title}",
											start : "${event.eventDate}".substring(0,10),
											color: '#257e4a',
											className : "EVENT"},
										</c:forEach>
											{
												title:'Weekend\nReport',
											  dow:[0],
											  className:'button',
												rendering:'background'
											}],
								fixedWeekCount : true,
								eventClick : function(event) {
								},
								eventLimit : true,
								dayClick : function(date, jsEvent, view) {
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
										location.href="/checkWeeklyPlan?empId=${LOGIN_USER.empId}&monday="+monday;
									}else{
										document.getElementById('modalInputDate').value = date.format();
										checkDate(date.format());
										$('#calendarModal').modal();
									}
								},
								dayNamesShort:['주간계획', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
							});
		}

		function modalClick() {
			var planDate = document.getElementById('modalInputDate').value;
			var content = document.getElementById('modalInputContent').value;
			if (content == "") {
				$('#calendarModal').modal();
			} else {
				$.ajax({
						url : "/inputPlanCalendar?empId=${LOGIN_USER.empId}&planDate=" + planDate + "&content=" + content,
						type : "post"
					});
			}
			location.reload();
		}

		$('table.calendar > tbody > tr > td:nth-child(-n+2)')
		.addClass('fc-sat');
	</script>
</body>
<style type='text/css'>
	.fc-sat { color:blue; }
	.fc-sun { color:red;  }
</style>
</html>