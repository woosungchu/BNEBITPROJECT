<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="container-fluid xyz">
	<div class="col-lg-3"></div>
	<!-- col-lg-6 -->
	<div class="col-lg-6">
		<form
			action="/dailyReport/selectDailyReportList"
			method="post" id="dailyReportForm">
			<!-- form -->
			<div class="row">
				<h1 class="text-center">일일보고 목록</h1>
				<hr>
				<!-- search -->
				<div class="form-group">
					<label class="col-sm-1 control-label"><span
						class="col-sm-1 glyphicon glyphicon-search"></span></label>
					<div class="col-sm-2">
						<select class="form-control" id="searchKey" name="searchKey">
							<option value="title">제목</option>
							<option value="writer">작성자</option>
							<option value="regDate">날짜</option>
						</select>
					</div>
					<div class="col-sm-7">
						<input type="text" class="form-control" name="searchValue"
							value="${paramMap.searchValue }">
					</div>
					<div class="col-sm-2">
						<input class="btn btn-primary form-control" type="submit"
							value="Search">
					</div>
				</div>
				<!-- /#search -->
			</div>
			<hr>
			<div class="row">
				<div class="col-sm-12">
					<jsp:useBean id="today" class="java.util.Date" />
					<fmt:formatDate value="${today }" pattern="yyyy/MM/dd"
						var="sysdate" />
					<a
						href="/dailyReport/insertDailyReportForm?empId=${paramMap.empId }&regDate=${sysdate}">
						<input type="button" class="btn btn-primary form-control"
						id="insertDailyReport" value="일일보고작성">
					</a>
					<hr>
				</div>
			</div>
			<div class="row">
				<!-- dailyReportList table -->
				<input type="hidden" id="sortKey" name="sortKey"> <input
					type="hidden" id="sortBy" name="sortBy">
				<table class="table">
					<thead>
						<tr>
							<td class="text-center">NO</td>
							<td><a class="sortKey" data-sort-key="title">제목</a><span
								id="title" class="sortBy"></span></td>
							<td><a class="sortKey" data-sort-key="emp_name">작성자</a><span
								id="emp_name" class="sortBy"></span></td>
							<td><a class="sortKey" data-sort-key="reg_date">날짜</a><span
								id="reg_date" class="sortBy"></span></td>
							<td class="text-center">결재여부</td>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<td class="text-center" colspan="5">
								<ul class="pagination">
									<li class="" id="moveBlockLeft"><a
										href="/dailyReport/selectDailyReportList?
										currentPage=${paramMap.blockSize * (pageUtil.currentBlock-1)}
										&searchKey=${paramMap.searchKey}&searchValue=${paramMap.searchValue}
										&sortKey=${paramMap.sortKey}&sortBy=${paramMap.sortBy}">
											<span class="glyphicon glyphicon-chevron-left"></span>
									</a></li>
									<c:forEach begin="1" end="${paramMap.blockSize }"
										varStatus="status">
										<li class="pageIndex"
											id="pageIndex${status.index + (paramMap.blockSize * (pageUtil.currentBlock - 1))}">
											<a
											href="/dailyReport/selectDailyReportList?
											currentPage=${status.index + (paramMap.blockSize * (pageUtil.currentBlock - 1))}
											&searchKey=${paramMap.searchKey}&searchValue=${paramMap.searchValue}
											&sortKey=${paramMap.sortKey}&sortBy=${paramMap.sortBy}">
												${status.index + (paramMap.blockSize * (pageUtil.currentBlock - 1))}</a>
										</li>
									</c:forEach>
									<li class="" id="moveBlockRight"><a
										href="/dailyReport/selectDailyReportList?
										currentPage=${(paramMap.blockSize * pageUtil.currentBlock)+1}
										&searchKey=${paramMap.searchKey}&searchValue=${paramMap.searchValue}
										&sortKey=${paramMap.sortKey}&sortBy=${paramMap.sortBy}">
											<span class="glyphicon glyphicon-chevron-right"></span>
									</a></li>
								</ul>
							</td>
						</tr>
					</tfoot>
					<tbody>
						<c:forEach var="dailyReport" items="${dailyReportList}"
							varStatus="status">
							<tr>
								<td class="text-center">${pageUtil.totalCount - (paramMap.pageSize * (pageUtil.currentPage-1)) - status.index}
								</td>
								<td><a
									href="/dailyReport/selectDailyReportView?dailyReportId=${dailyReport.dailyReportId }&empId=${dailyReport.employee.empId }&regDate=${dailyReport.regDate}">${dailyReport.title }</a></td>
								<td>${dailyReport.employee.empName }</td>
								<td>${dailyReport.regDate }</td>
								<td class="text-center"><span
									class="glyphicon glyphicon-ok" id="feedback${status.index }"></span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- /#dailyReportList table -->
			</div>
		</form>
		<!-- /#form -->
	</div>
	<!-- /#col-lg-6 -->
	<div class="col-lg-3"></div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		//휴일, 회사 기념일에 일일보고작성 버튼 비활성화
		var eventHoliday = "${event.holiday}";
		if (eventHoliday == 1 || eventHoliday == 2) {
			$("#insertDailyReport").attr("disabled", "true");
		}

		//일일보고 1개만 입력
		<c:forEach items="${dailyReportList}" var="dailyReport" varStatus="status">
		<c:choose>
		<c:when test="${dailyReport.regDate eq sysdate}">
		$("#insertDailyReport").attr("disabled", "true");
		</c:when>
		</c:choose>
		</c:forEach>

		//결재여부 표시
		var feedback = new Array();
		<c:forEach items="${dailyReportList}" var="dailyReport" varStatus="status">
		<c:choose>
		<c:when test="${dailyReport.feedback eq null}">
		$("#feedback${status.index }").removeClass("glyphicon glyphicon-ok");
		feedback.push("");
		</c:when>
		<c:otherwise>
		$("#feedback${status.index }").addClass("glyphicon glyphicon-ok");
		feedback.push("${dailyReport.feedback}");
		</c:otherwise>
		</c:choose>
		</c:forEach>
		for (var i = 0; i < feedback.length; i++) {
			console.log(i + " : " + feedback[i]);
		}

		//팀장은 일일보고입력 불가
		var position = "${paramMap.empId}";
		if(position == null) {
			$("#insertDailyReport").attr("disabled", "true");
		}

		//블록이동 비활성화 처리
		function blockDisabled() {
			var isFirstBlock = "${paramMap.isFirstBlock}";
			var isLastBlock = "${paramMap.isLastBlock}";
			if (isFirstBlock == "true") {
				console.log("isFirstBlock : " + isFirstBlock);
				$("#moveBlockLeft").remove();
			}
			if (isLastBlock == "true") {
				console.log("isLastBlock : " + isLastBlock);
				$("#moveBlockRight").remove();

				var blockSize = "${paramMap.blockSize}";
				//var paramBlockSize = parseInt(blockSize);
				for (var i = 0; i < blockSize; i++) {
					var index = parseInt(currentPage) + i;
					if (index > parseInt(totalPageCount)) {
						$("#pageIndex" + index).remove();
					}
				}
			}
		}

		//페이지 활성화 처리
		var currentBlock = "${pageUtil.currentBlock}";
		var currentPage = "${pageUtil.currentPage}";
		var totalPageCount = "${pageUtil.totalPageCount}";
		var totalBlockCount = "${pageUtil.totalBlockCount}";
		console.log("currentPage : " + currentPage);
		console.log("currentBlock : " + currentBlock);
		console.log("totalPageCount : " + totalPageCount);
		console.log("totalBlockCount : " + totalBlockCount);
		//$(".pageIndex").removeClass("active");

		blockDisabled();

		$("#pageIndex" + currentPage).addClass("active");

		$("#moveBlockLeft").click(function() {
			$("#pageIndex" + currentPage).addClass("active");
		});

		$("#moveBlockRight").click(function() {
			$("#pageIndex" + currentPage).addClass("active");
		});

		//정렬 후 요청 값들 반영
		var searchKey = "${paramMap.searchKey}";
		$("#searchKey").val(searchKey);

		var sortKey = "${paramMap.sortKey}";
		var sortBy = "${paramMap.sortBy}";
		if (sortBy == "asc") {
			$("#" + sortKey).text("▲");
		} else if (sortBy == "desc") {
			$("#" + sortKey).text("▼");
		}

		//sortKey를 클릭했을때 정렬
		$(".sortKey").click(function() {
			var dataSortKey = $(this).data("sort-key");
			var $sortLabel = $("#" + dataSortKey);
			var $text = $sortLabel.text();
			$(".sortBy").text("");

			if ($text == "") {
				$sortLabel.text("▲");
				$("#sortBy").val("asc");
			} else if ($text == "▲") {
				$sortLabel.text("▼");
				$("#sortBy").val("desc");
			} else if ($text == "▼") {
				$sortLabel.text("");
				$("#sortBy").val("");
				dataSortKey = "";
			}
			$("#sortKey").val(dataSortKey);
			$("#dailyReportForm").submit();
		});
	});
</script>