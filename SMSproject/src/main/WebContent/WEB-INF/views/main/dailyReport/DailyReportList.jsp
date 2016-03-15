<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 화면에 맞춘 렌더링 및 확대 / 축소 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap Test</title>
<!-- Bootstrap -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
</head>
<body style="background-color: #fff;">
	<tiles:insertDefinition name="base.definition">
	</tiles:insertDefinition>
	<!-- wrapper -->
	<div id="wrapper" class="">
		<!-- Page Content Wrapper-->
		<div id="page-content-wrapper">
			<div class="container-fluid xyz">
				<!-- form -->
				<form class="form-horizontal">
					<div class="col-lg-3"></div>
					<!-- col-lg-6 -->
					<div class="col-lg-6">
						<h1 class="text-center">일일보고 목록</h1>
						<hr>
						<!-- search -->
						<div class="form-group">
							<label class="col-sm-1 control-label">검색</label>
							<div class="col-sm-2">
								<select class="form-control">
									<option>선택</option>
									<option>제목</option>
									<option>작성자</option>
									<option>날짜</option>
								</select>
							</div>
							<div class="col-sm-7">
								<input type="text" class="form-control">
							</div>
							<div class="col-sm-2">
								<input class="btn btn-primary form-control" value="Search">
							</div>
						</div>
						<hr>
						<!-- /#search -->
						<div class="col-sm-12">
							<a href="/dailyReport/selectDailyReportList?searchKey=title&searchValue=2">
							<input type="button" class="btn btn-primary form-control" id="insertDailyReport" value="일일보고작성"></a>
							<hr>
						</div>
						<!-- dailyReportList table -->
						<table class="table">
							<thead>
								<tr>
									<td class="text-center">NO</td>
									<td><a>제목▼</a></td>
									<td><a>작성자▼</a></td>
									<td><a>날짜▼</a></td>
									<td class="text-center">결재여부</td>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td class="text-center" colspan="5"><input
										class="btn btn-primary" type="button" value="Prev"> 1
										/ 10 <input class="btn btn-primary" type="button" value="Next">
									</td>
								</tr>
							</tfoot>
							<tbody>
								<c:forEach var="dailyReport" items="${dailyReportList}" varStatus="status">
									<tr>
										<td class="text-center">${status.index+1 }</td>
										<td><a href="/dailyReport/selectDailyReportView?dailyReportId=${dailyReport.dailyReportId }&regDate=${dailyReport.regDate}">${dailyReport.title }</a></td>
										<td>${dailyReport.employee.empName }</td>
										<td>${dailyReport.regDate }</td>
										<td class="text-center"><input type="checkbox"></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- /#dailyReportList table -->
					</div>
					<!-- /#col-lg-6 -->
					<div class="col-lg-3"></div>
				</form>
				<!-- /#form -->
			</div>
		</div>
		<!-- /#page-content-wrapper -->
	</div>
	<!-- /#wrapper -->

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="../assets/js/sidebar_menu.js"></script>
	<script type="text/javascript">
		//휴일, 회사 기념일에 일일보고작성 버튼 비활성화
		$(document).ready(function(){
			var eventHoliday = "${event.holiday}";
			if(eventHoliday == 1 || eventHoliday == 2) {
				$("#insertDailyReport").attr("disabled", "true");
			}
		});
	</script>
</body>
</html>