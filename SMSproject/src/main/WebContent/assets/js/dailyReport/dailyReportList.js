$(document).ready(function() {
	//휴일, 회사 기념일에 일일보고작성 버튼 비활성화
	var eventHoliday = $("#eventHoliday").val();
	if (eventHoliday == 1 || eventHoliday == 2) {
		$("#insertDailyReport").attr("disabled", "true");
	}

	//일일보고 1개만 입력
	var isTodayDailyReport = $("#isTodayDailyReport").val();
	console.log("isTodayDailyReport : " + isTodayDailyReport);
	if(isTodayDailyReport == "true") {
		$("#insertDailyReport").attr("disabled", "true");
	}

	//결재여부 표시
	$('.feedback').each(function() {
		var feedback = $(this).data('feedback');
		if (feedback) {
			$(this).addClass("glyphicon glyphicon-ok");
		}
	});

	//팀장은 일일보고입력 불가
	var position = $("#empId").val();
	if(position == "") {
		$("#insertDailyReport").attr("disabled", "true");
	}

	//블록이동 비활성화 처리
	function blockDisabled() {
		var isFirstBlock = $("#isFirstBlock").val();
		var isLastBlock = $("#isLastBlock").val();
		if (isFirstBlock == "true") {
			console.log("isFirstBlock : " + isFirstBlock);
			$("#moveBlockLeft").remove();
		}
		if (isLastBlock == "true") {
			console.log("isLastBlock : " + isLastBlock);
			$("#moveBlockRight").remove();

			var blockSize = $("#blockSize").val();
			for (var i = 0; i < blockSize; i++) {
				var index = parseInt(currentPage) + i;
				if (index > parseInt(totalPageCount)) {
					$("#pageIndex" + index).remove();
				}
			}
		}
	}

	//페이지 활성화 처리
	var currentBlock = $("#currentBlock").val();
	var currentPage = $("#currentPage").val();
	var totalPageCount = $("#totalPageCount").val();
	var totalBlockCount = $("#totalBlockCount").val();
	console.log("currentPage : " + currentPage);
	console.log("currentBlock : " + currentBlock);
	console.log("totalPageCount : " + totalPageCount);
	console.log("totalBlockCount : " + totalBlockCount);
	//$(".pageIndex").removeClass("active");

	blockDisabled();

	$("#pageIndex" + currentPage).addClass("active");

	$("#moveBlockLeft").click(function() {
		$("#pageIndex" + currentPage).addClass("active");
	});

	$("#moveBlockRight").click(function() {
		$("#pageIndex" + currentPage).addClass("active");
	});

	//정렬 후 요청 값들 반영
	var searchKey = $("#searchKey").val();
	$("#searchKey").val(searchKey);

	var sortKey = $("#sortKey").val();
	var sortBy = $("#sortBy").val();
	if (sortBy == "asc") {
		$("#" + sortKey).text("▲");
	} else if (sortBy == "desc") {
		$("#" + sortKey).text("▼");
	}

	//sortKey를 클릭했을때 정렬
	$(".sortKey").click(function() {
		var dataSortKey = $(this).data("sort-key");
		var $sortLabel = $("#" + dataSortKey);
		var $text = $sortLabel.text();
		$(".sortBy").text("");

		if ($text == "") {
			$sortLabel.text("▲");
			$("#sortBy").val("asc");
		} else if ($text == "▲") {
			$sortLabel.text("▼");
			$("#sortBy").val("desc");
		} else if ($text == "▼") {
			$sortLabel.text("");
			$("#sortBy").val("");
			dataSortKey = "";
		}
		$("#sortKey").val(dataSortKey);
		$("#dailyReportForm").submit();
	});
});