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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css">

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
				<form class="form-horizontal">


					<div class="col-lg-6">
						<h1 class="text-center">주간계획조회</h1>
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
							<div class="col-sm-5">
								<input type="text" class="form-control" id="title" readonly="readonly" value="${weeklyPlan.title }">
							</div>
							<label class="col-sm-1 control-label" for="date">날짜</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" id="date" readonly="readonly" value="${weeklyPlan.monday }">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-4">
								<div class="row">
									<label class="col-xs-4 control-label" for="salesGoalSum">매출목표</label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="salesGoalSum" readonly="readonly" value="${weeklyPlan.salesGoalSum }">
									</div>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="row">
									<label class="col-xs-4 text-left control-label" for="profitSum">매출액</label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="profitSum" readonly="readonly" value="${weeklyPlan.profitSum }">
									</div>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="row">
									<label for="inputEmail3" class="col-xs-4 text-left control-label">달성률</label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="inputEmail3" readonly="readonly" value="${weeklyPlan.achievement }"/>
									</div>
								</div>
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
  										<td style="text-align:center;">${daily.salesGoal }</td>
  									</c:forEach>
  								</tr>
  								<tr height="300">
  									<th width="80">내용</th>
  									<c:forEach var="daily" items="${dailyPlanList }">
  										<td style="text-align:center;">
  											<span id="${daily.planDate }"></span><br>
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
						span.innerHTML+="<div class=\"form-group has-error\">"
								+"<input type=\"text\" readonly=\"readonly\" class=\"form-control\" width\"20\" value="+data.title+">";
							  +"</div>";
					}else{
						var arrayList=data;
						if(arrayList!=""){
							for(var i=0;i<data.length;i++){
								span.innerHTML+="<input type=\"text\" readonly=\"readonly\" class=\"form-control\" value="+data[i].content+">";
							}
						}
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