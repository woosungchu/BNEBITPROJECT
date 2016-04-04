<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.css"/>
<link rel="stylesheet" type="text/css" media="screen" href="${contextPath}/assets/css/ui.jqgrid.css"/>
<link rel="stylesheet" type="text/css" media="screen" href="${contextPath}/assets/css/admin-common.css"/>

<span style="font-family: 'Poiret One',cursive;font-size: 50px;color: yellow; padding-bottom: 25px;">Client List</span>
<table id="grid"></table>
<div  id="pager"></div>
<p class="fLeft">
	<a href="${contextPath }/admin/client/clientAddForm" class="btn">거래처 등록</a>
	<a href="#!" id="resetSelect" class="btn">선택 초기화</a>
	<a href="#!" id="removeSelectedList" class="btn">선택 목록 삭제</a>
</p>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js" type="text/javascript"></script>
<script src="${contextPath}/assets/js/grid.locale-kr.js" type="text/javascript"></script>
<script src="${contextPath}/assets/js/jquery.jqgrid.src.js" type="text/javascript"></script>
<script src="${contextPath}/assets/js/admin/jqGridCommons.js" type="text/javascript"></script>
<script src="${contextPath}/assets/js/admin/adminClient.js" type="text/javascript"></script>
<script type="text/javascript">
$(function () {
  AdminClientModule.grid('${jsonPage}');
});
</script>