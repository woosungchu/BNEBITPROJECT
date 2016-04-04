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

<style type='text/css'>
#btn {
	vertical-align: bottom;
}
</style>
</head>
<body>

	<div class="form-horizontal">
			<h1 class="text-center">주간계획작성</h1>
			<hr>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="deptName">소속</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="deptName" readonly="readonly" value="${weeklyPlan.employee.dept.deptName }">
				</div>
				<label class="col-sm-1 control-label" for="empName">성명</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="empName" readonly="readonly" value="${weeklyPlan.employee.empName }">
				</div>
				<div class="col-sm-6">
					<div class="row">
						<label class="col-xs-3 control-label" for="regDate">작성일</label>
						<div class="col-xs-9">
							<input type="text" class="form-control" id="regDate" readonly="readonly" value="${weeklyPlan.regDate }">
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="title">제목</label>
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
										<span id="${daily.planDate }"></span>
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
	<script type="text/javascript">

	function btn_click(){
		var dailyPlanList = [];
		$('.planDate').each(function() {
		  var dailyPlan = {};
		  dailyPlan.salesGoal = $(this).val();
		  dailyPlan.planDate = $(this).data('plan-date');
		  dailyPlanList.push(dailyPlan);
		});

		$.ajax({
			url:"/saveWeeklyPlan",
			type:"post",
			dataType:"json",
			data: {
			  monday : $('#mondayBtn').text(),
			  dailyPlanList : JSON.stringify(dailyPlanList)
			}
		});
		location.href="/weeklyListEmp?empId=${LOGIN_USER.empId}&rownum=0";
	}

	$(document).ready(function(){
		titleMonday();
		addPlan();
	});

	function titleMonday(){
		// 현재날짜 설정
		var date=new Date();
		var dateEnd=new Date();
		var dateWed=new Date();
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
		dateWed.setDate(dayOfMonth+2);
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
			$('<li><a href="checkWeeklyPlan?monday='+dateString+'">'+dateString+'~'+dateStringEnd+'</a></li>').appendTo('#monday');
			var monthWed=dateWed.getMonth()+1;
			var dayWed=dateWed.getDate();
			var wedWeek;
			if(dayWed==1){
				wedWeek=1;
			}else{
				wedWeek=Math.floor((dayWed-1)/7)+1;
			}
			$('<li><a href="checkWeeklyPlan?monday='+dateString+'">'+monthWed+'월 '+wedWeek+'주차 주간계획'+'</a></li>').appendTo('#title');
			dayOfMonth=date.getDate();
			date.setDate(dayOfMonth+7);
			dayOfMonth=dateEnd.getDate();
			dateEnd.setDate(dayOfMonth+7);
			dayOfMonth=dateWed.getDate();
			dateWed.setDate(dayOfMonth+7);
		}
	}

	function addPlan(){
		var list=new Array();
		var idSeq = 0;
		var ob = {
				'count':1
		};

		<c:forEach var="daily" items="${dailyPlanList}">
			$.ajax({
				url:"/viewPlan?empId=${weeklyPlan.employee.empId}&planDate=${daily.planDate}",
				type:"post",
				dataType:"json",
				success:function(data){
					var span=document.getElementById("${daily.planDate}");
					var dataString=JSON.stringify(data);
					var strArray=dataString.split("\"");
					var type=strArray[1];
					if("eventDate"==type){
						$('input[data-plan-date="${daily.planDate}"]').attr('disabled', 'disabled');
						span.innerHTML+="<div class=\"form-group has-error\" style=\"width:100%;\">"
							+"<input type=\"text\" readonly=\"readonly\" align=\"center\" class=\"form-control\" width\"20\" value="+data.title+">"
						  +"</div>";
					}else{
						var arrayList=data;
						if(arrayList!=""){
							for(var i=0;i<data.length;i++){
								span.innerHTML+="<div id=\""+idSeq+"delDiv\" class=\"input-gourp\">"
											+ "<div class=\"input-group\" style=\"width:100%;\">"
											+		"<input type=\"text\" readonly=\"readonly\" class=\"form-control\" value="+data[i].content+">"
									        +		"<span class=\"input-group-btn\">"
									        +			"<input id=\""+idSeq+"delbtn\" class=\"btn btn-secondary btn-danger\" data-plan-id=\""+data[i].planId+"\" type=\"button\" value=\"X\"/>"
									        +		"</span>"
									        +	"</div><br>"
											+"</div>";
								idSeq += 1;
							}
						}
						span.innerHTML+="<div id=\"${daily.dailyPlanId}addDiv\" class=\"input-gourp\">"
											+		"<div class=\"input-group\">"
											+		"<input id=\"${daily.dailyPlanId}text\" type=\"text\" class=\"form-control\" placeholder=\"Input Plan\" name=\"content\">"
										    +    "<span class=\"input-group-btn\">"
										    +      "<input id=\"${daily.dailyPlanId}addbtn\" class=\"btn btn-secondary btn-primary\" type=\"submit\" value=\"+\"/>"
										    +    "</span>"
											+	"</div>"
											+"</div>";
					}
					$("#${daily.dailyPlanId}addbtn").click(function(){
						if($("#${daily.dailyPlanId}text").val()!=""){
							$.ajax({
								url:"/inputPlan",
								type:"post",
								data:{
									"dailyPlanId":"${daily.dailyPlanId}",
									"content":$("#${daily.dailyPlanId}text").val()
								},
								success:function(data){

									$("#${daily.dailyPlanId}addDiv").before('<div id=\"'+idSeq+'delDiv\" class=\"input-gourp\">'
										+ '<div class=\"input-group\" style=\"width:100%;\">'
										+		'<input type=\"text\" readonly=\"readonly\" class=\"form-control\" value='+$("#${daily.dailyPlanId}text").val()+'>'
								        +		'<span class=\"input-group-btn\">'
								        +			'<input id=\"'+idSeq+'delbtn\" class=\"btn btn-secondary btn-danger\" data-plan-id=\"'+data+'\" type=\"submit\" value=\"X\"/>'
								        +		'</span>'
								        +	'</div><br>'
										+'</div>');

									var planId=data.split("\"");

									$("#"+idSeq+"delbtn").click(function(){
										$.ajax({
											url:"/removePlan",
											type:"post",
											data:{
												"planId":planId[1]
											},
											success:function(data){
												if(data==="\"성공\""){
												}
											}
										});
										$(this).parent().parent().parent().remove();
									});

									idSeq += 1;
									$("#${daily.dailyPlanId}text").val("");

								}
							});
						}
					});


					if(ob.count == 5)
					{
						for(var i=0; i<idSeq+1; i++)
						{
							$("#"+i+"delbtn").click(function(){
								$.ajax({
									url:"/removePlan",
									type:"post",
									data:{
										"planId":$(this).data('plan-id')
									},
									success:function(data){
										if(data==="\"성공\""){
										}
									}
								});
								$(this).parent().parent().parent().remove();
							});
						}
					}

					ob.count += 1;

				}});
			</c:forEach>
	}

	</script>
</body>
</html>