<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="container-fluid xyz">
	<form class="form-horizontal" action="/dailyReport/updateDailyReport" method="post">
		<div class="col-lg-3"></div>
		<div class="col-lg-6">
			<div class="form-group">
				<h1 class="col-sm-12 text-center">일일보고수정</h1>
			</div>
			<input type="hidden" id="dailyReportId" name="dailyReportId" value="${dailyReport.dailyReportId }">
			<div class="form-group">
				<label class="col-sm-1 control-label">소속</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="deptName"
						name="deptName" value="${dailyReport.employee.dept.deptName }" readonly="readonly"/>
				</div>
				<label class="col-sm-1 control-label">성명</label>
				<div class="col-sm-3">
					<input type="hidden" id="empId" name="employee.empId" value="${dailyReport.employee.empId }">
					<input type="text" class="form-control" id="empName" name="empName"
						value="${dailyReport.employee.empName }" readonly="readonly"/>
				</div>
				<label class="col-sm-2 control-label">작성일</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="regDate" name="regDate"
						value="${dailyReport.regDate }" readonly="readonly"/>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-1 control-label">제목</label>
				<div class="col-sm-11">
					<input type="text" class="form-control" id="title" name="title"
						value="${dailyReport.title }" readonly="readonly"/>
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 text-left control-label">매출목표</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="salesGoal"
						name="salesGoal" value="${dailyPlan.salesGoal }" readonly="readonly"/>
				</div>
				<label for="inputEmail3" class="col-sm-2 control-label">매출액</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="profit" name="profit"
						value="${dailyReport.profit }"/>
				</div>
				<label for="inputEmail3" class="col-sm-2 control-label">달성률</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="profitRate"
						name="profitRate" value="0.00%" readonly="readonly"/>
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 text-left control-label">출근시
					계기판</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="departure"
						name="departure" value="${dailyReport.departure }"/>
				</div>
				<label for="inputEmail3" class="col-sm-2 control-label">퇴근시
					계기판</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="arrival" name="arrival"
						value="${dailyReport.arrival }"/>
				</div>
				<label for="inputEmail3" class="col-sm-2 control-label">주행거리</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="distance"
						name="distance" value="${dailyReport.arrival - dailyReport.departure }" readonly="readonly"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">업무보고</label>
				<textarea class="form-control" rows="5" id="content" name="content">${dailyReport.content }</textarea>
			</div>
			<div class="form-group">
				<div class="col-sm-6">
					<input type="submit" class="form-control btn btn-primary"	 id="updateDailyReport" value="저장">
					<hr>
					<hr>
				</div>
				<div class="col-sm-6">
					<a href="/dailyReport/selectDailyReportView?
					dailyReportId=${dailyReport.dailyReportId }&empId=${dailyReport.employee.empId }&regDate=${dailyReport.regDate}">
					<input type="button" class="form-control btn btn-primary"	 id="selectDailyReportView" value="취소">
					</a>
					<hr>
					<hr>
				</div>
			</div>
		</div>
		<div class="col-lg-3"></div>
	</form>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#profit").keyup(function() {
			var profit = parseInt($("#profit").val());
			var salesGoal = parseInt($("#salesGoal").val());
			var profitRate = profit / salesGoal * 100;
			if (isNaN(profitRate)) {
				profitRate = 0;
			}
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			$("#profitRate").attr("value", profitRate.toFixed(2) + '%');
		});

		$("#departure").keyup(function() {
			var departure = parseInt($("#departure").val());
			var arrival = parseInt($("#arrival").val());
			var distance = arrival - departure;
			if (distance < 0) {
				distance = 0;
			} else if(isNaN(distance)) {
				distance = 0;
			}
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			$("#distance").attr("value", distance);
		});

		$("#arrival").keyup(function() {
			var departure = parseInt($("#departure").val());
			var arrival = parseInt($("#arrival").val());
			var distance = arrival - departure;
			if (distance < 0) {
				distance = 0;
			} else if(isNaN(distance)) {
				distance = 0;
			}
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			$("#distance").attr("value", distance);
		});

	});
</script>