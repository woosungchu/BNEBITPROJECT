<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		action="/admin/report/updateConsulting" method="post">
		<div class="col-lg-3"></div>
		<div class="col-lg-6" style="background-color: rgba(102, 204, 255,0.4);color: yellow; border-radius : 15px;">
			<div class="form-group">
				<h1 class="col-sm-12 text-center">상담일지 수정</h1>
			</div>
			<hr>
			<div class="form-group">
				<label class="col-sm-1 control-label">소속</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" name="dept.deptName"
						value="${employee.dept.deptName}"
						readonly="readonly">
				</div>
				<label class="col-sm-1 control-label">성명</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" name="empName"
						value="${employee.empName}" readonly="readonly">
				</div>
				<label class="col-sm-2 control-label">작성일</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" name="regDate"
						value="${consulting.regDate }" readonly="readonly">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label">제목</label>
				<div class="col-sm-11">
					<input type="text" class="form-control" name="title"
						value="${consulting.title}" readonly="readonly">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 text-left control-label" style="width: 90px;">고객코드</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="clientCode${consulting.consultingId }" name="client.clientCode"
						value="${consulting.client.clientCode }">
				</div>
				<label class="col-sm-2 control-label" style="width: 80px;">고객명</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="clientName${consulting.consultingId }" name="client.clientName"
						value="${consulting.client.clientName }" readonly="readonly">
				</div>
				<label class="col-sm-2 control-label" style="width: 85px;">대표자</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="ceo${consulting.consultingId }" name="client.ceo"
						value="${consulting.client.ceo }" readonly="readonly">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 text-left control-label" style="width: 100px;">2차 거래선</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="secondName${consulting.consultingId }" name="client.secondName"
						value="${consulting.client.secondName }" readonly="readonly">
				</div>
				<label class="col-sm-2 control-label" style="width: 70px;">주소</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="address${consulting.consultingId }" name="client.address"
						value="${consulting.client.address }" readonly="readonly" style="width: 375px;">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" style="text-align: left; padding-bottom: 7px;">상담내역</label>
				<textarea class="form-control" rows="5" name="content">${consulting.content}</textarea>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">파일</label> <a
					id="consultingImg${consulting.consultingId }" >${consulting.consultingImg.imgName }</a>
				<input type="hidden" value="${consulting.consultingImg.imgName}" name="consultingImg.imgName"	/>
			</div>

			<div class="form-group">
				<div class="col-sm-6">
					<input type="submit" class="form-control btn btn-primary" value="저장">
				</div>
				<div class="col-sm-6">
					<a href="/admin/report/viewConsulting?consultingId=${consulting.consultingId}&empName=${employee.empName}&dept.deptName=${employee.dept.deptName}">
					<input type="button" class="form-control btn btn-primary" value="취소">
					</a>
				</div>
			</div>
		</div>
		<div class="col-lg-3"></div>
		<input type="hidden" value="${consulting.consultingId}" name="consultingId" id="consultingId"/>
	</form>
</div>

<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script>
$(document).ready(function(){

	var consultingId = $("#consultingId").val();

	// 수정 시 고객정보 조회
	$("#clientCode" + consultingId).keyup(function() {
		console.log(consultingId);
		var clientCode = $("#clientCode" + consultingId).val();
		$.ajax({
			url : "/rest/client/searchClient",
			type : "post",
			dataType : "json",
			data : {
				"clientCode" : clientCode
			},
			success : function(data) {
				$("#clientId" + consultingId).val(data.clientId);
				$("#clientName" + consultingId).val(data.clientName);
				$("#ceo" + consultingId).val(data.ceo);
				$("#secondName" + consultingId).val(data.secondName);
				$("#address" + consultingId).val(data.address);
			}
		});
	});
});
</script>