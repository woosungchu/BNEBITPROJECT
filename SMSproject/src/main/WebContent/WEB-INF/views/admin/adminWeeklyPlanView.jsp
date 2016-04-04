<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.css">
<style type='text/css'>
#btn {
	vertical-align: bottom;
}
a.btn.btn-primary{
	width: 230px;
}
</style>

	<form class="form-horizontal">
		<div class="col-lg-3"></div>
		<div class="col-lg-6" style="background-color: rgba(255, 255, 255,0.4); border-radius : 15px;">
			<h1 class="text-center">주간계획조회</h1>
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
						<table class="table table-bordered">
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
									<td align="center">
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
				<div class="form-group">
					<div class="col-sm-4">
						<a href="/admin/report/weeklyPlanList" class="btn btn-primary">돌아가기</a>
					</div>
					<div class="col-sm-4">
						<a href="/admin/report/viewWeeklyPlanUpdateForm?weeklyPlanId=${weeklyPlan.weeklyPlanId}" class="btn btn-primary">수정</a>
					</div>
					<div class="col-sm-4">
						<a href="/admin/report/deleteWeeklyPlan?weeklyPlanId=${weeklyPlan.weeklyPlanId}" class="btn btn-primary">삭제</a>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-3"></div>
	</form>

	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		addPlan();
		//addButton();
	});

	function addPlan(){
		/* 일일 보고가 존재 하지 않는 버튼 처리를 위한 id seq 전역 변수 */
		var globalBtnSeq = {
				'seq':1 // 일일 보고가 존재 하지 않는 버튼 처리를 위한 id seq 전역 변수
		};
		/* ========================== 현재의 날짜를 구함 ========================== */
		var now=new Date();		// 현재시간
		var yearNow=now.getFullYear();
		var monthNow=now.getMonth()+1;
		var dateNow=now.getDate();
		var nowDate=yearNow+"0"+monthNow+""+dateNow;
		/* ============================================================== */

		/* ========================= 해당 날짜의 내용란 구성 ======================== */
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
						span.innerHTML+='<div class="form-group has-error" style="width:100%;">'
								+'<input type="text" readonly="readonly" align="center" class="form-control" width"20" value="'+data.title+'">';
							  +'</div>';
							  /* ------------------ 해당 날짜의 버튼 구성 (휴일일 경우) ------------------ */
							    var span2=document.getElementById("btn_${daily.planDate}");
							    $(span2).append('<a class="btn btn-default" disabled="disabled" role="button">휴일</a>');
							  /* --------------------------------------------------------- */
					}else{
						var arrayList=data;
						if(arrayList!=""){
							  for(var i=0;i<data.length;i++){
								  span.innerHTML+='<input type="text" readonly="readonly" class="form-control" value="'+data[i].content+'">';
							  }
							  /* ------------------ 해당 날짜의 버튼 구성 (평일일 경우) ------------------ */

								  	/* ----------------- 해당 날짜를 구함 ------------------- */
									var planDate="${daily.planDate}";
									var strArray=planDate.split("/");
									var year="20"+strArray[0];
									var month=strArray[1];
									var date=strArray[2];
									var dateString=year+""+month+""+date;
									/* ---------------------------------------------- */
				  		      var span2=document.getElementById("btn_${daily.planDate}");
						      if(nowDate>=dateString){
						    	 $.ajax({
										url:"/admin/report/checkDailyReportExist?employee.empId=${weeklyPlan.employee.empId}&regDate=${daily.planDate}",
										type:"post",
										success:function(data){
											if(data!=0){
									    	    $(span2).append('<a href="/admin/report/viewDailyReport'
									    	    		+'?employee.empId=${weeklyPlan.employee.empId}'
									    	    		+'&dailyReportId='+data
									    	    		+'&regDate=${daily.planDate}'
									    	    		+'&weeklyPlanId=${weeklyPlan.weeklyPlanId}"'
									    	    		+' class="btn btn-default" role="button">일일 보고 조회</a>');
											}
											else{
									    	    $(span2).append('<button id="'+globalBtnSeq.seq+'nonBtn" type="button" class="btn btn-default">일일 보고 조회</button>');
									    	    $("#"+globalBtnSeq.seq+"nonBtn").click(function(){
									    	    	alert("해당 날짜의 일일보고가 없습니다!!");
									    	    });
									    	    globalBtnSeq.seq += 1;
											}
										}
						    	  });
							  }else{
								  $(span2).append('<button type="button" disabled="disabled" class="btn btn-default">일일 보고 조회</button>');
							  }
						    /* --------------------------------------------------------- */
						}
					}
				}});
			</c:forEach>
			/* ================================================== */
	}
	</script>
