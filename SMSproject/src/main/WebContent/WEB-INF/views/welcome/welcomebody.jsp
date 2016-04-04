<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid">
	<div class="row-fluid">
		<div class="col-lg-4 col-md-3 col-sm-2 hidden-xs login-side"></div>
		<div id="contentBox" class="col-lg-4 col-md-6 col-sm-8 col-xs-12" hidden="true">
			<div class="row">
				<div id="loginBox" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="row"><!-- 상단 row -->
						<div id="helpBtn" class="c-pointer">
							<i class="fa fa-question-circle" 
								data-container="body" data-toggle="modal" data-target="#helpModal">
							</i>
						</div>
						<div id="loginImgBox">
							<c:choose>
							   	<c:when test="${not empty RECENT_USER.imgName}">
									<img id="loginImg" src="/Upload/${RECENT_USER.imgName}" alt="NOIMAGE" class="img-circle hidden-xs">
							   	</c:when>
							   	<c:otherwise>
								    <img src="/assets/image/noname.png" alt="NOIMAGE" class="img-circle hidden-xs">
							  	</c:otherwise>
							</c:choose>
						</div>
						<c:if test="${not empty MESSAGE}">
							<div id="guidMsg">
									<p>${MESSAGE}</p>
							</div>
						</c:if>
<%-- 						<p>${RECENT_USER}</p> --%>
					</div>
					<div class="row"><!-- 하단 row -->
						<!-- Real Form -->
						<form id="hiddenForm" action="/login" method="post" >
							<input type="hidden" id="RSAModulus" value="${RSAModulus}" />
							<input type="hidden" id="RSAExponent" value="${RSAExponent}" />
							<div class="form-group">
							    <c:choose>
							    	<c:when test="${not empty RECENT_USER}">
							    		<input readonly type="text" id="user_id" class="form-control"
							    			placeholder="Email" value="${RECENT_USER.email}">
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
							<input type="submit" class="btn btn-primary loading" value="로그인">
						</form>
					</div><!-- form div end -->
				</div><!-- login box end -->
			</div>
		</div>
		<div class="col-lg-4 col-md-3 col-sm-2 hidden-xs"></div>
	</div>
</div>

<!-- help Modal -->
<div class="modal fade" id="helpModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">이메일 혹은 비밀번호를 잊으셨나요?</h4>
      </div>
      <div class="modal-body">
        <p class="pull-right">이메일을 잊으셨다면 신헌지씨에게 문의하세요.</p>
        <form>
          <div class="form-group">
            <label for="validName" class="control-label">성명</label>
            <input type="text" class="form-control" id="inputName" placeholder="ex) 엘사">
          </div>
          <div class="form-group">
            <label for="validEmail" class="control-label">임시번호를 받을 이메일을 입력하세요</label>
            <input type="text" class="form-control" id="inputEmail" placeholder="ex) elsa@gmail.com">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button id="btnValid" data-loading-text="좀만 기달.." onclick="validation()" autocomplete="off"  
        	type="button" class="btn btn-primary" > 인증번호 받기 </button>
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<!-- validation modal -->
<div class="modal fade" id="validationModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">인증번호를 입력하세요</h4>
      </div>
      <div class="modal-body">
      	<p class="pull-right">귀하의 이메일로 인증번호를 전송하였습니다</p>
      	<p class="pull-right">인증번호가 도착하지 않는다면  <b style="color : red;">스팸 메일</b>을 확인해보세요</p>
        <form>
          <div class="form-group">
            <label for="validCode" class="control-label">인증번호</label>
            <input type="text" class="form-control" id="validCode">
          </div>
          <p class="pull-right">비밀번호는 최대한 까먹지 않게 쉽게 만드십시요 :D</p>
          <div class="form-group">
            <label for="firstPwd" class="control-label">비밀번호 변경</label>
            <input type="password" class="form-control" id="firstPwd">
          </div>
          <div class="form-group">
            <label for="secondPwd" class="control-label">비밀번호 확인</label>
            <input type="password" class="form-control" id="secondPwd">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button onclick="gotoForm()" type="button" class="btn btn-primary loading">확인</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
