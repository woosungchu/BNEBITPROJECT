<%@ page contentType = "text/html;charset=utf-8" %>
<%@page language="java" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

		<title>adminWeeklyPlanList</title>
		<link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.css"/>
		<link rel="stylesheet" type="text/css" media="screen" href="${contextPath}/assets/css/ui.jqgrid.css"/>
		<link rel="stylesheet" type="text/css" media="screen" href="${contextPath}/assets/css/admin-common.css"/>

		<span style="font-family: 'Poiret One',cursive;font-size: 50px;color: yellow; padding-bottom: 25px;">Dept List</span>
		<table id="grid"></table>
		<div  id="pager"></div>
		<p align="left">
			<button id="resetSelect" class="basicButton">선택 초기화</button>
			<button id="removeSelectedList" class="basicButton">선택 목록 삭제</button>
		</p>

		<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js" type="text/javascript"></script>
		<script src="${contextPath}/assets/js/grid.locale-kr.js" type="text/javascript"></script>
		<script src="${contextPath}/assets/js/jquery.jqgrid.src.js" type="text/javascript"></script>
		<script type="text/javascript">
			var $Grid = {};
			var historyPageObject = !'${historyPage}' ? null : JSON.parse('${historyPage}');
			$(document).ready(function(){

	     		$Grid = $('#grid');

				$Grid.jqGrid({
	          		url : '${contextPath}/admin/dept/getDeptListJsonData',
	          		datatype : "json",
	          		jsonReader : {
	               		id : "deptId", // 대표 아이디를 설정
	               		root : "dataList", // 받은 제이슨 데이터의 시작을 설정
	               		page : "page",
	               		total : "total",
	               		records : "records"
	          		},
	          		colNames : [
	                          		'아이디',
	                          		'부서이름'
	                     		],
	          		colModel : [
	                    		{ name : 'deptId',    hidden:true},
	                    		{ name : 'deptName',  width:200,  align:'center', index:'dept_name', editable:true, searchoptions:{sopt:['eq','ne','in','ni']}}
	            	],
	            	caption: '부서 목록',
	            	rowNum : historyPageObject == null ? 30 : historyPageObject.rows,
	          		rowList: [2, 3, 5, 10, 15, 20, 25, 30],
	          		mtype : "post",
	          		pager : '#pager',
	          		width : '1600',
	          		height : 'auto',
	          		emptyrecords : '데이터가 존재하지 않습니다.',
	          		showpage : true,
	          		viewrecords: true,
	          		////// 멀티 select (체크박스 ) /////
	          		multiselect : true,
	          		multiboxonly : true, // 체크 박스를 클릭해야 다중 선택 가능
	          		/////////////////////////////
	          		loadonce : false,
					///// 멀티 sort 설정 //////
	          		multiSort : true,
	          	    sortname : historyPageObject == null ? '' : historyPageObject.sidx, /* 처음 정렬될 컬럼 */
	          		sortorder : historyPageObject == null ? 'asc' : historyPageObject.sord,  /* 정렬방법 (asc/desc) */
	          		search : true,
	          		//postData: { filters:'{"groupOp":"AND","rules":[{"field":"e.memberName","op":"eq","data":"엘사"}]}' },
	          		//search : historyPageObject == null ? false : historyPageObject.search,
					//////////////////////
					loadError: function (jqXHR, textStatus, errorThrown) {
						if (jqXHR.status == '406') {
					        alert(jqXHR.responseText);
					        location.href = contextPath + '/';
						}
				    },
					beforeSelectRow: function (rowid, e) {
	                     return $(e.target).is('input[type=checkbox]');	// 선택한 row의 셀이 checkbox 셀이어야 true 를 반환. (다른 셀공간을 클릭하여도 체크박스 체크가 되지 않도록 함)
	                },
	          		beforeProcessing : function(data){
	          			// $('.cbox').trigger('click').attr('checked', true); 미리 all checkBox 체크 .
	          			$('#resetSelect').click(function(){
	          				var cookies = $.cookie();
	    					for(var cookie in cookies)
	    					{
	    						$.removeCookie(cookie);
	    					}
							$Grid.trigger("reloadGrid");
	             		});
	                	$('#removeSelectedList').click(function(){
	                		var idList = new Array();	// 선택 되어진 id 들을 저장할 배열.
							var cookies = $.cookie();
							for(var cookie in cookies)
							{
								idList.push(cookie);
								$.removeCookie(cookie);
							}
							idList.pop(); // 마지막 쿠키는 JESSIONID 값으로 불필요 함. JSESSIONID : 고유한 쿠키의 ID 값.
	                		$.ajax({
								url:'${contextPath}/admin/dept/deleteDeptList',
								data:{
									'ids':idList
								},
								type:'post',
								success: function() {
									window.location.reload();	// 페이지 새로 고침
								}
	                		});
	                	});
	                },
	          		onCellSelect: function(rowid, iCol,cellcontent, e){
	          	         if($(e.target).is('input[type=checkbox]'))
	          	         {
		          	         var checkId = $.cookie(rowid);
			         		 if(checkId!=null)			// 현재 석택한 rowid 가 쿠키에 존재 하고 있는 것이라면...
		         			 {
		         				$.removeCookie(rowid); // 선택 해제시 쿠키에서 삭제.
		         			 }
		         			 else						// 현재 선택한 rowid 가 쿠키에 없으면 저장.
		         			 {
		         				$.cookie(rowid,rowid);
		         			 }
	          	         }
	          		},
	          		afterInsertRow : function(rowid, rowdata, rowelem){
	      				var checkId = $.cookie(rowid);
	      				if(checkId!=null)					// 한줄 한줄 삽입 될 때마다 현재 rowid 가 쿠키에 존재하는지 확인
	      				{
	      					$Grid.setSelection(rowid, true); // 쿠키에 존재 하는 rowid 라면 해당 체크박스 true.
	      				}
	                },
	          		onSelectAll : function(aRowids,status){		// 모두 선택 시...
	          			if(status)								// 처음 모두 선택 시에는 체크 박스 모두 체크 (true)
	          			{
	          				for(var i=0; i<aRowids.length; i++)	// 모든 row 쿠키에 저장.
	          				{
	          					$.cookie(aRowids[i],aRowids[i]);
	          				}
	          			}
	          			else									// 모든 row 쿠키에서 제거.
	          			{
	          				for(var i=0; i<aRowids.length; i++)
	          				{
	          					$.removeCookie(aRowids[i]);
	          				}
	          			}
	          		}
				}).navGrid('#pager', { view: false, del: false, add: true, edit: true },
						   {}, // default settings for edit
						   {
							   afterSubmit : function (resp, postdata)
							   {
								   $.ajax({
										url:'${contextPath}/admin/dept/addDept',
										data:{
											'deptName':postdata.deptName
										},
										type:'post',
										success: function() {
											window.location.reload();	// 페이지 새로 고침
										}
			                		});
								   return [true,"",""];
							   },
							   closeAfterEdit: true,
						       reloadAfterSubmit:true
						   }, // default settings for add
						   {}, // delete
						   {
							   closeOnEscape: true,
						       closeAfterSearch: true,
						   }, // search options
						   {});
	    		//}).jqGrid('navGrid','#pager',{edit:false,add:false,del:false,search:true});

		});
		</script>

