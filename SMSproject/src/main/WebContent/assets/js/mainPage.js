$(document).ready(function () {

	$(window).load(function() {
		$('#bodyContainer').css('visibility', 'visible');
	});
	$(window).resize(function(){
		flotr2Graph();
	});
	
	//Flotr2 Graph
	function flotr2Graph() {
		$('#main-graph').height($('#main-graph').width()/2.5);
		
		if($(window).width() > 1200){
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

	//Calendar
	$('#calendar').fullCalendar({
		header: {
			left: 'title',
			center: '',
			right: 'prev,next'
		},
		handleWindowResize : false
	});
	
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
				console.log(result);
			}
		})
	});
	
	//weather
	function loadWeather(location, woeid) {
	  $.simpleWeather({
	    location: location,
	    woeid: woeid,
	    unit: 'c',
	    success: function(weather) {
	      html = '<h2><i class="icon-'+weather.code+'"></i> '+weather.temp+'&deg;'+weather.units.temp
	      +', <small>'+weather.city+'</small></h2>';
	      
	      $("#weather").html(html);
	    },
	    error: function(error) {
	      $("#weather").html('<p>'+error+'</p>');
	    }
	  });
	}
	
	function init(){
		flotr2Graph();
		loadWeather('Seoul','');
		$('.fc-widget-header').addClass('color-high');
	}

	init();
});
