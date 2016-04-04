//Morris charts snippet - js

$(document).ready(function() {

	// 매출액, 매출목표
	profitSalesGoal();

	// 매출 달성률
	salesRate();

	// 주행거리
	distance();

});
// ******************************************************************매출액
// 매출액, 매출목표
function profitSalesGoal() {
	$.ajax({
		url : "/chart/profitChart",
		type : 'post',
		data : {
			"chartType" : 1,
			"type" : "plan_date"
		},
		dataType : "json",
		success : function(data) {
			var sales = data.SalesGoal;
			var profit = data.Profit;
			var barData = [];
			var salesI=0;
			if(sales.length>20){
				salesI=sales.length-20;
			}
			for (var i = salesI; i < sales.length; i++) {
				var profitJ=0;
				if(profit.length>20){
					profitJ=profit.length-20;
				}
				for (var j = profitJ; j < profit.length; j++) {
					if (sales[i].key == profit[j].key) {
						barData.push({
							key : sales[i].key.substring(0, 10),
							valueA : profit[j].value,
							valueB : sales[i].value
						});
					}
				}
			}
			document.getElementById('sales-chart').innerHTML = "";
			Morris.Bar({
				element : 'sales-chart',
				data : barData,
				xkey : 'key',
				ykeys : [ 'valueA', 'valueB' ],
				labels : [ '매출목표', '매출액' ],
				hideHover : 'auto',
				xLabels:"day"
			});
			document.getElementById('barBtnEmpName').innerHTML = "전체";
			$('<span class="caret"></span>').appendTo('#barBtnEmpName');
		}// success:function(){}
	});

	$.ajax({
		url : "selectEmployeeByDept",
		dataType : 'json',
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				$('<li><a id="bar_'+data[i].empId+'"onclick="barClickEmp('+data[i].empId+');">'+data[i].empName+'</a></li>').appendTo('#barEmpList');
			}
		}
	});
}

