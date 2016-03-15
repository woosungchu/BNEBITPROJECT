<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid fill">
	<div class="row-fluid">
		<div class="col-lg-4 col-md-3 col-sm-2 hidden-xs login-side"></div>
		<div id="content-box" class="col-lg-4 col-md-6 col-sm-8 col-xs-12">
			<div class="row">
				<img id="logo" class="col-md-4 col-sm-4 hidden-xs" alt="로고" src="/assets/image/logo.png">
			</div>
			<div class="row">
				<div id="loginBox" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div id="helpBtn">
						<i class="fa fa-question-circle" 
							data-container="body" data-toggle="popover" data-placement="top" data-trigger="hover"
							data-content="사내 메일을 잊으셨다면 짐싸고 집으로 돌아가세요">
						</i>
					</div>
					<c:choose>
					   	<c:when test="${not empty RECENT_USER.imgName}">
<%-- 							<img src="${RECENT_USER.imgName}" alt="NOIMAGE" class="img-circle hidden-xs"> --%>
								<img src="/assets/image/noname.png" alt="NOIMAGE" class="img-circle hidden-xs">
					   	</c:when>
					   	<c:otherwise>
						    <img src="/assets/image/noname.png" alt="NOIMAGE" class="img-circle hidden-xs">
					  	</c:otherwise>
					</c:choose>
					<c:if test="${not empty MESSAGE}">
						<div id="guidMsg">
								<p>${MESSAGE}</p>
						</div>
					</c:if>
					<p>${RECENT_USER}</p>
				<!-- Real Form -->
				<form id="hiddenForm" action="/login" method="post" >
					<input type="hidden" id="RSAModulus" value="${RSAModulus}" />
					<input type="hidden" id="RSAExponent" value="${RSAExponent}" />
					<div class="form-group">
					    <c:choose>
					    	<c:when test="${not empty RECENT_USER}">
					    		<input readonly type="text" id="user_id" class="form-control" value="${RECENT_USER.email}">
					    	</c:when>
					    	<c:otherwise>
							    <input type="text" id="user_id" class="form-control" placeholder="BNEBIT@gmail.com">
					    	</c:otherwise>
					    </c:choose>
						<input type="hidden" id="securedId" name="email" value=""/>
					</div>
					<div class="form-group">
					    <input type="password" id="user_pwd" class="form-control" placeholder="Password">
						<input type="hidden" id="securedPwd" name="password" value=""/>
					</div>
						<input type="submit" class="btn btn-primary" value="로그인">
				</form>
				
					<div class="row">
						<button id="leftBtn" type="button" class="btn btn-default btn-sm">기존 로그인</button>
						<button id="rightBtn" type="button" class="btn btn-default btn-sm">비밀번호 찾기</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-4 col-md-3 col-sm-2 hidden-xs"></div>
	</div>
</div>