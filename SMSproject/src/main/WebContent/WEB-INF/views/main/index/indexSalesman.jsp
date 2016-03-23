<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel='stylesheet' href='http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/cupertino/jquery-ui.css' />
<link rel='stylesheet' href='http://fullcalendar.io/js/fullcalendar-2.2.3/fullcalendar.css' />
<link rel="stylesheet" href="/assets/css/mainBody.css">
<link rel="stylesheet" href="/assets/css/simpleWeather.css">
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today }" pattern="yyyy/MM/dd" var="sysdate" />

<div id="bodyContainer" class="container-fluid xyz" style="visibility: hidden;">
	<div class="row"><!-- first row -->
		<div class="col-lg-3 col-md-3">
			<div class="panel panel-primary c-pointer" data-toggle="modal" data-target="#userInfoModal">
			  <div class="panel-heading">
			  	<div id="session-profile" class="row">
			  		<div class="col-xs-3">
			  			<i class="fa fa-user fa-5x"></i>
			  		</div>
			  		<div class="col-xs-9 text-right">
			  			<div class="huge">${LOGIN_USER.dept.deptName} ${LOGIN_USER.empName}</div>
			  		</div>
			  	</div>
			  </div>
			</div>
			<div class="panel panel-warning c-pointer" onclick="location.href='/';">
			  <div class="panel-heading">
			  	<div class="row">
			  		<div class="col-xs-3">
			  			<i class="fa fa-comments fa-5x"></i>
			  		</div>
			  		<div class="col-xs-9 text-right">
			  			<div class="huge">상담일지 작성</div>
			  		</div>
			  	</div>
			  </div>
			</div>
			<!-- second panel -->
			<div class="panel panel-success c-pointer" 
			onclick="location.href='/dailyReport/insertDailyReportForm?empId=${LOGIN_USER.empId}&regDate=${sysdate}'">
			  <div class="panel-heading">
			  	<div class="row">
			  		<div class="col-xs-3">
			  			<i class="fa fa-pencil-square fa-5x"></i>
			  		</div>
			  		<div class="col-xs-9 text-right">
			  			<div class="huge">일일보고 작성</div>
			  		</div>
			  	</div>
			  </div>
			</div>
		</div><!-- second panel end -->
		<!-- 오늘 일정 목록 -->
		<div class="col-lg-3 col-md-4">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4 class="panel-title">오늘의 일정</h4>
				</div>
				<div class="panel-content">
					<c:choose>
						<c:when test="${not empty planList}">
							<ul id="to-do-list" class="list-group bg-trans">
							<c:forEach var="v" items="${planList }">
									<li class="list-group-item">
										<label class="form-checkbox form-icon form-text">
											<c:choose>
												<c:when test="${v.type eq '0'}">
													<input data-id="${v.planId}" class="plan-checkbox" type="checkbox"> 
												</c:when>
												<c:otherwise>
													<input data-id="${v.planId}" class="plan-checkbox" type="checkbox" checked>																	
												</c:otherwise>
											</c:choose>
											<span>${v.content}</span>
										</label>
									</li>
							</c:forEach>
							</ul>
						</c:when>
						<c:otherwise>
							<div class="well text-center">
								<h3>오늘의 일정이 없습니다</h3>
								<small><del>제발 일좀 하세요</del></small>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="panel-footer">
					<a href="/weeklyListEmp?empId=${LOGIN_USER.empId}&rownum=0" type="button" class="btn btn-info btn-block">주간 계획 보기</a>
				</div>
			</div>
		</div>
		<!-- calendar -->
		<div class="col-lg-3 col-md-5">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">달력</h3>
				</div>
				<div class="panel-body bg-warning">
					<div id='calendar'></div>
				</div>
			</div>
		</div>
		<div class="col-lg-3 hidden-md">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4 class="panel-title">부서 연락망 <span class="pull-right label label-success">Label Test</span></h4>
                </div>
                <div class="panel-content">
                	<ul class="main-ul clearfix">
                		<c:forEach var="v" items="${contactList }">
	                		<li><a href="#" class="preventDefault">
	                			<c:choose>
	                				<c:when test="${v.imgName != 'NONAME' && not empty v.imgName}">
	                					<img src="/Upload/${v.imgName}">
	                				</c:when>
	                				<c:otherwise>
			                			<img src="/assets/image/noname.png">
	                				</c:otherwise>
	                			</c:choose>
	                			</a><h5>${v.empName}<br/><small>${v.phone }</small></h5></li>
                		</c:forEach>
                	</ul>
                </div>
	        </div>
		</div>
	</div>
	<div class="row"><!-- second row -->
		<!-- start your content -->
		
		<!-- col-lg-3 -->
		<div class="col-lg-3 col-md-6">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">오늘의 날씨</h3>
				</div>
				<div class="panel-body bg-info">
					<div id="weather"></div>
				</div>
			</div>
			<div id="week-profit" class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">나의 주간 매출액</h3>
				</div>
				<div class="panel-body">
					<div>
						<h4>
							<span><i class="fa fa-usd"></i> ${weeklyProfits}</span>
							<span><i class="fa fa-long-arrow-right"></i></span>
							<span><i class="fa fa-flag"></i> ${weeklySalesGoal}</span>
						</h4>
					</div>
					<div class="progress">
					  <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" 
					  style="width:${weeklyProfits / weeklySalesGoal * 100}%; max-width : 100%">
					    ${fn:substringBefore((weeklyProfits / weeklySalesGoal * 100),'.')} %
					  </div>
					</div>
				</div>
			</div>
		</div>
		<!-- col-lg-6 -->
		<div class="col-lg-6 hidden-md">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4 class="panel-title">주간 매출</h4>
				</div>
				<div id="main-graph"></div>
			</div>
		</div>
		<!-- col-lg-3 -->
		<div class="col-lg-3 col-md-6">
			<div class="panel panel-primary">
			  <div class="panel-heading">
			  	<h4 class="panel-title">최근 거래처</h4>
			  </div>
			  <div class="panel-content">
				<div class="panel-group" id="accordion" role="tablist">
					<c:choose>
						<c:when test="${not empty contractList }">
							<c:forEach var="v" items="${contractList}" varStatus="vs">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a role="button" data-toggle="collapse" data-parent="#accordion"
											href="#collapse-${vs.index}">
												<i class="fa fa-exchange"></i> ${v.client.clientName} ${v.client.secondName}
											</a>
										</h4>
									</div>
									<c:choose>
										<c:when test="${vs.index == 0 }">
									<div id="collapse-${vs.index}" class="panel-collapse collapse in" role="tabpanel">
										</c:when>
										<c:otherwise>
									<div id="collapse-${vs.index}" class="panel-collapse collapse" role="tabpanel">
										</c:otherwise>
									</c:choose>
										<div class="panel-body">
											<p><i class="fa fa-user"></i> ${v.client.ceo }  
												<small  class="pull-right">
													<i class="fa fa-arrows-h"></i>
													${v.dailyReport.employee.dept.deptName} ${ v.dailyReport.employee.position} ${ v.dailyReport.employee.empName }
												</small>
											</p> 
											<p><i class="fa fa-phone"></i> ${v.client.phone } </p>
											<p><i class="fa fa-map-marker"></i> ${v.client.address } </p>
										</div>
									</div>
								</div><!-- second -->
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="well text-center">
								<h3>지난 계약이 없습니다</h3>
								<small><del>제발 일좀 하세요</del></small>
							</div>
						</c:otherwise>
					</c:choose>
				</div>			  
			  </div>
			  <div class="panel-footer">
              	<button type="button" class="btn btn-block btn-info">더 보기</button>
              </div>
		</div>
		<!-- end your content -->
	</div>
</div>
<script src='http://fullcalendar.io/js/fullcalendar-2.2.3/lib/moment.min.js'></script>
<script src='http://fullcalendar.io/js/fullcalendar-2.2.3/fullcalendar.min.js'></script>
<script src='/assets/js/flotr2.min.js'></script>
<script src='/assets/js/mainPage.js'></script>
<script src='/assets/js/simpleWeather.min.js'></script>
<script type="text/javascript">

//calendar
$('#calendar').fullCalendar({
	eventSources:[{
		events:function(start, end, timezone, callback){
			$.ajax({
				url:"/calendarGetPlan?empId=${LOGIN_USER.empId}",
				type:'post',
				dataType:'json',
				success:function(data){
					var events=[];
					var eventList=data.Event;
					for(var i=0;i<eventList.length;i++){
						events.push({
							title:eventList[i].title,
							start:eventList[i].eventDate.substring(0,10),
							rendering:'background'
						});
					}
					var planList=data.Plan;
					for(var i=0;i<planList.length;i++){
						events.push({
							title:planList[i].content,
							start:planList[i].dailyPlan.planDate.substring(0,10)
						});
					}
					callback(events);
				}
			});
		}
}],
eventLimit : true
});


	</script>