function barClickAllEmp() {
	$.ajax({
		url : "/chart/profitChart",
		type : 'post',
		data : {
			"chartType" : 1,
			"type" : "plan_date"
		},
		dataType : "json",
		success : function(data) {
			var sales = data.SalesGoal;
			var profit = data.Profit;
			var barData = [];
			var salesI=0;
			if(sales.length>20){
				salesI=sales.length-20;
			}
			for (var i = salesI; i < sales.length; i++) {
				var profitJ=0;
				if(profit.length>20){
					profitJ=profit.length-20;
				}
				for (var j = profitJ; j < profit.length; j++) {
					if (sales[i].key == profit[j].key) {
						barData.push({
							key : sales[i].key.substring(0, 10),
							valueA : profit[j].value,
							valueB : sales[i].value
						});
					}
				}
			}
			document.getElementById('sales-chart').innerHTML = "";
			Morris.Bar({
				element : 'sales-chart',
				data : barData,
				xkey : 'key',
				ykeys : [ 'valueA', 'valueB' ],
				labels : [ '매출목표', '매출액' ],
				hideHover : 'auto',
				xLabels:"day"
			});
			document.getElementById('barBtnEmpName').innerHTML = "전체";
			$('<span class="caret"></span>').appendTo('#barBtnEmpName');
		}// success:function(){}
	});
}
function barClickEmp(empId) {
	$.ajax({
		url : "/chart/profitChart",
		type : 'post',
		data : {
			"chartType" : 2,
			"type" : "plan_date",
			"empId" : empId
		},
		dataType : "json",
		success : function(data) {
			var sales = data.SalesGoal;
			var profit = data.Profit;
			console.log(data);
			var barData = [];
			if (sales.length != 0) {
				var salesI=0;
				if(sales.length>20){
					salesI=sales.length-20;
				}
				for (var i = salesI; i < sales.length; i++) {
					var profitJ=0;
					if(profit.length>20){
						profitJ=profit.length-20;
					}
					for (var j = profitJ; j < profit.length; j++) {
						if (sales[i].key == profit[j].key) {
							barData.push({
								key : sales[i].key.substring(0, 10),
								valueA : profit[j].value,
								valueB : sales[i].value
							});
						}
					}
				}
				document.getElementById('sales-chart').innerHTML = "";
				var bar = Morris.Bar({
					element : 'sales-chart',
					data : barData,
					xkey : 'key',
					ykeys : [ 'valueA', 'valueB' ],
					labels : [ '매출목표', '매출액' ],
					hideHover : 'auto',
					xLabels:"day"
				});
			} else {
				document.getElementById('sales-chart').innerHTML = "";
				var bar = Morris.Bar({
					element : 'sales-chart',
					data : [ {
						key : 0,
						valueA : 0,
						valueB : 0
					} ],
					xkey : 'key',
					ykeys : [ 'valueA', 'valueB' ],
					labels : [ '매출목표', '매출액' ],
					hideHover : 'auto',
					xLabels:"day"
				});
			}
			var empName = document.getElementById('bar_' + empId).innerHTML;
			document.getElementById('barBtnEmpName').innerHTML = empName;
			document.getElementById('barBtnEmpName').value = empId;
			$('<span class="caret"></span>').appendTo('#barBtnEmpName');
		}
	});
}
function salesChart(id) {
	var empId = document.getElementById('barBtnEmpName').value;
	var name = document.getElementById('barBtnEmpName').innerHTML;
	var chartType;
	if (name.split('<')[0] == "전체") {
		chartType = 1;
	} else {
		chartType = 2;
	}
	var type;
	var xLabel;
	if (id == "salesDay") {
		type = "plan_date";
		xLabel="day";
	} else if (id == "salesWeek") {
		type = "monday";
		xLabel="week";
	} else if (id == "salesMonth") {
		type = "month";
		xLabel="month";
	}
	$.ajax({
		url : "/chart/profitChart",
		type : 'post',
		data : {
			"chartType" : chartType,
			"type" : type,
			"empId" : empId
		},
		dataType : "json",
		success : function(data) {
			console.log(data);
			var sales = data.SalesGoal;
			var profit = data.Profit;
			var barData = [];
			var salesI=0;
			if(sales.length>20){
				salesI=sales.length-20;
			}
			for (var i = salesI; i < sales.length; i++) {
				var profitJ=0;
				if(profit.length>20){
					profitJ=profit.length-20;
				}
				for (var j = profitJ; j < profit.length; j++) {
					if (sales[i].key == profit[j].key) {
						barData.push({
							key : sales[i].key.substring(0, 10),
							valueA : profit[j].value,
							valueB : sales[i].value
						});
					}
				}
			}
			document.getElementById('sales-chart').innerHTML = "";
			Morris.Bar({
				element : 'sales-chart',
				data : barData,
				xkey : 'key',
				ykeys : [ 'valueA', 'valueB' ],
				labels : [ '매출목표', '매출액' ],
				hideHover : 'auto',
				xLabels:xLabel
			});
		}
	});
}
// **************************************************************************************************************************매출달성률
// 매출 달성률
function salesRate() {
	$.ajax({
		url : "/chart/profitRateChart",
		type : 'post',
		data : {
			"chartType" : 1,
			"type" : "plan_date"
		},
		dataType : 'json',
		success : function(data) {
			var lineData = [];
			var dataI=0;
			if(data.length>20){
				dataI=data.length-20;
			}
			for (var i = dataI; i < data.length; i++) {
				lineData.push({
					key : data[i].key,
					value : data[i].value
				});
			}
			document.getElementById('salesRateChart').innerHTML = "";
			Morris.Line({
				element : 'salesRateChart',
				data : lineData,
				xkey : 'key',
				ykeys : [ 'value' ],
				labels : [ '달성률' ],
				hideHover : 'auto',
				xLabels:"day"
			});
			document.getElementById('lineBtnEmpName').innerHTML = "전체";
			$('<span class="caret"></span>').appendTo('#lineBtnEmpName');
		}
	});
	$.ajax({
		url : "selectEmployeeByDept",
		dataType : 'json',
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				$('<li><a id="line_'+data[i].empId+'"onclick="lineClickEmp('+data[i].empId+');">'+data[i].empName+'</a></li>').appendTo('#lineEmpList');
			}
		}
	});
}

