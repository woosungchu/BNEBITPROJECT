$(document).ready(function(){
	var keyword = $('#searchInput').val().replace(/\s+$/, '').replace(/\s\s+/g,' ');
	var $container = $('#page-content-wrapper');
	
	//scroll이 쭉 내려갔으면 더 data 불러옴.
	$('#searchContainer').find('.panel-body').on('scroll',function(e){
		var pbody = $(this);
		if(pbody.scrollTop() + pbody.innerHeight() == pbody[0].scrollHeight){
			var list = pbody.data('list');
			var page = pbody.find('.list-group-item').length + 1;
			var template = $(pbody.find('.list-group-item')[0]);
			$.ajax({
				url : '/morePage',
				data : {
					list : list,
					keyword : keyword,
					page : page
				},
				success : function(result){
					var lists = pbody.find('.list-group');
					var user = result.user;
					var array = result.list;
//					if(result == null) return;
					for (var index = 0; index < array.length; index++) {
						var data = array[index];
						template =template.clone()
						
						//switch
						switch (list) {
						case 'empList':
							if(data.position === 'Salesman') data.position = '팀원'
							else if(data.position === 'Manager') data.position = '팀장';
							template.find('a').attr('data-emp-id',data.empId)
											  .text(data.empName+' '+data.dept.deptName+' '+data.position);
							template.find('p').text(data.phone+' / '+data.email);
							break;
						case 'planList':
							var d = data.dailyPlan.planDate.split(" ")[0].split("-");
							var planDate = d[1]+"."+d[2]+"."+d[0];
								
							template.find('a').attr('href','/viewWeeklyPlan?weeklyPlanId='+data.dailyPlan.weeklyPlan.weeklyPlanId+'&rownum=0');
							template.find('a').text(data.content);
							template.find('small').text(planDate);
							break;
						case 'clientList':
							template.find('a').attr('href','/client/clientView?clientId='+data.clientId+'&currentPage=1');
							template.find('a').text(data.clientName +' / '+data.ceo);
							template.find('p').text(data.address+' / '+data.phone+' / '+data.secondName);
							break;
						case 'reportList':
							template.find('a').attr('href','/dailyReport/selectDailyReportView?dailyReportId='+data.dailyReportId+'&empId='+data.empId+'&regDate='+data.regDate);
							template.find('a').text(data.title+' - '+data.employee.empName);
							$(template.find('p')[0]).text(data.content);
							if(data.feedback != null){
								$(template.find('p')[1]).text(data.feedback);
							}
							break;
						case 'consultingList':
							var position = '';
							console.log(data.dailyReport);
							var regDate = data.dailyReport.regDate.substring(0, 10);
							template.find('a').attr('href','/dailyReport/selectDailyReportView?dailyReportId='+data.dailyReport.dailyReportId
																			+'&empId='+data.dailyReport.employee.empId
																			+'&regDate='+regDate);
							template.find('a').text(data.title);
							if(data.dailyReport.employee.position == 'Manager'){
								position = '팀장 ';
							}else if(data.dailyReport.employee.position == 'Salesman'){
								position = '팀원 '
							}
							template.find('small').html(position+ data.dailyReport.employee.empName
									+' <i class="fa fa-exchange"></i> '+data.client.clientName+' '+data.client.ceo);
							template.find('p').text(data.content);
							break;
						default:
							alert("잘못된 data-list 값입니다.");
							break;
						}
						//end switch
						
						lists.append(template);
					}
					init();
				}
			})
		}
	});//end Scroll Event
	
	//hightlight keyword
	function hiliter(keyword, obj){
		console.log(keyword);
		var targets = obj.find('p,h5');
		var words = keyword.split(' ');
		console.log(words);
		for (var t = 0; t < targets.length; t++) {
			var html = $(targets[t]).text();
			//replace
			for (var i = 0; i < words.length; i++) {
				var word = words[i];
				var rgxp = new RegExp(word,'g');
				var repl = '<strong class="text-primary">'+word+'</strong>';
				html = html.replace(rgxp,repl);
			}
			$(targets[t]).html(html);
		}
	}
	
	function init(){
		$('.btn-staff-info').on('click',staffInfo);
		hiliter(keyword, $container);
	}

	init();
});


