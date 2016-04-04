<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<div id="message-box" class="fLeft">
	<textarea id="content" class="message-content" placeholder="메시지를 입력해주세요"></textarea>
	<div class="fLeft">
		<a href="#!" id="sendMessageBtn" class="btn">전송</a>
		<a href="#!" id="closeBtn" class="btn">취소</a>
	</div>
</div>
<div id="select-box" class="fRight">
	<ul id="selectEmployee" class="employee-select fRight"></ul>
	<div class="fRight">
		<a href="#!" id="listRemoveBtn" class="btn">삭제</a>
	</div>
</div>

<script type="text/javascript"  src="${contextPath }/assets/js/socket/sockjs-1.0.3.js"></script>
<script type="text/javascript"  src="${contextPath }/assets/js/socket/stomp.js"></script>
<script src="${contextPath}/assets/js/admin/adminMessage.js" type="text/javascript"></script>

<script type="text/javascript">
$(function () {
  AdminMessageModule.messageForm();
});
</script>