function lineClickAllEmp() {
	$.ajax({
		url : "/chart/profitRateChart",
		type : 'post',
		data : {
			"chartType" : 1,
			"type" : "plan_date"
		},
		dataType : "json",
		success : function(data) {
			var lineData = [];
			var dataI=0;
			if(data.length>20){
				dataI=data.length-20;
			}
			for (var i = dataI; i < data.length; i++) {
				lineData.push({
					key : data[i].key,
					value : data[i].value
				});
			}
			document.getElementById('salesRateChart').innerHTML = "";
			Morris.Line({
				element : 'salesRateChart',
				data : lineData,
				xkey : 'key',
				ykeys : [ 'value' ],
				labels : [ '달성률' ],
				hideHover : 'auto',
				xLabels:"day"
			});
			document.getElementById('lineBtnEmpName').innerHTML = "전체";
			$('<span class="caret"></span>').appendTo('#lineBtnEmpName');
		} // success:function(){}
	});
}

function lineClickEmp(empId) {
	$.ajax({
		url : "/chart/profitRateChart",
		type : 'post',
		data : {
			"chartType" : 2,
			"type" : "plan_date",
			"empId" : empId
		},
		dataType : "json",
		success : function(data) {
			var lineData = [];
			if (data.length != 0) {
				var dataI=0;
				if(data.length>20){
					dataI=data.length-20;
				}
				for (var i = dataI; i < data.length; i++) {
					lineData.push({
						key : data[i].key,
						value : data[i].value
					});
				}
				document.getElementById('salesRateChart').innerHTML = "";
				Morris.Line({
					element : 'salesRateChart',
					data : lineData,
					xkey : 'key',
					ykeys : [ 'value' ],
					labels : [ '달성률' ],
					hideHover : 'auto',
					xLabels:"day"
				});
			} else {
				document.getElementById('salesRateChart').innerHTML = "";
				Morris.Line({
					element : 'salesRateChart',
					data : [ {
						key : 0,
						value : 0
					} ],
					xkey : 'key',
					ykeys : [ 'value' ],
					labels : [ '달성률' ],
					hideHover : 'auto',
					xLabels:"day"
				})
			}
			var empName = document.getElementById('line_' + empId).innerHTML;
			document.getElementById('lineBtnEmpName').innerHTML = empName;
			document.getElementById('lineBtnEmpName').value = empId;
			$('<span class="caret"></span>').appendTo('#lineBtnEmpName');
		}
	});
}

function salesRateChart(id) {
	var empId = document.getElementById('lineBtnEmpName').value;
	var name = document.getElementById('lineBtnEmpName').innerHTML;
	var charType;
	if (name.split('<')[0] == "전체") {
		chartType = 1;
	} else {
		chartType = 2;
	}
	var type;
	var xLabel;
	if (id == "salesRateDay") {
		type = "plan_date";
		xLabel="day";
	} else if (id == "salesRateWeek") {
		type = "monday";
		xLabel="week";
	} else if (id == "salesRateMonth") {
		type = "month";
		xLabel="month";
	}
	$.ajax({
		url : "/chart/profitRateChart",
		type : 'post',
		data : {
			"chartType" : chartType,
			"type" : type,
			"empId" : empId
		},
		dataType : "json",
		success : function(data) {
			var lineData = [];
			var dataI=0;
			if(data.length>20){
				dataI=data.length-20;
			}
			for (var i = dataI; i < data.length; i++) {
				lineData.push({
					key : data[i].key,
					value : data[i].value
				});
			}
			document.getElementById('salesRateChart').innerHTML = "";
			Morris.Line({
				element : 'salesRateChart',
				data : lineData,
				xkey : 'key',
				ykeys : [ 'value' ],
				labels : [ '달성률' ],
				hideHover : 'auto',
				xLabels:xLabel
			});
		} // success:function(){}
	});
}

// *************************************************************************************************주행거리
// 주행거리
function distance() {
	$.ajax({
		url : "/chart/distanceChart",
		type : 'post',
		data : {
			"chartType" : 1,
			"type" : "plan_date"
		},
		dataType : 'json',
		success : function(data) {
			console.log(data);
			var areaData = [];
			if(data.length>20){
				dataI=data.length-20;
			}
			for (var i = dataI; i < data.length; i++) {
				areaData.push({
					key : data[i].key,
					value : data[i].value
				});
			}
			console.log(areaData);
			document.getElementById('distanceChart').innerHTML = "";
			Morris.Area({
				element : 'distanceChart',
				data : areaData,
				xkey : 'key',
				ykeys : [ 'value' ],
				labels : [ '주행거리' ],
				hideHover : 'auto',
				xLabels:"day"
			});
			document.getElementById('areaBtnEmpName').innerHTML = "전체";
			$('<span class="caret"></span>').appendTo('#areaBtnEmpName');
		}
	});
	$.ajax({
		url : "selectEmployeeByDept",
		dataType : 'json',
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				$('<li><a id="area_'+data[i].empId+'"onclick="areaClickEmp('+data[i].empId+');">'+data[i].empName +'</a></li>').appendTo('#areaEmpList');
			}
		}
	});
}

