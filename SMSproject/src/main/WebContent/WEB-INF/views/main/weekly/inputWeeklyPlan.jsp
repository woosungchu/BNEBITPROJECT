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
<style type='text/css'>
#btn {
	vertical-align: bottom;
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
				<div class="form-horizontal">


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
							  <button type="button" class="btn">${weeklyPlan.title}</button>
							  <button type="button" class="btn dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							    <span class="caret"></span>
							    <span class="sr-only">Toggle Dropdown</span>
							  </button>
							  <ul class="dropdown-menu">
							    <li><a href="#">Action</a></li>
							    <li><a href="#">Another action</a></li>
							    <li><a href="#">Something else here</a></li>
							    <li role="separator" class="divider"></li>
							    <li><a href="#">Separated link</a></li>
							  </ul>
							</div>
							<label class="col-sm-1 control-label" for="monday">날짜</label>
							<div class="col-sm-5">
								<select class="form-control" name="date" id="monday">
									<option id="week2_1">2016.02.01~2016.02.05</option>
									<option id="week2_2">2016.02.08~2016.02.12</option>
									<option id="week2_3">2016.02.15~2016.02.19</option>
									<option id="week2_4">2016.02.21~2016.02.25</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="table-responsive">
  							<table class="table table-bordered" >
  								<tr align="center">
  									<th width="30">요일</th>
  									<th style="text-align:center;" width="100">월</th>
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
  										<td style="text-align:center;"><input type="text" class="form-control" value="${daily.salesGoal }"/></td>
  									</c:forEach>
  								</tr>
  								<tr height="300">
  									<th width="80">내용</th>
  									<c:forEach var="daily" items="${dailyPlanList }">
  										<td style="text-align:center;">
  											<div class="input-group">
	  											<span id="${daily.planDate }"></span>

  											</div>
  										</td>
  									</c:forEach>
  								</tr>
  								<tr>
  									<th></th>
  									<c:forEach var="daily" items="${dailyPlanList }">
  										<td style="text-align:center;">
  											<span id="btn_${daily.planDate}"></span><br>
  										</td>
  									</c:forEach>
  								</tr>
							  </table>
							</div>
						</div>
					</div>
					<div class="col-lg-6"></div>
				</div>
			</div>
		</div>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script src="/assets/js/sidebar_menu.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		addPlan();
		addButton();
	});

	function addPlan(){
		var list=new Array();
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
						span.innerHTML+="<input type=\"text\" readonly=\"readonly\" class=\"form-control has-error\" value="+data.title+">";
					}else{
						var arrayList=data;
						if(arrayList!=""){
							for(var i=0;i<data.length;i++){
								span.innerHTML+="<form class=\"form-signin\" action=\"removePlan\" method=\"post\">"
											+ "<div class=\"input-group\">"
											+		"<input type=\"text\" readonly=\"readonly\" class=\"form-control\" value="+data[i].content+">"
								      +		"<span class=\"input-group-btn\">"
								      +			"<input class=\"btn btn-secondary btn-danger\" type=\"submit\" value=\"X\"/>"
								      +		"</span>"
								      +	"</div>"
								      +	"<input type=\"hidden\" name=\"planId\" value="+data[i].planId+"><br>"
											+"</form>";
							}
						}
						span.innerHTML+="<form class=\"form-signin\" action=\"inputPlan\" method=\"post\">"
											+		"<div class=\"input-group\">"
											+		"<input type=\"text\" class=\"form-control\" placeholder=\"Input Plan\" name=\"content\">"
										  +    "<span class=\"input-group-btn\">"
										  +      "<input class=\"btn btn-secondary btn-primary\" type=\"submit\" value=\"+\"/>"
										  +    "</span>"
											+	"</div>"
									    +  "<input type=\"hidden\" name=\"dailyPlanId\" value=\"${daily.dailyPlanId}\"/>"
											+"</form>";
					}
				}});
			</c:forEach>
	}

	function addButton(){
		var now=new Date();		// 현재시간
		var yearNow=now.getFullYear();
		var monthNow=now.getMonth()+1;
		if(monthNow<10){
			monthNow="0"+monthNow;
		}
		var dateNow=now.getDate();
		if(dateNow<10){
			dateNow="0"+dateNow;
		}
		var nowDate=yearNow+"0"+monthNow+""+dateNow;
		<c:forEach var="daily" items="${dailyPlanList}">
			var planDate="${daily.planDate}";
			var strArray=planDate.split("/");
			var year="20"+strArray[0];
			var month=strArray[1];
			if(month<10){
				month="0"+month;
			}
			var date=strArray[2];
			if(date<10){
				date="0"+date;
			}
			var dateString=year+""+month+""+date;
			var span=document.getElementById("btn_${daily.planDate}");
			if(nowDate>dateString){
				span.innerHTML+="<a href=\"\" class=\"btn btn-default\" role=\"button\">일일 보고 조회</a>"
			}else if(nowDate==dateString){
				span.innerHTML+="<a href=\"\" class=\"btn btn-default\" role=\"button\">일일 보고 작성</a>"
			}else{
				span.innerHTML+="<a href=\"\" class=\"btn btn-default\" readonly=\"readonly\" role=\"button\">일일 보고 조회</a>"
			}
			//alert(year);
			//var year
			//alert("${daily.planDate}");
		</c:forEach>
	}

	</script>
</body>
</html>