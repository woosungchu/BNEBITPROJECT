<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType = "text/html;charset=utf-8" %>
<%@page language="java" session="true" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

		<title>adminConsultingList</title>
		<link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.css"/>
		<link rel="stylesheet" type="text/css" media="screen" href="${contextPath}/assets/css/ui.jqgrid.css"/>

		<span style="font-family: 'Poiret One',cursive;font-size: 50px;color: yellow;">Consulting List</span>
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
	          		url : '${contextPath}/admin/report/getConsultingListJsonData',
	          		datatype : "json",
	          		jsonReader : {
	               		id : "consultingId", // 대표 아이디를 설정
	               		root : "dataList", // 받은 제이슨 데이터의 시작을 설정
	               		page : "page",
	               		total : "total",
	               		records : "records"
	          		},
	          		colNames : [
	                          		'아이디',
	                          		'제목',
	                          		'팀원',
	                          		'담당 팀장',
	                          		'소속 부서',
	                          		'고객명',
	                          		'등록일'
	                     		],
	          		colModel : [
	                    		{ name : 'consultingId',    hidden:true},
	                    		{ name : 'title',       width:400,  align:'center', index:'c.title', searchoptions:{sopt:['eq','ne','in','ni']}, formatter:custom_link },
	                    		{ name : 'memberName', 	  width:150,  align:'center', index:'e.member_name', searchoptions:{sopt:['eq','ne','in','ni']}},
	                    		{ name : 'managerName', width:150,  align:'center', index:'e.manager_name', searchoptions:{sopt:['eq','ne','in','ni']}},
	                    		{ name : 'deptName',  	      width:200,  align:'center', index:'e.dept_name', searchoptions:{sopt:['eq','ne','in','ni']}},
	                    		{ name : 'clientName',  	  	  width:200,  align:'center', index:'d.client_name', searchoptions:{sopt:['eq','ne','in','ni']}},
	                    		{ name : 'regDate',  	  	  width:300,  align:'center', index:'c.reg_date', searchoptions:{sopt:['eq','ne','in','ni','ge','le','gt','lt']}}
	            	],
	            	search : true,
	            	postData : {
	            		searchField : historyPageObject == null ? '' : historyPageObject.searchField,
	            		searchString : historyPageObject == null ? '' : historyPageObject.searchString,
	            	    searchOper : historyPageObject == null ? '' : historyPageObject.searchOper
	            	},
	            	caption: '상담일지 목록',
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
								url:'${contextPath}/admin/report/deleteConsultingList',
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
				}).navGrid('#pager', { view: false, del: false, add: false, edit: false },
						   {}, // default settings for edit
						   {}, // default settings for add
						   {}, // delete
						   {closeOnEscape: true,
						    closeAfterSearch: true }, // search options
						   {}
						 );
	    		//}).jqGrid('navGrid','#pager',{edit:false,add:false,del:false,search:true});

	 			function custom_link(cellValue, options, rowdata, action)
	 			{
	 				var html = '<a style="color: blue;" href=${contextPath}/admin/report/viewConsulting';
	 				html += '?consultingId=' + rowdata.consultingId;
	 				html += '&empName=' + encodeURIComponent(rowdata.memberName);    // 익스플로러의 경우 URI 에 get 방식으로 데이터를 넘길때 자동적으로 encoding이 되지 않기 때문에 인코딩을 해줌.
	 				html += '&dept.deptName=' + encodeURIComponent(rowdata.deptName);
	 				html += '>'+rowdata.title+'</a>';
	 				return html;
	 			}

		});
		</script>

