<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="${contextPath}/assets/js/dailyReport/dailyReportList.js" type="text/javascript"></script>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today }" pattern="yyyy/MM/dd" var="sysdate" />
<div class="container-fluid xyz">
	<div class="col-lg-3"></div>
	<!-- col-lg-6 -->
	<div class="col-lg-6">
		<form action="/dailyReport/selectDailyReportList" method="get" id="dailyReportForm">
			<!-- hidden -->
			<input type="hidden" id="eventHoliday" value="${event.holiday }">
			<input type="hidden" id="empId" value="${paramMap.empId }">
			<input type="hidden" id="isFirstBlock" value="${paramMap.isFirstBlock }">
			<input type="hidden" id="isLastBlock" value="${paramMap.isLastBlock }">
			<input type="hidden" id="blockSize" value="${paramMap.blockSize }">
			<input type="hidden" id="currentBlock" value="${pageUtil.currentBlock }">
			<input type="hidden" id="currentPage" value="${pageUtil.currentPage }">
			<input type="hidden" id="totalPageCount" value="${pageUtil.totalPageCount }">
			<input type="hidden" id="totalBlockCount" value="${pageUtil.totalBlockCount }">
			<!-- form -->
			<div class="row">
				<h1 class="text-center">일일보고 목록</h1>
				<hr>
				<!-- search -->
				<div class="form-group">
					<label class="col-sm-1 control-label">
						<span class="col-sm-1 glyphicon glyphicon-search"></span>
					</label>
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
					<a href="/dailyReport/insertDailyReportForm?empId=${paramMap.empId }&regDate=${sysdate}">
						<input type="hidden" class="btn btn-primary form-control" id="isTodayDailyReport" value="${isTodayDailyReport }">
						<input type="button" class="btn btn-primary form-control" id="insertDailyReport" value="일일보고작성">
					</a>
					<hr>
				</div>
			</div>
			<div class="row">
				<!-- dailyReportList table -->
				<input type="hidden" id="searchKey" name="searchKey" value="${paramMap.searchKey }">
				<input type="hidden" id="sortKey" name="sortKey" value="${paramMap.sortKey }">
				<input type="hidden" id="sortBy" name="sortBy" value="${paramMap.sortBy }">
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
									class="feedback" id="feedback${status.index }" data-feedback="${dailyReport.feedback}"></span></td>
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