<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel='stylesheet' href='http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/cupertino/jquery-ui.css' />
<link rel='stylesheet' href='http://fullcalendar.io/js/fullcalendar-2.2.3/fullcalendar.css' />
<link rel="stylesheet" href="/assets/css/mainBody.css">

<div id="bodyContainer" class="container-fluid xyz" style="visibility: hidden;">
	<div class="row"><!-- first row -->
		<div class="col-lg-3 col-md-5">
			<div class="panel panel-primary c-pointer" onclick="location.href='/';">
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
			<div class="panel panel-success c-pointer" onclick="location.href='/dailyReport/insertDailyReportForm';">
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
		<div class="col-lg-6 col-md-7">
			<div class="panel panle-default">
				<div class="table-responsive">
					<table id="week-table" class="table text-center">
						<tr class="color-high">
							<th onclick="getMainPlan('left');"><i class="fa fa-arrow-left fa-lg"></i></th>
							<th id="plan-monday" class="text-center"></th>
							<th class="text-center"></th>
							<th class="text-center"></th>
							<th class="text-center"></th>
							<th class="text-center"></th>
							<th onclick="getMainPlan('right');"><i class="fa fa-arrow-right fa-lg"></i></th>
						</tr><!-- first tr -->
						<c:forEach begin="0" end="3" varStatus="vs">
						<tr>
							<c:if test="${vs.index == 0 }"><td rowspan="4"></td></c:if>
							<td class="week-monday">월</td>
							<td class="week-tuesday">화</td>
							<td class="week-wednesday">수</td>
							<td class="week-thursday">목</td>
							<td class="week-friday">금</td>
							<c:if test="${vs.index == 0 }"><td rowspan="4"></td></c:if>
						</tr><!-- second tr -->
						</c:forEach>
					</table>
				</div>
				<div class="panel-footer">
					<c:choose>
                    	<c:when test="${LOGIN_USER.position eq 'Salesman'}">
                    		<button onclick="location.href='${contextPath }/weeklyListEmp?empId=${LOGIN_USER.empId}&rownum=0';" 
							type="button" class="btn btn-block btn-info">더 보기</button>
                    	</c:when>
                    	<c:when test="${LOGIN_USER.position eq 'Manager'}">
							<button onclick="location.href='{contextPath }/weeklyList?deptId=${LOGIN_USER.dept.deptId}&rownum=0';" 
							type="button" class="btn btn-block btn-info">더 보기</button>
                    	</c:when>
                    </c:choose>
				</div>
			</div>
		</div>
		<div class="col-lg-3 hidden-md">
			<div class="panel panle-default">
				<div id='calendar'></div>
			</div>
		</div>
		<!-- end your content -->
	</div>
	<div class="row"><!-- second row -->
		<!-- start your content -->
		<div class="col-lg-3 col-md-5">
			<div class="panel panel-primary">
			  <div class="panel-heading">
			  	<h4>최근 거래처</h4>
			  </div>
			  <div class="panel-content">
				<div class="panel-group" id="accordion" role="tablist">
					<div class="panel panel-default">
						<div class="panel-heading color-low">
							<h4 class="panel-title">
								<a role="button" data-toggle="collapse" data-parent="#accordion"
								href="#collapseOne">
									<i class="fa fa-exchange"></i> 동작대리점 사당슈퍼
								</a>
							</h4>
						</div>
						<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel">
							<div class="panel-body">
								<p><i class="fa fa-user"></i> 이재성  
									<small  class="pull-right">
										<i class="fa fa-arrows-h"></i>
										남부지점 팀원 엘사
									</small>
								</p> 
								<p><i class="fa fa-phone"></i> 010-1335-6568 </p>
								<p><i class="fa fa-map-marker"></i> 경기도 하남시 초이동 </p>
							</div>
						</div>
					</div><!-- first -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a role="button" data-toggle="collapse" data-parent="#accordion"
								href="#collapseTwo">
									<i class="fa fa-exchange"></i> 강남대리점 비트센터
								</a>
							</h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel">
							<div class="panel-body">
								<p><i class="fa fa-user"></i> 이재성  
									<small  class="pull-right">
										<i class="fa fa-arrows-h"></i>
										남부지점 팀원 엘사
									</small>
								</p> 
								<p><i class="fa fa-phone"></i> 010-1335-6568 </p>
								<p><i class="fa fa-map-marker"></i> 경기도 하남시 초이동 </p>
							</div>
						</div>
					</div><!-- second -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a role="button" data-toggle="collapse" data-parent="#accordion"
								href="#collapseTwo">
									<i class="fa fa-exchange"></i> 강남대리점 비트센터
								</a>
							</h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel">
							<div class="panel-body">
								<p><i class="fa fa-user"></i> 이재성  
									<small  class="pull-right">
										<i class="fa fa-arrows-h"></i>
										남부지점 팀원 엘사
									</small>
								</p> 
								<p><i class="fa fa-phone"></i> 010-1335-6568 </p>
								<p><i class="fa fa-map-marker"></i> 경기도 하남시 초이동 </p>
							</div>
						</div>
					</div><!-- third -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a role="button" data-toggle="collapse" data-parent="#accordion"
								href="#collapseTwo">
									<i class="fa fa-exchange"></i> 강남대리점 비트센터
								</a>
							</h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel">
							<div class="panel-body">
								<p><i class="fa fa-user"></i> 이재성  
									<small  class="pull-right">
										<i class="fa fa-arrows-h"></i>
										남부지점 팀원 엘사
									</small>
								</p> 
								<p><i class="fa fa-phone"></i> 010-1335-6568 </p>
								<p><i class="fa fa-map-marker"></i> 경기도 하남시 초이동 </p>
							</div>
						</div>
					</div><!-- fourth -->
				</div>			  
			  </div>
			  <div class="panel-footer">
              	<button type="button" class="btn btn-block btn-info">더 보기</button>
              </div>
			</div>
		</div><!-- second panel end -->
		<div class="col-lg-6 col-md-7">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4>주간 매출</h4>
				</div>
				<div id="main-graph"></div>
<!-- 				<div class="panel-footer"> -->
<!-- 					<button type="button" class="btn btn-info btn-block">더 보기</button> -->
<!-- 				</div> -->
			</div>
		</div>
		<div class="col-lg-3 hidden-md">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4>부서 연락망 <span class="pull-right label label-success">Label Test</span></h4>
                </div>
                <div class="panel-content">
                	<ul class="main-ul clearfix">
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li><a href="#" class="preventDefault"><img src="/assets/image/noname.png"></a><h5>주우성 <br/><small>070-8754-1523</small></h5></li>
                		<li>
                			<a href="#" class="preventDefault">
                				<img src="/assets/image/noname.png">
                			</a>
                			<h5>주우성 <br/><small>070-8754-1523</small></h5>
                		</li>
                	</ul>
                </div>
<!--                 <div class="panel-footer"> -->
<!--                 	<button type="button" class="btn btn-block btn-info">더 보기</button> -->
<!--                 </div> -->
	        </div>
		</div>
		<!-- end your content -->
	</div>
</div>
<script src='http://fullcalendar.io/js/fullcalendar-2.2.3/lib/moment.min.js'></script>
<script src='http://fullcalendar.io/js/fullcalendar-2.2.3/fullcalendar.min.js'></script>
<script src='/assets/js/flotr2.min.js'></script>
<script src='/assets/js/mainPage.js'></script>
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