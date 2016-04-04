$(document).ready(function () {

	$(document).on('readystatechange',function(){
		if(document.readyState === 'complete'){
			$('#bodyContainer').css('visibility', 'visible');
		}
	})

	$(window).resize(function(){
		flotr2Graph();
	});

	//Flotr2 Graph
	function flotr2Graph() {
		if(!$('#main-graph').length) return false;

		$('#main-graph').height($('#main-graph').width()/2.5);
		//col-md때는 hidden
		if($(window).width() >= 1200 || $(window).width() < 992){
			var
			container = $('#main-graph')[0],
			d1 = [[0, 3], [4, 8], [8, 5], [9, 13]], // First data series
			d2 = [],                                // Second data series
			i, graph;

			// Generate first data set
			for (i = 0; i < 14; i += 0.5) {
				d2.push([i, Math.sin(i)]);
			}

			// Draw Graph
			graph = Flotr.draw(container, [ d1, d2 ], {
				xaxis: {
					minorTickFreq: 4
				},
				grid: {
					minorVerticalLines: true
				}
			});
		};
	};

	//매출액, 매출목표
	function profitSalesGoal(){
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
			}// success:function(){}
		});
	}

	//Calendar
	function setCalendar(){
		if(!$('#calendar').length) return false;

		$('#calendar').html('');
		$('#calendar').fullCalendar({
			header: {
				left: 'title',
				center: '',
				right: 'prev,next'
			},
			handleWindowResize : false,
			eventSources:[{
				events:function(start, end, timezone, callback){
					$.ajax({
						url:"getSessionData",
						success:function(data){
							if(data=='"Manager"'){
								$.ajax({
									url:"calendarGetPlanManager",
									type:'post',
									dataType:'json',
									success:function(data){
										var events=[];
										var eventList=data.Event;
										for(var i=0;i<eventList.length;i++){
											events.push({
												title:eventList[i].title,
												start:eventList[i].eventDate.substring(0,10),
												rendering:'background'
											});
										}
										var dailyPlanList=data.DailyPlanList;
										for(var i=0;i<dailyPlanList.length;i++){
											events.push({
												title:dailyPlanList[i].weeklyPlan.employee.empName,
												start:dailyPlanList[i].planDate.substring(0,10),
												className:dailyPlanList[i].weeklyPlan.weeklyPlanId
											});
										}
										callback(events);
									}
								});	// $.ajax "calendarGetPlanManager"
							}else{
								var array=data.split('"');
								$.ajax({
									url:"/calendarGetPlan",
									type:'post',
									data:{
										"empId":array[1]
									},
									dataType:'json',
									success:function(data){
										var events=[];
										var eventList=data.Event;
										for(var i=0;i<eventList.length;i++){
											events.push({
												title:eventList[i].title,
												start:eventList[i].eventDate.substring(0,10),
												rendering:'background'
											});
										}
										var planList=data.Plan;
										for(var i=0;i<planList.length;i++){
											events.push({
												title:planList[i].content,
												start:planList[i].dailyPlan.planDate.substring(0,10),
												className:planList[i].dailyPlan.weeklyPlan.weeklyPlanId
											});
										}
										callback(events);
									}
								});
							}
						}// success
					});// $.ajax "getSessionData"
				}	//events:function(){}
			}],	// eventSource
			eventClick:function(calEvent, jsEvent, view){
				if("${LOGIN_USER.position}"=="Salesman"){
					location.href="/checkWeeklyPlan?monday="+calEvent.className;
				}else{
					location.href="/viewWeeklyPlan?weeklyPlanId="+calEvent.className;
				}
			},
			eventLimit : true,
			eventMouseover : function(calEvent, jsEvent) {
				var tooltip = '<div class="tooltip bottom" id="tooltip" style="padding:5px;padding-left:10px;padding-right:10px;background-color:#fff;border:3px solid #54a0c6;color:#555;position:absolute;z-index:10001;">'
				+ calEvent.title + '</div>';
			    $("body").append(tooltip);
			    $(this).mouseover(function(e) {
			        $(this).css('z-index', 10000);
			        $('#tooltip').fadeIn('500');
			        $('#tooltip').fadeTo('10', 1.9);
			    }).mousemove(function(e) {
			        $('#tooltip').css('top', e.pageY + 10);
			        $('#tooltip').css('left', e.pageX + 15);
			    });
	        },
	        eventMouseout: function(calEvent, jsEvent) {
	            $(this).css('z-index', 8);
	            $('#tooltip').remove();
	        }
		});
	}

	//planCheck
	$('.plan-checkbox').on('click',function(){
		var checked ;
		if($(this)[0].checked)checked = true;
		else checked = false;

		$.ajax({
			url : '/planCheck',
			data : {
				planId : $(this)[0].dataset.id,
				checked : checked
			},
			success : function(result){
				if(result !== 'success'){
					alert("기술적인 버그가 발생했습니다. -plan-checkbox");
				}
			}
		})
	});

	//planCheck
	$('#btnChart').on('click',function(){
		location.href="/viewChart";
	});

	$('#btnMoreClient').on('click',function(){
		location.href="/client/clientAddForm";
	});

	//weather
	function loadWeather(location, woeid) {
		if(!$('#weather').length) return false;
	  $.simpleWeather({
	    location: location,
	    woeid: woeid,
	    unit: 'c',
	    success: function(weather) {
	      html = '<h2><i class="icon-'+weather.code+'"></i> '+weather.temp+'&deg;'+weather.units.temp
	      +' <small>&apos;'+weather.city+'</small></h2>';

	      $("#weather").html(html);
	    },
	    error: function(error) {
	      $("#weather").html('<p>'+error+'</p>');
	    }
	  });
	}

	//setCountLabel
	function countPlan(){
		$.ajax({
			url : "/countPlan",
			success : function(result){
				for (var int = 0; int < result.length; int++) {
					var emp = result[int];
					var target = $('#to-do-list li[data-empid = "'+emp.empId+'"]');
					target.find('span').text(emp.count)
										.removeClass('label-default')
										.addClass('label-primary');
					target.parent().prepend(target);
				}
			}
		})
	}

	function init(){
		setCalendar();
		flotr2Graph();
		loadWeather('Seoul','');
		countPlan();
		profitSalesGoal();
	}

	init();
});
