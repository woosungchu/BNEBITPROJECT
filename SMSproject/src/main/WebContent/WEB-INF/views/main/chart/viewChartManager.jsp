<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 화면에 맞춘 렌더링 및 확대 / 축소 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap Test</title>
<!-- Bootstrap -->
<link rel="stylesheet" href="http://cdn.oesmith.co.uk/morris-0.4.3.min.css">
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-9">
				<h3>매출액 차트</h3>
			</div>
			<div class="btn-group col-sm-3" role="group" aria-label="">
			  <button type="button" class="btn btn-default" id="salesDay" onclick="salesChart(this.id);">일별</button>
			  <button type="button" class="btn btn-default" id="salesWeek" onclick="salesChart(this.id);">주별</button>
			  <button type="button" class="btn btn-default" id="salesMonth" onclick="salesChart(this.id);">월별</button>

			  <div class="btn-group" role="group">
			    <button type="button" id="barBtnEmpName" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    </button>
			    <ul class="dropdown-menu" id="barEmpList">
			      <li><a href="#" onclick="barClickAllEmp();">전체</a></li>
			      <li role="separator" class="divider"></li>
			    </ul>
			  </div>
			</div>
		</div>
		<!--/row-->
		<hr>
		<div class="row">
			<div class="col-md-12">
				<div id="sales-chart" style="height: 300px;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-9">
				<h3>달성률 차트</h3>
			</div>
			<div class="btn-group col-sm-3" role="group" aria-label="">
			  <button type="button" class="btn btn-default" id="salesRateDay" onclick="salesRateChart(this.id);">일별</button>
			  <button type="button" class="btn btn-default" id="salesRateWeek" onclick="salesRateChart(this.id);">주별</button>
			  <button type="button" class="btn btn-default" id="salesRateMonth" onclick="salesRateChart(this.id);">월별</button>

			  <div class="btn-group" role="group">
			    <button type="button" id="lineBtnEmpName" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    </button>
			    <ul class="dropdown-menu" id="lineEmpList">
			      <li><a href="#" onclick="lineClickAllEmp();">전체</a></li>
			      <li role="separator" class="divider"></li>
			    </ul>
			  </div>
			</div>
		</div>
		<!--/row-->
		<div class="row">
			<hr>
			<div class="col-md-12">
				<div id="salesRateChart" style="height: 300px;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-9">
				<h3>주행거리 차트</h3>
			</div>
			<div class="btn-group col-sm-3" role="group" aria-label="">
				  <button type="button" class="btn btn-default" id="distanceDay" onclick="distanceChart(this.id);">일별</button>
				  <button type="button" class="btn btn-default" id="distanceWeek" onclick="distanceChart(this.id);">주별</button>
				  <button type="button" class="btn btn-default" id="distanceMonth" onclick="distanceChart(this.id);">월별</button>

				  <div class="btn-group" role="group">
				    <button type="button" id="areaBtnEmpName" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				    </button>
				    <ul class="dropdown-menu" id="areaEmpList">
				      <li><a href="#" onclick="areaClickAllEmp();">전체</a></li>
				      <li role="separator" class="divider"></li>
				    </ul>
				  </div>
				</div>
		</div>
		<!--/row-->
		<div class="row">
			<hr>
			<div class="col-md-12">
				<div id="distanceChart" style="height: 300px;"></div>
			</div>
		</div>
		<div class="row">
			<hr>
			<div class="col-md-6">
				<div id="donut-example" style="height: 250px;"></div>
			</div>
			<div class="col-md-6">
				<div id="bar-example" style="height: 250px;"></div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript"
	src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script type="text/javascript"
	src="http://cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.0/morris.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min.js"></script>
<script type="text/javascript" src="${contextPath}/assets/js/morrisManager.js"></script>
</html>