<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<%-- <link rel="stylesheet" type="text/css" href="${contextPath}/assets/css/form-normalize.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/assets/css/form-style.css" /> --%>
<link rel="stylesheet" type="text/css" media="screen" href="${contextPath}/assets/css/admin-common.css"/>
<h1 class="taCenter page-title">${client.clientName} 정보</h1>
<hr width="700">
<div class="viewForm">
	<div class="fLeft">
		<label class="form-label">고객코드</label>
		<input type="text" class="input" value="${client.clientCode}" readonly="readonly">
	</div>
	<div class="fLeft">
		<label class="form-label">고객명</label>
		<input type="text" class="input" value="${client.clientName}" readonly="readonly">
		<label class="form-label">2차거래선</label>
		<input type="text" class="input" value="${client.secondName}" readonly="readonly">
	</div>
	<div class="fLeft">
		<label class="form-label">대표자</label>
		<input type="text" class="input" value="${client.ceo}" readonly="readonly">
	</div>

	<div class="fLeft">
		<label class="form-label">연락처</label>
		<input type="text" class="input" id="phone1" size="10" value="${client.phone1 }" readonly="readonly"/>
		<input type="text" class="input" id="phone2" size="10" value="${client.phone2 }" readonly="readonly"/>
		<input type="text" class="input" id="phone3" size="10" value="${client.phone3 }" readonly="readonly"/>
	</div>
	<div class="fLeft">
		<label class="form-label">주소</label>
		<input type="text" class="input" value="${client.address}" size="64" readonly="readonly">
	</div>
</div>
<div class="taCenter">
	<a href="${contextPath }/admin/client/clientList?currentPage=${pageSet.currentPage}${pageSet.paramString}" class="btn">돌아가기</a>
	<a href="${contextPath }/admin/client/clientUpdate?clientId=${client.clientId}" class="btn">수정</a>
	<a href="#!" class="btn" id="removeBtn" data-id="${client.clientId}">삭제</a>
</div>
<script type="text/javascript" src="${contextPath }/assets/js/admin/adminClient.js"></script>
<script type="text/javascript">
$(function() {
  AdminClientModule.removeClient();
});
</script>