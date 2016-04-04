<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div id="searchContainer">
<div class="row">
	<div class="col-md-4">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h4 class="panel-title">직원</h4>
			</div>
			<div class="panel-body" data-list="empList">
				<div class="list-group">
					<c:choose>
						<c:when test="${empty empList}">
							<h2 class="text-center">검색 결과가 없습니다</h2>
						</c:when>
						<c:otherwise>
							<c:forEach var="v" items="${empList}">
									<div class="list-group-item ellipsis">
										<a href="#" data-emp-id="${v.empId}" class="btn-staff-info preventDefault">
											${v.empName} ${v.dept.deptName } 
											<c:set var="position" value="${v.position}"></c:set>
											<c:choose>
												<c:when test="${position eq 'Salesman'}"> 팀원</c:when>
												<c:when test="${position eq 'Manager'}"> 팀장</c:when>
											</c:choose>
										</a>
										<p>${v.phone} / ${v.email}</p>
									</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div><!-- first panel -->
	<div class="col-md-4">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h4 class="panel-title">일정</h4>
			</div>
			<div class="panel-body" data-list="planList">
				<div class="list-group">
					<c:choose>
						<c:when test="${empty planList}">
							<h2 class="text-center">검색 결과가 없습니다</h2>
						</c:when>
						<c:otherwise>
							<c:forEach var="v" items="${planList}">
									<div class="list-group-item ellipsis">
										<fmt:parseDate var="parsedDate" value="${v.dailyPlan.planDate}"
											pattern="yyyy-MM-dd"></fmt:parseDate>
										<fmt:formatDate var="planDate" value="${parsedDate}" pattern="MM.dd.yyyy" />
										<c:choose>
											<c:when test="${LOGIN_USER.position == 'Salesman' }">
											<a href="/editWeeklyPlan?weeklyPlanId=${v.dailyPlan.weeklyPlan.weeklyPlanId}">
												${v.content} 
											</a>
											</c:when>
											<c:when test="${LOGIN_USER.position == 'Manager' }">
											<a href="/viewWeeklyPlan?weeklyPlanId=${v.dailyPlan.weeklyPlan.weeklyPlanId}&rownum=0">
												${v.content} - ${v.dailyPlan.weeklyPlan.employee.empName } 
											</a>
											</c:when>
										</c:choose>
										<small class="pull-right">${planDate}</small>
									</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div><!-- second panel -->
	<div class="col-md-4">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h4 class="panel-title">거래처</h4>
			</div>
			<div class="panel-body" data-list="clientList">
				<div class="list-group">
					<c:choose>
						<c:when test="${empty clientList}">
							<h2 class="text-center">검색 결과가 없습니다</h2>
						</c:when>
						<c:otherwise>
							<c:forEach var="v" items="${clientList}">
									<div class="list-group-item ellipsis">
										<a href="/client/clientView?clientId=${v.clientId}&currentPage=1">
											${v.clientName} ${v.ceo}
										</a>
										<p>${v.address} / ${v.phone} /  ${v.secondName}</p>
									</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div><!-- third panel -->
</div><!-- end first row -->
<div class="row">
	<div class="col-md-6">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h4 class="panel-title">일일보고</h4>
			</div>
			<div class="panel-body" data-list="reportList">
				<div class="list-group">
					<c:choose>
						<c:when test="${empty reportList}">
							<h2 class="text-center">검색 결과가 없습니다</h2>
						</c:when>
						<c:otherwise>
							<c:forEach var="v" items="${reportList}">
									<div class="list-group-item ellipsis">
										<c:set var="regDate" value="${fn:substring(v.regDate, 0, 10)}" />
										<a href="/dailyReport/selectDailyReportView?dailyReportId=${v.dailyReportId}&empId=${v.employee.empId}&regDate=${regDate}">
											${v.title} - ${v.employee.empName}
										</a>
										<p>${v.content}</p>
										<c:if test="${not empty v.feedback }">
											<p><small> -> ${v.feedback}</small></p>
										</c:if>
									</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div><!-- first panel -->
	<div class="col-md-6">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h4 class="panel-title">상담일지</h4>
			</div>
			<div class="panel-body" data-list="consultingList">
				<div class="list-group">
					<c:choose>
						<c:when test="${empty consultingList}">
							<h2 class="text-center">검색 결과가 없습니다</h2>
						</c:when>
						<c:otherwise>
							<c:forEach var="v" items="${consultingList}">
									<div class="list-group-item ellipsis">
										<c:set var="regDate2" value="${fn:substring(v.dailyReport.regDate, 0, 10)}" />
										<a href="/dailyReport/selectDailyReportView?dailyReportId=${v.dailyReport.dailyReportId}&empId=${v.dailyReport.employee.empId}&regDate=${regDate2}">
											${v.title}    
										</a>
										<small class="pull-right">
											<c:set var="position" value="${v.dailyReport.employee.position}"></c:set>
											<c:choose>
												<c:when test="${position eq 'Salesman'}">팀원 </c:when>
												<c:when test="${position eq 'Manager'}">팀장 </c:when>
											</c:choose>
											${v.dailyReport.employee.empName} 
											<i class="fa fa-exchange"></i> ${v.client.clientName} ${v.client.ceo}
										</small>
										<p>${v.content}</p>
									</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div><!-- second panel -->
</div><!-- second row -->
</div>
<script src='/assets/js/searchResult.js'></script>