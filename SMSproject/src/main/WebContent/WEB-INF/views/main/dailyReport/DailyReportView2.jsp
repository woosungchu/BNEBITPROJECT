<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

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
<!-- 상담일지 펼쳐보기 접기 테스트 -->
<style type="text/css">
	.consultingViewHide{display: none;}
</style>
</head>
<body style="background-color: #fff;">
	<tiles:insertDefinition name="base.definition">
	</tiles:insertDefinition>
	<div id="wrapper" class="">
		<!-- Page Content -->
		<div id="page-content-wrapper">
			<div class="container-fluid xyz">
				<form class="form-horizontal">
					<div class="col-lg-3"></div>
					<div class="col-lg-6">
						<div class="form-group">
							<h1 class="col-sm-12 text-center">일일보고</h1>
							<div class="col-sm-10"></div>
							<div class="col-sm-2">
								<input type="button" class="btn btn-primary" value="상담일지작성">
							</div>
						</div>
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
							<label for="inputEmail3" class="col-sm-2 text-left control-label">매출목표</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
							<label for="inputEmail3" class="col-sm-2 control-label">매출액</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
							<label for="inputEmail3" class="col-sm-2 control-label">달성률</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 text-left control-label">출근시 계기판</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
							<label for="inputEmail3" class="col-sm-2 control-label">퇴근시 계기판</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
							<label for="inputEmail3" class="col-sm-2 control-label">주행거리</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">업무보고</label>
							<textarea class="form-control" rows="5"></textarea>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">팀장의견</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputEmail3">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-12">
								<input type="button" class="form-control btn btn-primary" value="일일보고수정">
							<hr>
							<hr>
							</div>
						</div>
						<!-- consulting table -->
						<h1 class="text-center">상담일지 목록</h1>
						<div class="col-sm-10"></div>
							<div class="col-sm-2">
								<input type="button" class="btn btn-primary" value="상담일지작성">
							</div>
						<hr>
						<table class="table">
							<thead>
								<tr>
									<td class="text-center">NO</td>
									<td>제목</td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-center">1</td>
									<td class="consultingView">2016년 2월 22일 상담일지(1)</td>
								</tr>
								<tr>
									<td colspan="2" class="consultingViewHide">2016년 2월 22일 상담일지(1)</td>
								</tr>
								<tr>
									<td class="text-center">2</td>
									<td class="consultingView">2016년 2월 22일 상담일지(2)</td>
								</tr>
								<tr>
									<td class="text-center">3</td>
									<td class="consultingView">2016년 2월 22일 상담일지(3)</td>
								</tr>
							</tbody>
						</table>
						<!-- /#consulting table -->
					</div>
					<div class="col-lg-3"></div>
				</form>
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

	<!-- 상담일지 펼쳐보기 접기 테스트 -->
	<script type="text/javascript">
		$(document).ready(function(){
			$(".consultingView").click(function(){
				var consultingView = $(this).parent().next("tr").find("td");

				if(consultingView.is(":visible")) {
					consultingView.slideUp();
				} else {
					consultingView.slideDown();
				}
				/* $(this).parent().next("tr").find("td").toggleClass("consultingViewHide"); */
			});
		});
	</script>
</body>
</html>