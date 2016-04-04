//toggle
$("#menu-toggle").click(function(e) {
	e.preventDefault();
	console.log("!!!!");
	$("#wrapper").toggleClass("toggled");
});
$("#menu-toggle-2").click(function(e) {
	e.preventDefault();
	$("#wrapper").toggleClass("toggled-2");
	$('#menu ul').hide();
});
$(document).ready(function() {

	//sidebar menu
	$('#menu > li > a').click(function() {
		var checkElement = $(this).next('ul');
		$('#menu ul').not(checkElement).slideUp('normal');
		checkElement.slideToggle('normal');
	});
	$('#menu li a').click(function() {
		var liParent = $(this).parent('li');

		$('#menu li').not(liParent).removeClass('active');
		liParent.addClass('active');
	});

	function activateSidebar() {
		//경로 가져옴 (도메인 제외)
		//home이면 그냥 탭에 직접 지정 후 리턴;
		var path = location.pathname;
		if (path == "/") {
			$('#sidebar-wrapper li:first').addClass('active');
			return;
		}
		
		// 선택된 것을 가져옴
		var selected = $('#sidebar-wrapper').find('a[href*="' + path + '"]');
		//초기화
		$('#menu li').removeClass('active');
		//a태그 바로 위의 li를 찾고 active 지정후  
		if (selected.parent().is('li')) {
			var parent = selected.parent();
			parent.addClass('active');
			//ul 아래의 li인지 확인 // true면 그 ul을 내림
			if (parent.parent().is('ul')) {
				var ul = parent.parent();
				ul.slideDown();
			}
		}
	}

	function initMenu() {
		$('#menu ul').hide();
		activateSidebar();
	}

	initMenu();
})