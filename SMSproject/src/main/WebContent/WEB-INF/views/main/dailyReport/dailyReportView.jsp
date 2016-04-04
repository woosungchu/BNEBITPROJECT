<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="${contextPath }/assets/js/dailyReport/dailyReportView.js" type="text/javascript"></script>
<link href="${contextPath }/assets/css/message.css" rel="stylesheet">
<div class="container-fluid xyz">
	<div class="form-horizontal">
		<div class="col-lg-3"></div>
		<div class="col-lg-6">
			<!-- ★★★★★dailyReportView★★★★★ -->
			<div class="form-group">
				<h1 class="col-sm-12 text-center">일일보고</h1>
			</div>
			<input type="hidden" id="dailyReportId" name="dailyReportId" value="${dailyReport.dailyReportId }">
			<input type="hidden" id="isTodayDailyReport" value="${isTodayDailyReport }">
			<input type="hidden" id="position" value="${employee.position }">
			<div class="form-group">
				<label class="col-sm-1 control-label">소속</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id=""
						value="${dailyReport.employee.dept.deptName }" readonly="readonly" />
				</div>
				<label class="col-sm-1 control-label">성명</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="" value="${dailyReport.employee.empName }" readonly="readonly" />
				</div>
				<label class="col-sm-2 control-label">작성일</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="regDate" name="regDate"
						value="${dailyReport.regDate }" readonly="readonly" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label">제목</label>
				<div class="col-sm-11">
					<input type="text" class="form-control" id=""
						value="${dailyReport.title }" readonly="readonly" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 text-left control-label">매출목표</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id=""
						value="${dailyPlan.salesGoal }" readonly="readonly" />
				</div>
				<label class="col-sm-2 control-label">매출액</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id=""
						value="${dailyReport.profit }" readonly="readonly" />
				</div>
				<label class="col-sm-2 control-label">달성률</label>
				<div class="col-sm-2">
					<fmt:formatNumber var="profitRate"
						value="${dailyReport.profit / dailyPlan.salesGoal * 100}"
						pattern="#.##" />
					<input type="text" class="form-control" id=""
						value="${profitRate }%" readonly="readonly" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 text-left control-label">출근시 계기판</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id=""
						value="${dailyReport.departure }" readonly="readonly" />
				</div>
				<label class="col-sm-2 control-label">퇴근시 계기판</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id=""
						value="${dailyReport.arrival }" readonly="readonly" />
				</div>
				<label class="col-sm-2 control-label">주행거리</label>
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
						value="${dailyReport.feedback }"/>
				</div>
				<div class="col-sm-2">
					<input type="button" class="form-control btn btn-primary"
						id="confirmDailyReport" value="결재">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-6">
				<a href="/dailyReport/updateDailyReportForm?dailyReportId=${dailyReport.dailyReportId }&empId=${dailyReport.employee.empId }&regDate=${dailyReport.regDate}">
					<input type="button" class="form-control btn btn-primary"
						id="updateDailyReport" value="일일보고수정">
				</a>
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
			<!-- ★★★★★consulting★★★★★ -->
			<h1 class="text-center">상담일지 목록</h1>
			<div class="panel-group" id="accordionList" role="tablist"
				aria-multiselectable="true">
				<!-- ★★★★★consultingInsert★★★★★ -->
				<div class="panel panel-default">
					<div class="panel-heading" role="tab" id="headingOne">
						<h4 class="panel-title">
							<a data-toggle="collapse" data-parent="#accordionList"
								href="#collapseOne" aria-expanded="false"
								aria-controls="collapseOne"> <input type="button"
								class="form-control btn btn-primary" id="insertConsulting" value="상담일지작성">
							</a>
						</h4>
					</div>
				</div>
				<input type="hidden" id="countConsulting"
						value="${fn:length(consultingList) }">
				<div id="collapseOne" class="panel-collapse collapse"
					role="tabpanel" aria-labelledby="headingOne">
					<form id="consultingInsertForm" method="post" enctype="multipart/form-data">
					<input type="hidden" name="dailyReport.dailyReportId"
						value="${dailyReport.dailyReportId }">
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-1 control-label">소속</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" id=""
									value="${dailyReport.employee.dept.deptName }"
									readonly="readonly">
							</div>
							<label class="col-sm-1 control-label">성명</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" id=""
									value="${dailyReport.employee.empName }" readonly="readonly">
							</div>
							<label class="col-sm-2 control-label">작성일</label>
							<div class="col-sm-2">
								<jsp:useBean id="today" class="java.util.Date" />
								<fmt:formatDate value="${today }" pattern="yyyy/MM/dd"
									var="sysdate" />
								<input type="text" class="form-control" id=""
									value="${sysdate }" readonly="readonly">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-1 control-label">제목</label>
							<div class="col-sm-11">
								<fmt:formatDate value="${today }" pattern="M" var="titleMonth" />
								<fmt:formatDate value="${today }" pattern="dd" var="titleDate" />
								<input type="text" class="form-control" id="title" name="title"
									value="${titleMonth }월 ${titleDate }일 상담일지("
									readonly="readonly">
							</div>
						</div>
						<input type="hidden" id="clientId" name="client.clientId" value="">
						<div class="form-group">
							<label class="col-sm-2 text-left control-label">고객코드</label>
							<div class="col-sm-2">
								<input type="text" class="form-control clientCode" id="clientCode"  value="">
							</div>
							<label class="col-sm-2 control-label">고객명</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="clientName" value=""
									readonly="readonly">
							</div>
							<label class="col-sm-2 control-label">대표자</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="ceo" value=""
									readonly="readonly">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 text-left control-label">2차 거래선</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" id="secondName" value=""
									readonly="readonly">
							</div>
							<label class="col-sm-2 control-label">주소</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" id="address" value=""
									readonly="readonly">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">상담내역</label>
							<textarea class="form-control" rows="5" id="content" name="content"></textarea>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">파일</label>
							<input class="col-sm-8" type="file" id="file" name="file">
						</div>
						<div class="form-group">
							<div class="col-sm-12">
								<input type="submit" class="form-control btn btn-primary"
									value="저장" />
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
			<!-- ★★★★★consultingList★★★★★ -->
			<div class="panel-group" id="accordion" role="tablist"
				aria-multiselectable="true">
				<c:forEach items="${consultingList }" var="consulting"
					varStatus="status">
					<div class="panel panel-default" id="consultingList">
						<div class="panel-heading consultingList" role="tab"
							id="headingTwo${status.count}">
							<h4 class="panel-title consultingList">
								<a class="collapsed" data-toggle="collapse"
									data-parent="#accordion" href="#collapse${status.count}"
									aria-expanded="false" aria-controls="collapseTwo"
									id="consultingIndex${status.count}"> ${consulting.title }</a>
							</h4>
						</div>
						<div id="collapse${status.count}" class="panel-collapse collapse"
							role="tabpanel" aria-labelledby="headingTwo">
							<form class="consultingUpdateForm" method="post" enctype="multipart/form-data">
							<input type="hidden" id="dailyReportId" name="dailyReport.dailyReportId" value="${dailyReport.dailyReportId }">
							<input type="hidden" name="consultingId" value="${consulting.consultingId}"/>
							<div class="panel-body">
								<div class="form-group">
									<label class="col-sm-1 control-label">소속</label>
									<div class="col-sm-3">
										<input type="text" class="form-control" id=""
											value="${dailyReport.employee.dept.deptName }"
											readonly="readonly">
									</div>
									<label class="col-sm-1 control-label">성명</label>
									<div class="col-sm-2">
										<input type="text" class="form-control" id=""
											value="${dailyReport.employee.empName }" readonly="readonly">
									</div>
									<label class="col-sm-2 control-label">작성일</label>
									<div class="col-sm-3">
										<input type="text" class="form-control" id="consultingRegDate"
											value="${consulting.regDate }" readonly="readonly">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-1 control-label">제목</label>
									<div class="col-sm-11">
										<input type="text" class="form-control" id=""
											value="${consulting.title }" readonly="readonly">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 text-left control-label ">고객코드</label>
									<div class="col-sm-2">
										<input type="text" class="form-control clientCode" id="clientCode${consulting.consultingId }"
											value="${consulting.clientCode }" name="client.clientCode" data-id="${consulting.consultingId}" readonly="readonly">
									</div>
									<label class="col-sm-2 control-label">고객명</label>
									<div class="col-sm-2">
										<input type="text" class="form-control" id="clientName${consulting.consultingId }"
											value="${consulting.clientName }" readonly="readonly">
									</div>
									<label class="col-sm-2 control-label">대표자</label>
									<div class="col-sm-2">
										<input type="text" class="form-control" id="ceo${consulting.consultingId }"
											value="${consulting.ceo }" readonly="readonly">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 text-left control-label">2차 거래선</label>
									<div class="col-sm-3">
										<input type="text" class="form-control" id="secondName${consulting.consultingId }"
											value="${consulting.secondName }" readonly="readonly">
									</div>
									<label class="col-sm-2 control-label">주소</label>
									<div class="col-sm-5">
										<input type="text" class="form-control" id="address${consulting.consultingId }"
											value="${consulting.address }" readonly="readonly">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">상담내역</label>
									<textarea class="form-control" rows="5" id="content${consulting.consultingId }"name="content" readonly="readonly">${consulting.content }</textarea>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">파일</label>
									<input type="hidden" class="form-control" id="imgName${consulting.consultingId }" name="consultingImg.imgName" value="${consulting.imgName}">
									<div class="row" id="fileBlock${consulting.consultingId }">
										<a href="/consulting/downloadConsultingFile?originalFileName=${consulting.originImgName }&fileName=${consulting.imgName}" class="col-sm-7" id="consultingImg${consulting.consultingId }">
											<c:if test="${consulting.imgName != null}">
												${consulting.originImgName }
											</c:if>
										</a>
										<input class="col-sm-2 btn btn-primary btn-sm deleteImg" type="hidden" id="deleteImg${consulting.consultingId }" value="파일삭제" disabled="disabled">
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-6">
										<input type="button" class="form-control btn btn-primary updateConsultingForm"
											id="updateConsultingForm${consulting.consultingId}"
											data-id="${consulting.consultingId}" value="수정" />
									</div>
									<div class="col-sm-6">
										<input type="button" class="form-control btn btn-primary deleteConsulting"
											id="deleteConsulting${consulting.consultingId}"
											data-id="${consulting.consultingId}" value="삭제" />
									</div>
									<div class="col-sm-12">
										<input type="button" class="form-control btn btn-primary updateConsultingBtn"
											data-id="${consulting.consultingId}" value="저장" />
									</div>
								</div>
							</div>
							</form>
						</div>
					</div>
				</c:forEach>
			</div>
			</div>
			<div class="col-lg-3"></div>
	</div>
</div>