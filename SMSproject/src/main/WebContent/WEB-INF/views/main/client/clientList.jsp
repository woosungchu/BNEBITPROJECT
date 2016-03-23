<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="page" uri="/WEB-INF/tlds/PageingTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="pageSet" value="${pageInfo.pageSet}" />
<c:set var="requestUri" value="${requestScope['javax.servlet.forward.request_uri']}" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.1/css/bootstrap-datepicker.min.css">
<div class="row">
	<form id="searchForm" class="form-horizontal pull-right" action="${contextPath }${requestUri}" method="get">
		<input type="hidden" id="sortName" name="sortName" value="${pageSet.sortName}" />
		<input type="hidden" id="sortBy" name="sortBy" value="${pageSet.sortBy}" />
		<input type="hidden" name="clientId" value="${client.clientId}" />
		<div class="row">
			<div class="form-group">
				<div class="col-xs-5">
					<input type="text" class="form-control" id="startDate"
						name="startDate" value="${pageSet.startDate }" placeholder="시작일" />
				</div>
				<div class="col-xs-1 text-center">
					<span>-</span>
				</div>
				<div class="col-xs-5">
					<input type="text" class="form-control" id="endDate" name="endDate"
						value="${pageSet.endDate }" placeholder="끝일" />
				</div>
			</div>
		</div>
		<div class="row">
			<div class="form-group">
				<div class="col-xs-4">
					<select class="selectpicker form-control" data-title="선택해주세요"
						id="searchKey" name="searchKey">
						<option value="code">고객코드</option>
						<option value="name">고객명</option>
						<option value="ceo">대표자</option>
						<option value="addr">주소</option>
					</select>
				</div>
				<div class="col-xs-4">
					<!-- input-sm  -->
					<input type="text" class="form-control" placeholder="내용"
						id="searchValue" name="searchValue"
						value="${pageSet.searchValue }" />
				</div>
				<div class="col-xs-3">
					<input type="submit" class="btn btn-default form-control"
						value="검색" />
				</div>
			</div>
		</div>
	</form>
</div>
<c:choose>
	<c:when test="${empty pageInfo.dataList}">
				거래처가 존재하지 않습니다.
			</c:when>
	<c:otherwise>
		<div class="row">
			<div class="table-responsive">
				<table class="table">
					<colgroup>
						<col width="10%" />
						<col width="15%" />
						<col width="15%" />
						<col width="10%" />
						<col width="35%" />
						<col width="15%" />
					</colgroup>
					<thead>
						<tr>
							<th class="text-center">고객코드</th>
							<th class="text-center"><a class="sortHeader"
									data-sortname="client_name" href="#!">고객명</a><span
								id="client_name"></span></th>
							<th class="text-center">2차거래선</th>
							<th class="text-center">대표자</th>
							<th class="text-center">주소</th>
							<th class="text-center">등록일</th>
						</tr>
					</thead>
					<c:forEach var="client" items="${pageInfo.dataList}">
						<tr>
							<td class="text-center">
								<a
									href="${contextPath}/client/clientView?clientId=${client.clientId}&currentPage=${pageSet.currentPage}${pageSet.paramString}">${client.clientCode }</a>
							</td>
							<td class="text-center">${client.clientName }</td>
							<td class="text-center">${client.secondName }</td>
							<td class="text-center">${client.ceo }</td>
							<td class="text-center">${client.address }</td>
							<td class="text-center">${client.regDate }</td>
						</tr>
					</c:forEach>
				</table>
				<div class="text-center">
					<page:PagingTag
						pageParamName="clientId=${client.clientId}&currentPage" linkUrl="${contextPath}${requestUri}" pageSet="${pageSet}" />
				</div>
			</div>
		</div>
	</c:otherwise>
</c:choose>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/js/bootstrap-select.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.1/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.1/locales/bootstrap-datepicker.ko.min.js"></script>
<script type="text/javascript" src="${contextPath }/assets/js/datepicker.js"></script>
<script type="text/javascript" src="${contextPath }/assets/js/utils.js"></script>
<script type="text/javascript">
$(function() {
  /*   if( /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ) {
  $('#searchKey').selectpicker('mobile');
  } */
	$('#searchKey').selectpicker('selectAll');
	$('#searchKey').selectpicker('val','${pageSet.searchKey}');
	DatePickerModule.initDateRangePicker('startDate', 'endDate');
	SortModule.init();
});
</script>