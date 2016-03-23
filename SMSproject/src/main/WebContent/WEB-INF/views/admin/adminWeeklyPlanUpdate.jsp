<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>Bootstrap 101 Template</title>

<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.css">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.min.js"></script>
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<style type='text/css'>
#btn {
	vertical-align: bottom;
}
</style>
</head>
<body>

	<div class="form-horizontal">
		<div class="col-lg-3"></div>
			<div class="col-lg-6">
				<h1 class="text-center">주간계획작성</h1>
				<hr>
				<div class="form-group">
					<label class="col-sm-1 control-label" for="deptName">소속</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="deptName" readonly="readonly" value="${weeklyPlan.employee.dept.deptName }">
					</div>
					<label class="col-sm-1 control-label" for="empName">성명</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="empName" readonly="readonly" value="${weeklyPlan.employee.empName }">
					</div>
					<div class="col-sm-4">
						<div class="row">
							<label class="col-xs-4 control-label" for="regDate">작성일</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="regDate" readonly="readonly" value="${weeklyPlan.regDate }">
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-1 control-label" for="title">제목</label>
					<!-- <div class="col-sm-5">
						<select class="form-control" name="title" id="title">
							<option id="week2_1">2016년 2월 1주차</option>
							<option id="week2_2">2016년 2월 2주차</option>
							<option id="week2_3">2016년 2월 3주차</option>
							<option id="week2_4">2016년 2월 4주차</option>
						</select>
					</div> -->
					<div class="btn-group col-sm-5">
					  <button type="button" class="btn btn-default" style="width:90%;">${weeklyPlan.title}</button>
					  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					    <span class="caret"></span>
					    <span class="sr-only">Toggle Dropdown</span>
					  </button>
					  <ul class="dropdown-menu" id="title">
					  </ul>
					</div>
					<label class="col-sm-1 control-label" for="monday">날짜</label>
					<!-- <div class="col-sm-5">
						<select class="form-control" name="date" id="monday">
							<option id="week2_1">2016.02.01~2016.02.05</option>
							<option id="week2_2">2016.02.08~2016.02.12</option>
							<option id="week2_3">2016.02.15~2016.02.19</option>
							<option id="week2_4">2016.02.21~2016.02.25</option>
						</select>
					</div> -->
					<div class="btn-group col-sm-5">
					  <button type="button" id="mondayBtn" class="btn btn-default" style="width:90%;" >${weeklyPlan.monday}</button>
					  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					    <span class="caret"></span>
					    <span class="sr-only">Toggle Dropdown</span>
					  </button>
					  <ul class="dropdown-menu" id="monday">
					  </ul>
					</div>
				</div>
				<div class="form-group">
					<div class="table-responsive">
							<table class="table table-bordered" >
								<tr align="center">
									<th width="30">요일</th>
									<th style="text-align:center;" width="100">월 </th>
									<th style="text-align:center;" width="100">화</th>
									<th style="text-align:center;" width="100">수</th>
									<th style="text-align:center;" width="100">목</th>
									<th style="text-align:center;" width="100">금</th>
								</tr>
								<tr align="center">
									<th width="80">날짜</th>
									<c:forEach var="daily" items="${dailyPlanList }">
										<td style="text-align:center;">${daily.planDate }</td>
									</c:forEach>
								</tr>
								<tr>
									<th width="80">매출목표</th>
									<c:forEach var="daily" items="${dailyPlanList }">
										<td style="text-align:center;"><input type="text" class="form-control planDate" id="sales_${daily.planDate}" data-plan-date="${daily.planDate}" value="${daily.salesGoal }"/></td>
									</c:forEach>
								</tr>
								<tr height="300">
									<th width="80">내용</th>
									<c:forEach var="daily" items="${dailyPlanList }">
										<td align="center" width="100">
											<span id="${daily.planDate}"></span>
										</td>
									</c:forEach>
								</tr>
					  </table>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-10"></div>
					<div class="button-group col-sm-2">
					  <button class="btn-secondary btn-primary btn-lg" id="saveButton" onclick="btn_click();">저장</button>
					</div>
				</div>
			</div>
		<div class="col-lg-3"></div>
	</div>

	<script type="text/javascript">

	function btn_click(){
		//var map=new HashMap();
		var dailyPlanList = [];
		var dailyObject = {};
		$('.planDate').each(function() {
		  var dailyPlan = {};
		  dailyPlan.salesGoal = $(this).val();
		  dailyPlan.planDate = $(this).data('plan-date');
		  dailyPlanList.push(dailyPlan);
		  //var
		});
		console.log(dailyPlanList);
		dailyObject.dailyPlanList = dailyPlanList;
		console.log($.param(dailyObject));

		/* <c:forEach var="daily" items="${dailyPlanList }">
			var value=document.getElementById("sales_${daily.planDate}").value;
			map.put("${daily.planDate}", value);
		</c:forEach> */

		$.ajax({
			url:"/saveWeeklyPlan",
			type:"post",
			dataType:"json",
			data: {
			  monday : $('#mondayBtn').text(),
			  dailyPlanList : JSON.stringify(dailyPlanList)
			}
		});
	}

	$(document).ready(function(){
		titleMonday();
		addPlan();
	});

	function titleMonday(){
		// 현재날짜 설정
		var date=new Date();
		var dateEnd=new Date();
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
		dateEnd.setDate(dayOfMonth+4);
		for(var i=0;i<4;i++){
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
			var yearEnd=dateEnd.getFullYear();
			var monthEnd=dateEnd.getMonth()+1;
			if(monthEnd<10){
				monthEnd="0"+monthEnd;
			}
			var dayEnd=dateEnd.getDate();
			if(dayEnd<10){
				dayEnd="0"+dayEnd;
			}
			var dateStringEnd=yearEnd + "/" + monthEnd + "/" + dayEnd;
			$('<li><a href="checkWeeklyPlan?empId=${weeklyPlan.employee.empId}&monday='+dateString+'">'+dateString+'~'+dateStringEnd+'</a></li>').appendTo('#monday');
			dayOfMonth=date.getDate();
			date.setDate(dayOfMonth+7);
			dayOfMonth=dateEnd.getDate();
			dateEnd.setDate(dayOfMonth+7);
		}
		var monday="${weeklyPlan.monday}".substr(0,10);
		var mondayDate=new Date(monday);
		$('<li><a href="/admin/report/viewWeeklyPlanUpdateForm?weeklyPlanId=${weeklyPlan.weeklyPlanId}">${weeklyPlan.title}</a></li>').appendTo('#title');
	}

	function addPlan(){
		var list=new Array();
		<c:forEach var="daily" items="${dailyPlanList}">
			$.ajax({
				url:"/viewPlan?empId=${weeklyPlan.employee.empId}&planDate=${daily.planDate}",
				type:"post",
				dataType:"json",
				success:function(data){
					var span=document.getElementById("${daily.planDate}");
					console.log(span);
					var dataString=JSON.stringify(data);
					var strArray=dataString.split("\"");
					var type=strArray[1];
					if("eventDate"==type){
						span.innerHTML+="<div class=\"form-group has-error\" style=\"width:100%;\">"
							+"<input type=\"text\" readonly=\"readonly\" align=\"center\" class=\"form-control\" width\"20\" value="+data.title+">"
						  +"</div>";
					}else{
						var arrayList=data;
						if(arrayList!=""){
							for(var i=0;i<data.length;i++){
								span.innerHTML+="<div class=\"input-gourp\">"
											+"<form class=\"form-signin\" action=\"removePlan\" method=\"post\">"
											+ "<div class=\"input-group\" style=\"width:100%;\">"
											+		"<input type=\"text\" readonly=\"readonly\" class=\"form-control\" value="+data[i].content+">"
								      +		"<span class=\"input-group-btn\">"
								      +			"<input class=\"btn btn-secondary btn-danger\" type=\"submit\" value=\"X\"/>"
								      +		"</span>"
								      +	"</div>"
								      +	"<input type=\"hidden\" name=\"planId\" value="+data[i].planId+"><br>"
											+"</form></div>";
							}
						}
						span.innerHTML+="<div id=\"${daily.dailyPlanId}div\" class=\"input-gourp\">"
											+		"<div class=\"input-group\">"
											+		"<input id=\"${daily.dailyPlanId}text\" type=\"text\" class=\"form-control\" placeholder=\"Input Plan\" name=\"content\">"
										  +    "<span class=\"input-group-btn\">"
										  +      "<input id=\"${daily.dailyPlanId}addbtn\" class=\"btn btn-secondary btn-primary\" type=\"submit\" value=\"+\"/>"
										  +    "</span>"
											+	"</div>"
											+"</div>";
					}
					$("#${daily.dailyPlanId}addbtn").click(function(){
						$.ajax({
							url:"/admin/report/inputPlan",
							type:"post",
							data:{
								"dailyPlanId":"${daily.dailyPlanId}",
								"content":$("#${daily.dailyPlanId}text").val()
							},
							success:function(data){

								$("#${daily.dailyPlanId}div").before('<div class=\"input-gourp\">'
									+'<form class=\"form-signin\" action=\"removePlan\" method=\"post\">'
									+ '<div class=\"input-group\" style=\"width:100%;\">'
									+		'<input type=\"text\" readonly=\"readonly\" class=\"form-control\" value='+$("#${daily.dailyPlanId}text").val()+'>'
							        +		'<span class=\"input-group-btn\">'
							        +			'<input class=\"btn btn-secondary btn-danger\" type=\"submit\" value=\"X\"/>'
							        +		'</span>'
							        +	'</div>'
							        +	'<input type=\"hidden\" name=\"planId\" value='+data+'><br>'
									+'</form></div>');
								$("#${daily.dailyPlanId}text").val("");
							}
						});
					});
				}});
			</c:forEach>
	}


	</script>
</body>
</html>