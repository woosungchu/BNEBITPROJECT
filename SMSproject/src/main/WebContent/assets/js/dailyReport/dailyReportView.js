$(document).ready(function() {

	// 상담일지 수정 후 저장버튼 hide
	$(".updateConsultingBtn").hide();

	// 고객정보 조회
	$(".clientCode").keyup(function() {
		var $that = $(this);
		var clientCode = $that.val();
		var consultingId = $that.data('id');
		if (consultingId == null) {
			consultingId = '';
		}
		$.ajax({
			url : "/rest/client/searchClient",
			type : "post",
			dataType : "json",
			data : {
				clientCode : clientCode
			},
			success : function(data) {
				$("#clientId" + consultingId).val(data.clientId);
				$("#clientName" + consultingId).val(data.clientName);
				$("#ceo" + consultingId).val(data.ceo);
				$("#secondName" + consultingId).val(data.secondName);
				$("#address" + consultingId).val(data.address);
			},
			error : function(data) {
				$("#clientId" + consultingId).val("");
				$("#clientName" + consultingId).val("");
				$("#ceo" + consultingId).val("");
				$("#secondName" + consultingId).val("");
				$("#address" + consultingId).val("");
			}
		});
	});

	// 일일보고 결재 ajax
	$("#confirmDailyReport").click(function() {
		var dailyReportId = $("#dailyReportId").val();
		var feedback = $("#feedback").val();
		$.ajax({
			url : "/dailyReport/updateDailyReportConfirm",
			type : "post",
			beforeSend : function() {
				if (!feedback) {
					alert('결재내용을 입력해주세요.');
					$("#feedback").focus();
					return false;
				}
			},
			data : {
				feedback : feedback,
				dailyReportId : dailyReportId
			},
			success : function() {
				$("#feedback").attr('disabled', "true");
			}
		});
	});

	// 상담일지 입력 개수 제한
	var countConsulting = $("#countConsulting").val();
	if(parseInt(countConsulting)+1 > 10) {
		$("#insertConsulting").attr("disabled", "true");
	}

	// 상담일지 입력 날짜 제한
	var isTodayDailyReport = $("#isTodayDailyReport").val();
	console.log(isTodayDailyReport);
	if(isTodayDailyReport == "false") {
		$("#insertConsulting").attr("disabled", "true");
	}

	// 상담일지 제목 입력
	$("#insertConsulting").click(function(){
		var index = parseInt(countConsulting) +1;
		var titleData = $("#title").val();
		titleData += index + ")";
		$("#title").val(titleData);
	});

	// 상담일지 입력
	$('#consultingInsertForm').ajaxForm({
		url : "/consulting/insertConsulting",
		beforeSend : function() {
			var clientId = $("#clientName").val();
			if (clientId == "") {
				alert("올바른 고객코드를 입력해주세요.");
				$("#clientCode").focus();
				return false;
			}
		},
		success : function() {
			location.reload();
		}
	});

	// 결재완료시 상담일지 입력, 수정, 삭제 불가
	var feedback = $("#feedback").val();
	if(feedback != "") {
		$("#insertConsulting").attr("disabled", "true");
		$(".updateConsultingForm").attr("disabled", "true");
		$(".deleteConsulting").attr("disabled", "true");
	}

	// 상담일지 수정
	$(".updateConsultingForm").click(function(){
		var consultingId = $(this).data("id");
		console.log(consultingId);

		$(this).hide();
		$(this).parents().siblings().children(".deleteConsulting").hide();
		$(this).parents().siblings().children(".updateConsultingBtn").show();
		$("#fileBlock" + consultingId).append('<input class=\"col-sm-10\" type=\"file\" id=\"file'+consultingId+'\" name=\"file\">');

		$("#clientCode" + consultingId).attr("readonly", false);
		$("#content" + consultingId).attr("readonly", false);
		//$("#deleteImg" + consultingId).removeAttr("disabled");

	});

	$('.updateConsultingBtn').on('click', function() {
		var $form = $(this).parents('.consultingUpdateForm');
		var consultingId = $(this).data("id");
		var clientCode = $("#clientCode"+ consultingId).val();
		var content = $("#content"+ consultingId).val();

		$form.ajaxSubmit({
			url : "/consulting/updateConsulting",
			beforeSend : function() {
				var clientId = $("#clientName" + consultingId).val();
				if (clientId == "") {
					alert("올바른 고객코드를 입력해주세요.");
					$("#clientCode" + consultingId).focus();
					return false;
				}
			},
			success : function(data) {
				var originalFileName = JSON.parse(data.originalFileName);
				var fileName = JSON.parse(data.fileName);
				$("#clientCode"+ consultingId).val(clientCode);
				$("#content"+ consultingId).val(content);
				$("#imgName" + consultingId).val(originalFileName);
				$("#consultingImg" + consultingId).text(originalFileName);
				$("#consultingImg" + consultingId).attr("href", "/consulting/downloadConsultingFile?originalFileName="+originalFileName+"&fileName="+fileName);
			}
		});

		$(this).hide();
		$(this).parent().siblings().children(".deleteConsulting").show();
		$(this).parent().siblings().children(".updateConsultingForm").show();
		$("#file" + consultingId).remove();
		//$("#deleteImg" + consultingId).attr("disabled", true);

		$("#clientCode" + consultingId).attr("readonly", true);
		$("#content" + consultingId).attr("readonly", true);
	});

	// 상담일지 삭제
	$(".deleteConsulting").off('click').on('click', function(){
		var consultingId = $(this).data("id");
		var dailyReportId = $("#dailyReportId").val();

		alert(consultingId);
		$.ajax({
			url : "/consulting/deleteConsulting",
			type : "post",
			data : {
				"consultingId" : consultingId,
				"dailyReport.dailyReportId" : dailyReportId
			},
			success : function() {
				location.reload();
			}
		});
	});

	// 파일 삭제
	/* $(".deleteImg").click(function() {
		$(this).siblings('a').text("");
	}); */

	// 팀원 로그인시 결재버튼 막기
	var position = $("#position").val();
	if (position == "Salesman") {
		$("#confirmDailyReport").attr("disabled", "true");
	}

	// 팀장 로그인시 일일보고수정버튼 막기
	if (position == "Manager") {
		$("#insertConsulting").attr("disabled", "true");
		$("#updateDailyReport").attr("disabled", "true");
	}
});