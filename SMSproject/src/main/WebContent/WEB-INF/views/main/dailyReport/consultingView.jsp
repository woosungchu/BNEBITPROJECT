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
							<h1 class="col-sm-12 text-center">상담일지 작성</h1>
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
							<label for="inputEmail3" class="col-sm-2 text-left control-label">2차 거래선</label>
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
						<div class="form-group">
							<div class="col-sm-12">
								<input type="button" class="form-control btn btn-primary" value="상담일지작성">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-6">
								<input type="button" class="form-control btn btn-primary" value="상담일지수정">
							</div>
							<div class="col-sm-6">
								<input type="button" class="form-control btn btn-primary" value="상담일지삭제">
							</div>
							<hr>
							<hr>
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
									<td>2016년 2월 22일 상담일지(1)</td>
								</tr>
								<tr>
									<td class="text-center">2</td>
									<td>2016년 2월 22일 상담일지(2)</td>
								</tr>
								<tr>
									<td class="text-center">3</td>
									<td>2016년 2월 22일 상담일지(3)</td>
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
</body>
</html>