function areaClickAllEmp() {
    $.ajax({
		url : "/chart/distanceChart",
		type : 'post',
		data : {
			"chartType" : 1,
			"type" : "plan_date"
		},
		dataType : "json",
		success : function(data) {
			var areaData = [];
			if(data.length>20){
				dataI=data.length-20;
			}
			for (var i = dataI; i < data.length; i++) {
				areaData.push({
					key : data[i].key,
					value : data[i].value
				});
			}
			document.getElementById('distanceChart').innerHTML = "";
			Morris.Area({
				element : 'distanceChart',
				data : lineData,
				xkey : 'key',
				ykeys : [ 'value' ],
				labels : [ '주행거리' ],
				hideHover : 'auto',
				xLabels:"day"
			});
			document.getElementById('areaBtnEmpName').innerHTML = "전체";
			$('<span class="caret"></span>').appendTo('#areaBtnEmpName');
		} // success:function(){}
    });
}

function areaClickEmp(empId) {
	$.ajax({
		url : "/chart/distanceChart",
		type : 'post',
		data : {
			"chartType" : 2,
			"type" : "plan_date",
			"empId" : empId
		},
		dataType : "json",
		success : function(data) {
			var areaData = [];
			if (data.length != 0) {
				if(data.length>20){
					dataI=data.length-20;
				}
				for (var i = dataI; i < data.length; i++) {
					areaData.push({
						key : data[i].key,
						value : data[i].value
					});
				}
				document.getElementById('distanceChart').innerHTML = "";
				Morris.Area({
					element : 'distanceChart',
					data : areaData,
					xkey : 'key',
					ykeys : [ 'value' ],
					labels : [ '주행거리' ],
					hideHover : 'auto',
					xLabels:"day"
				});
			} else {
				document.getElementById('distanceChart').innerHTML = "";
				Morris.Area({
					element : 'distanceChart',
					data : [ {
						key : 0,
						value : 0
					} ],
					xkey : 'key',
					ykeys : [ 'value' ],
					labels : [ '주행거리' ],
					hideHover : 'auto',
					xLabels:"day"
				})
			}
			var empName = document.getElementById('area_' + empId).innerHTML;
			document.getElementById('areaBtnEmpName').innerHTML = empName;
			document.getElementById('areaBtnEmpName').value = empId;
			$('<span class="caret"></span>').appendTo('#areaBtnEmpName');
		}
	});
}


function distanceChart(id) {
	var empId = document.getElementById('areaBtnEmpName').value;
	var name = document.getElementById('areaBtnEmpName').innerHTML;
	var charType;
	if (name.split('<')[0] == "전체") {
		chartType = 1;
	} else {
		chartType = 2;
	}
	var type;
	var xLabel;
	if (id == "distanceDay") {
		type = "plan_date";
		xLabel="day";
	} else if (id == "distanceWeek") {
		type = "monday";
		xLabel="week";
	} else if (id == "distanceMonth") {
		type = "month";
		xLabel="month";
	}
	$.ajax({
		url : "/chart/distanceChart",
		type : 'post',
		data : {
			"chartType" : chartType,
			"type" : type,
			"empId" : empId
		},
		dataType : "json",
		success : function(data) {
			var areaData = [];
			if(data.length>20){
				dataI=data.length-20;
			}
			for (var i = dataI; i < data.length; i++) {
				areaData.push({
					key : data[i].key,
					value : data[i].value
				});
			}
			document.getElementById('distanceChart').innerHTML = "";
			Morris.Area({
				element : 'distanceChart',
				data : areaData,
				xkey : 'key',
				ykeys : [ 'value' ],
				labels : [ '주행거리' ],
				hideHover : 'auto',
				xLabels:xLabel
			});
		} // success:function(){}
	});
}





