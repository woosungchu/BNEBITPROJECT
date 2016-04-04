<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<div class="modal fade" id="messageModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">메시지 작성</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="receiver.empName" class="control-label">수신인:</label>
					<ul class="form-control" id="receiverTag" style="height: 30%"></ul>
				</div>
				<div class="form-group">
					<label for="messageContent" class="control-label">내용:</label>
					<textarea class="form-control" id="messageContent" ></textarea>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="sendMessageBtn">전송</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="${contextPath }/assets/js/socket/message.js"></script>
<script type="text/javascript">
  $(function() {
    MessageModule.init('${LOGIN_USER.email }');
  });
</script>
