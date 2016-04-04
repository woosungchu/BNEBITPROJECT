<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" media="screen" href="${contextPath}/assets/css/admin-common.css"/>
<h1 class="taCenter page-title">${clientUpdateInfo.clientName} 정보 수정</h1>
<hr width="700">
<div class="inputForm">
	<form id="clientForm" action="${contextPath }/rest/admin/client/updateClient" method="post">
		<div class="fLeft">
			<label class="form-label" for="clientCode">고객코드</label>
			<input type="text" class="input" id="clientCode" name="clientCode" value="${clientUpdateInfo.clientCode }" readonly="readonly">
		</div>
		<div class="fLeft">
			<label class="form-label" for="clientName">고객명</label>
			<input type="text" class="input" id="clientName" name="clientName" value="${clientUpdateInfo.clientName }">
			<label class="form-label" for="secondName">2차거래선</label>
			<input type="text" class="input" id="secondName" name="secondName" value="${clientUpdateInfo.secondName }">
		</div>
		<div class="fLeft">
			<label class="form-label" for="ceo">대표자</label>
			<input type="text" class="input" id="ceo" name="ceo" value="${clientUpdateInfo.ceo }">
		</div>
		<div class="fLeft">
			<label class="form-label" for="phone1">연락처</label>
			<input type="text" class="input" id="phone1" name="phone1" size="10" value="${clientUpdateInfo.phone1 }"/>
			<input type="text" class="input" id="phone2" name="phone2" size="10" value="${clientUpdateInfo.phone2 }"/>
			<input type="text" class="input" id="phone3" name="phone3" size="10" value="${clientUpdateInfo.phone3 }"/>
		</div>
		<div class="fLeft">
			<a href="#!" id="searchAddrBtn" class="form-label">주소검색</a>
			<input type="text" class="input" id="address" name="address" size="64" readonly="readonly" value="${clientUpdateInfo.address }">
		</div>
		<div class="fLeft">
			<div id="searchAddrDiv" class="searchAddr">
				<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" class="closeAddr" alt="접기 버튼">
			</div>
		</div>
	</form>
</div>
<div class="taCenter">
	<a href="#!" id="updateBtn" class="btn">수정</a>
	<a href="${contextPath }/admin/client/clientList" class="btn">취소</a>
</div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="${contextPath }/assets/js/utils.js"></script>
<script src="${contextPath}/assets/js/admin/jqGridCommons.js" type="text/javascript"></script>
<script src="${contextPath}/assets/js/admin/adminClient.js" type="text/javascript"></script>
<script type="text/javascript">
  $(function() {
    SearchAddrModule.initEmbed();
    AdminClientModule.update();
  });
</script>