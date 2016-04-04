<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.css">
<style type='text/css'>
#btn {
	vertical-align: bottom;
}
</style>

	<div class="form-horizontal">
		<div class="col-lg-3"></div>
			<div class="col-lg-6" style="background-color: rgba(102, 204, 255,0.4);color: yellow; border-radius : 15px;">
				<h1 class="text-center">주간계획수정</h1>
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
					  <input id="weeklyPlanTitle" type="text" class="form-control" value="${weeklyPlan.title}" style="width:90%;"/>
					</div>
					<label class="col-sm-1 control-label" for="monday">날짜</label>
					<div class="btn-group col-sm-5">
					  <button type="button" id="mondayBtn" class="btn btn-default" style="width:90%;" >${weeklyPlan.monday}</button>
					  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					    <span class="caret"></span>
					    <span class="sr-only">Toggle Dropdown</span>
					  </button>
					  <ul class="dropdown-menu" id="monday">
					  	<c:forEach items="${empWeeklyList}" var="empWeeklyList">
					  		<li style="text-align: center;"><a href="/admin/report/viewWeeklyPlanUpdateForm?weeklyPlanId=${empWeeklyList.weeklyPlanId}">${empWeeklyList.monday}</a></li>
					  	</c:forEach>
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
					<div class="col-sm-6">
					  <button class="form-control btn btn-primary" id="saveButton" onclick="btn_click()">저장</button>
					</div>
					<div class="col-sm-6">
					  <a href="/admin/report/viewWeeklyPlan?weeklyPlanId=${weeklyPlan.weeklyPlanId}"><button class="form-control btn btn-primary" id="cancleButton" type="button">취소</button></a>
					</div>
				</div>
			</div>
		<div class="col-lg-3"></div>
	</div>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
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
		dailyObject.dailyPlanList = dailyPlanList;

		$.ajax({
			url:"/admin/report/saveWeeklyPlan",
			type:"post",
			data: {
			  'title' : $('#weeklyPlanTitle').val(),
			  'monday' : $('#mondayBtn').text(),
			  'dailyPlanList' : JSON.stringify(dailyPlanList),
			  'weeklyPlanId' : '${weeklyPlan.weeklyPlanId}'
			},
			success : function(data){
				console.log(data);
				console.log(contextPath);
				location.href = '${contextPath}/admin/report/viewWeeklyPlan?weeklyPlanId='+data;
			}
		});
	}

	$(document).ready(function(){
		addPlan();
	});

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
						span.innerHTML+="<div class=\"form-group has-error\" style=\"width:100%;\">"
							+"<input type=\"text\" readonly=\"readonly\" align=\"center\" class=\"form-control\" width\"20\" value="+data.title+">"
						  +"</div>";
						  $("input[data-plan-date='${daily.planDate}']").attr("disabled","disabled");
					}else{
						var arrayList=data;
						if(arrayList!=""){
							for(var i=0;i<data.length;i++){
								span.innerHTML+="<div id=\""+idSeq+"delDiv\" class=\"input-gourp\" style=\"padding-bottom: 10px;\">"
											+ "<div class=\"input-group\" style=\"width:100%;\">"
											+		"<input type=\"text\" readonly=\"readonly\" class=\"form-control\" value="+data[i].content+">"
									        +		"<span class=\"input-group-btn\">"
									        +			"<input id=\""+idSeq+"delbtn\" class=\"btn btn-secondary btn-danger\" type=\"button\" value=\"X\"/>"
											        +	"<input id=\""+idSeq+"planId\" type=\"hidden\" name=\"planId\" value="+data[i].planId+"><br>"
									        +		"</span>"
									        +	"</div>"
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
						$.ajax({
							url:"/admin/report/inputPlan",
							type:"post",
							data:{
								"dailyPlanId":"${daily.dailyPlanId}",
								"content":$("#${daily.dailyPlanId}text").val()
							},
							success:function(data){

								$("#${daily.dailyPlanId}addDiv").before('<div id=\"'+idSeq+'delDiv\" class=\"input-gourp\" style=\"padding-bottom: 10px;\">'
									+ '<div class=\"input-group\" style=\"width:100%;\">'
									+		'<input type=\"text\" readonly=\"readonly\" class=\"form-control\" value='+$("#${daily.dailyPlanId}text").val()+'>'
							        +		'<span class=\"input-group-btn\">'
							        +			'<input id=\"'+idSeq+'delbtn\" class=\"btn btn-secondary btn-danger\" type=\"submit\" value=\"X\"/>'
									        +	'<input id=\"'+idSeq+'planId\" type=\"hidden\" name=\"planId\" value='+data+'><br>'
							        +		'</span>'
							        +	'</div>'
									+'</div>');

								$("#"+idSeq+"delbtn").click(function(){
									$.ajax({
										url:"/admin/report/removePlan",
										type:"post",
										data:{
											"planId":$(this).next('input').val()
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
					});


					if(ob.count == 5)
					{
						for(var i=0; i<idSeq+1; i++)
						{
							$("#"+i+"delbtn").click(function(){
								$.ajax({
									url:"/admin/report/removePlan",
									type:"post",
									data:{
										"planId":$(this).next('input').val()
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
