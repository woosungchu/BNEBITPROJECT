<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="container-fluid xyz">
	<form class="form-horizontal"
		action="/dailyReport/updateDailyReportForm?dailyReportId=${dailyReport.dailyReportId }&empId=${dailyReport.employee.empId }&regDate=${dailyReport.regDate}"
		method="post">
		<div class="col-lg-3"></div>
		<div class="col-lg-6">
			<div class="form-group">
				<h1 class="col-sm-12 text-center">일일보고</h1>
				<div class="col-sm-10"></div>
				<div class="col-sm-2">
					<input type="button" class="btn btn-primary" value="상담일지작성">
				</div>
			</div>
			<input type="hidden" id="dailyReportId" name="dailyReportId"
				value="${dailyReport.dailyReportId }">
			<div class="form-group">
				<label class="col-sm-1 control-label">소속</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id=""
						value="${dailyReport.employee.dept.deptName }" readonly="readonly" />
				</div>
				<label class="col-sm-1 control-label">성명</label>
				<div class="col-sm-3">
					<input type="hidden" id="empId" name="employee.empId"
						value="${employee.empId }"> <input type="text"
						class="form-control" id=""
						value="${dailyReport.employee.empName }" readonly="readonly" />
				</div>
				<label class="col-sm-2 control-label">작성일</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id=""
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
				<div class="col-sm-8">
					<input type="text" class="form-control" id="feedback"
						value="${dailyReport.feedback }" readonly="readonly" />
				</div>
				<div class="col-sm-2">
					<input type="button" class="form-control btn btn-primary"
						id="confirmDailyReport" value="결재">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-6">
					<input type="submit" class="form-control btn btn-primary"
						id="updateDailyReport" value="일일보고수정">
					<hr>
					<hr>
				</div>
				<div class="col-sm-6">
					<a href="/dailyReport/selectDailyReportList"> <input
						type="button" class="form-control btn btn-primary"
						id="selectDailyReportList" value="목록으로">
					</a>
					<hr>
					<hr>
				</div>
			</div>

			<h1 class="text-center">상담일지 목록</h1>
			<div class="panel-group" id="accordion" role="tablist"
				aria-multiselectable="true">
				<div class="panel panel-default">
					<div class="panel-heading" role="tab" id="headingOne">
						<h4 class="panel-title">
							<a data-toggle="collapse" data-parent="#accordion"
								href="#collapseOne" aria-expanded="false"
								aria-controls="collapseOne"> <input type="button"
								class="btn btn-primary" value="상담일지작성">
							</a>
						</h4>
					</div>
				</div>
				<div id="collapseOne" class="panel-collapse collapse"
					role="tabpanel" aria-labelledby="headingOne">
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-1 control-label">소속</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
							<label class="col-sm-1 control-label">성명</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
							<label class="col-sm-2 control-label">작성일</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-1 control-label">제목</label>
							<div class="col-sm-11">
								<input type="password" class="form-control" id="inputPassword3">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 text-left control-label">고객코드</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
							<label for="inputEmail3" class="col-sm-2 control-label">고객명</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
							<label for="inputEmail3" class="col-sm-2 control-label">대표자</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 text-left control-label">2차
								거래선</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
							<label for="inputEmail3" class="col-sm-2 control-label">주소</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">상담내역</label>
							<textarea class="form-control" rows="5"></textarea>
						</div>
					</div>
				</div>
			<div class="panel panel-default">
				<div class="panel-heading" role="tab" id="headingTwo">
					<h4 class="panel-title">
						<a class="collapsed" data-toggle="collapse"
							data-parent="#accordion" href="#collapseTwo"
							aria-expanded="false" aria-controls="collapseTwo">
							Collapsible Group Item #2 </a>
					</h4>
				</div>
				<div id="collapseTwo" class="panel-collapse collapse"
					role="tabpanel" aria-labelledby="headingTwo">
					<div class="panel-body">Anim pariatur cliche reprehenderit,
						enim eiusmod high life accusamus terry richardson ad squid. 3 wolf
						moon officia aute, non cupidatat skateboard dolor brunch. Food
						truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor,
						sunt aliqua put a bird on it squid single-origin coffee nulla
						assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer
						labore wes anderson cred nesciunt sapiente ea proident. Ad vegan
						excepteur butcher vice lomo. Leggings occaecat craft beer
						farm-to-table, raw denim aesthetic synth nesciunt you probably
						haven't heard of them accusamus labore sustainable VHS.</div>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading" role="tab" id="headingThree">
					<h4 class="panel-title">
						<a class="collapsed" data-toggle="collapse"
							data-parent="#accordion" href="#collapseThree"
							aria-expanded="false" aria-controls="collapseThree">
							Collapsible Group Item #3 </a>
					</h4>
				</div>
				<div id="collapseThree" class="panel-collapse collapse"
					role="tabpanel" aria-labelledby="headingThree">
					<div class="panel-body">Anim pariatur cliche reprehenderit,
						enim eiusmod high life accusamus terry richardson ad squid. 3 wolf
						moon officia aute, non cupidatat skateboard dolor brunch. Food
						truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor,
						sunt aliqua put a bird on it squid single-origin coffee nulla
						assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer
						labore wes anderson cred nesciunt sapiente ea proident. Ad vegan
						excepteur butcher vice lomo. Leggings occaecat craft beer
						farm-to-table, raw denim aesthetic synth nesciunt you probably
						haven't heard of them accusamus labore sustainable VHS.</div>
				</div>
			</div>
		</div>
</div>
<div class="col-lg-3"></div>
</form>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		// 일일보고 결재 ajax
		$("#confirmDailyReport").click(function() {
			var feedback = $("#feedback").val();
			var dailyReportId = $("#dailyReportId").val();
			$.ajax({
				url : "/dailyReport/updateDailyReportConfirm",
				type : "post",
				data : {
					"feedback" : feedback,
					"dailyReportId" : dailyReportId
				},
				success : function(data) {
					$("#feedback").val(feedback);
				}
			});
		});

		// 팀원 로그인시 결재버튼 막기
		var position = "${employee.position}";
		if (position == "Salesman") {
			$("#confirmDailyReport").attr("disabled", "true");
		}

		// 팀장 로그인시 일일보고수정버튼 막기
		if (position == "Manager") {
			$("#updateDailyReport").attr("disabled", "true");
		}

		// 상담일지 펼쳐보기 접기 테스트
		$(".consultingView").click(function() {
			var consultingView = $(this).parent().next("tr").find("td");

			if (consultingView.is(":visible")) {
				consultingView.slideUp();
			} else {
				consultingView.slideDown();
			}
		});
	});
</script>