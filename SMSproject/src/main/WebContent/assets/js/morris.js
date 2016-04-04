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
			"type" : "plan_date"
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
		}
	});
}

function salesChart(id) {
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
			"type" : type
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
			"type" : "plan_date"
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
		}
	});
}

function salesRateChart(id) {
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
			"type" : type
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
			"type" : "plan_date"
		},
		dataType : "json",
		success : function(data) {
			var areaData = [];
			if (data.length != 0) {
				var dataI=0;
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
		}
	});
}


function distanceChart(id) {
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
			"type" : type
		},
		dataType : "json",
		success : function(data) {
			var areaData = [];
			var dataI=0;
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





