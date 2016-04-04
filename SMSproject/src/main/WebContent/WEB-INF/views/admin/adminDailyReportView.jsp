<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.css">
<style type='text/css'>
	a.btn.btn-primary{
		width: 230px;
	}
</style>

<div class="container-fluid xyz">
	<form class="form-horizontal"
		action="/admin/report/updateDailyReportForm" method="post">
		<div class="col-lg-3"></div>
		<div class="col-lg-6" style="background-color: rgba(255, 255, 255,0.4); border-radius : 15px;">
			<div class="form-group">
				<h1 class="col-sm-12 text-center">일일보고</h1>
			</div>
			<hr>
			<input type="hidden" id="dailyReportId" name="dailyReportId"
				value="${dailyReport.dailyReportId }">
			<div class="form-group">
				<label class="col-sm-1 control-label">소속</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id=""
						value="${dailyReport.employee.dept.deptName }" readonly="readonly" />
				</div>
				<label class="col-sm-1 control-label">성명</label>
				<div class="col-sm-2">
					<input type="hidden" id="empId" name="employee.empId"
						value="${dailyReport.employee.empId }"> <input type="text"
						class="form-control" id=""
						value="${dailyReport.employee.empName }" readonly="readonly" />
				</div>
				<label class="col-sm-2 control-label">작성일</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="" name="regDate"
						value="${dailyReport.regDate }" readonly="readonly" />
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-1 control-label">제목</label>
				<div class="col-sm-11">
					<input type="text" class="form-control" id=""
						value="${dailyReport.title }" readonly="readonly" />
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 text-left control-label">매출목표</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id=""
						value="${dailyPlan.salesGoal }" readonly="readonly" />
				</div>
				<label for="inputEmail3" class="col-sm-2 control-label">매출액</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id=""
						value="${dailyReport.profit }" readonly="readonly" />
				</div>
				<label for="inputEmail3" class="col-sm-2 control-label">달성률</label>
				<div class="col-sm-2">
					<fmt:formatNumber var="profitRate"
						value="${dailyReport.profit / dailyPlan.salesGoal * 100}"
						pattern="#.##" />
					<input type="text" class="form-control" id=""
						value="${profitRate }%" readonly="readonly" />
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 text-left control-label">출근시
					계기판</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id=""
						value="${dailyReport.departure }" readonly="readonly" />
				</div>
				<label for="inputEmail3" class="col-sm-2 control-label">퇴근시
					계기판</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id=""
						value="${dailyReport.arrival }" readonly="readonly" />
				</div>
				<label for="inputEmail3" class="col-sm-2 control-label">주행거리</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id=""
						value="${dailyReport.arrival - dailyReport.departure }"
						readonly="readonly">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">업무보고</label>
				<textarea class="form-control" rows="5" readonly="readonly">${dailyReport.content }</textarea>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">팀장의견</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="feedback"
						value="${dailyReport.feedback }" readonly="readonly" />
				</div>
			</div>
			<div class="form-group">
				<c:choose>
					<c:when test="${weeklyPlanId != null && weeklyPlanId != \"\"}">
						<input type="hidden" name="weeklyPlanId" value="${weeklyPlanId}">
						<div class="col-sm-4">
							<a href="/admin/report/viewWeeklyPlan?weeklyPlanId=${weeklyPlanId}" class="btn btn-primary">뒤로가기</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="col-sm-4">
							<a href="/admin/report/dailyReportList" class="btn btn-primary">목록으로</a>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="col-sm-4">
					<input type="submit" class="form-control btn btn-primary"
						id="updateDailyReport" value="수정">
				</div>
				<div class="col-sm-4">
					<a href="/admin/report/deleteDailyReport?dailyReportId=${dailyReport.dailyReportId}&weeklyPlanId=${weeklyPlanId}" class="btn btn-primary">삭제</a>
				</div>
		    </div>
</div>
<div class="col-lg-3"></div>
</form>
</div>

<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- <script type="text/javascript">
function page_back(){
	history.go(-1)();
}
</script> -->