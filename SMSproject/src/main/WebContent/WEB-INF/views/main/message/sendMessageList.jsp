<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="page" uri="/WEB-INF/tlds/PageingTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="pageSet" value="${pageInfo.pageSet}" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.1/css/bootstrap-datepicker.min.css">
<link href="${contextPath }/assets/css/message.css" rel="stylesheet">
<div class="col-lg-6 col-lg-offset-3">
	<div class="row">
		<form id="searchForm" class="form-horizontal pull-right" action="${contextPath }/message/sendMessageList" method="get">
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
							<option value="empName">직원명</option>
							<option value="content">메시지</option>
						</select>
					</div>
					<div class="col-xs-4">
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
	<div class="row">
		<ul class="nav nav-tabs col-xs-11">
			<li><a href="${contextPath }/message/receiveMessageList">받은 메시지함</a></li>
		    <li class="active"><a href="${contextPath }/message/sendMessageList">보낸 메시지함</a></li>
  		</ul>
	</div>
	<c:choose>
		<c:when test="${empty pageInfo.dataList}">
					보낸 메시지가 존재하지 않습니다.
				</c:when>
		<c:otherwise>
			<div class="row">
				<div class="panel-group message-div" id="accordion" role="tablist">
					<div class="panel panel-default">
						<div class="row">
							<div class="col-xs-5 th text-center">받은 직원</div>
							<div class="col-xs-3 th td-content text-center">메시지</div>
							<div class="col-xs-3 th text-center">등록일</div>
						</div>
					</div>
					<c:forEach var="message" items="${pageInfo.dataList}" varStatus="vs">
						<div class="panel panel-default">
							<div class="row">
								<div class="col-xs-5 td text-center">${message.receiver.empName }(${message.receiver.email })</div>
								<div class="panel-heading col-xs-3 td text-center td-content" role="tab" id="heading${vs.count }">
									<a class="messageRead" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse${vs.count }"
									aria-expanded="false" aria-controls="collapse${vs.count }">
										${message.content}
									</a>
								</div>
								<div class="col-xs-3 td text-center">${message.msgDate }</div>
							</div>
							<div class="row">
								<div id="collapse${vs.count }" class="panel-collapse collapse col-xs-11 text-center" role="tabpanel" aria-labelledby="heading${vs.count }">
									<textarea class="panel-body accordion-content">${message.content}</textarea>
		   						</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="row col-xs-11">
				<div class="text-center">
					<page:PagingTag pageParamName="currentPage" linkUrl="${contextPath}/message/receiveMessageList" pageSet="${pageSet}" />
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/js/bootstrap-select.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.1/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.1/locales/bootstrap-datepicker.ko.min.js"></script>
<script type="text/javascript" src="${contextPath }/assets/js/datepicker.js"></script>
<script type="text/javascript" src="${contextPath }/assets/js/utils.js"></script>
<script type="text/javascript" src="${contextPath }/assets/js/socket/message.js"></script>
<script type="text/javascript">
$(function() {
  /*   if( /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ) {
  $('#searchKey').selectpicker('mobile');
  } */
	$('#searchKey').selectpicker('selectAll');
	$('#searchKey').selectpicker('val','${pageSet.searchKey}');
	DatePickerModule.initDateRangePicker('startDate', 'endDate');
	MessageModule.initSendList();

});
</script>