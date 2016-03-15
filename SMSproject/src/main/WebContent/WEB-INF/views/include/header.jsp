<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row">
	<div class="container-fluid header">
	<!-- logo -->
	<div id="logo_box" class="col-md-2 col-sm-2 col-xs-3">
		<a class="logo" href="/">
			<img src="/assets/image/logo.png">
        </a>
	 </div>
     <!-- Search -->
	  <div class="col-md-8 col-sm-7 hidden-xs search-form">
		<div class="form-group">
            <input type="text" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
	  </div>
	  	<!-- user -->
      <div id="user">
		<!-- envel -->
		<div class="dropdown">
			<a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                                    <i class="fa fa-envelope-o"></i>
                                    <span class="badge bg-green">6</span>
                                </a>
                                <ul id="menu1" class="dropdown-menu list-unstyled msg_list pull-right" role="menu">
                                    <li>
                                        <a>
                                            <span class="image">
                                        		<img src="/assets/image/profile.JPG" alt="">
                                    		</span>
                                            <span>
                                        <span>John Smith</span>
                                            <span class="time">3 mins ago</span>
                                            </span>
                                            <span class="message">
                                        Film festivals used to be do-or-die moments for movie makers. They were where...
                                    </span>
                                        </a>
                                    </li>
                                    <li>
                                        <a>
                                            <span class="image">
                                        <img src="/assets/image/profile.JPG" alt="">
                                    </span>
                                            <span>
                                        <span>John Smith</span>
                                            <span class="time">3 mins ago</span>
                                            </span>
                                            <span class="message">
                                        Film festivals used to be do-or-die moments for movie makers. They were where...
                                    </span>
                                        </a>
                                    </li>
                                    <li>
                                        <a>
                                            <span class="image">
                                        <img src="/assets/image/profile.JPG" alt="">
                                    </span>
                                            <span>
                                        <span>John Smith</span>
                                            <span class="time">3 mins ago</span>
                                            </span>
                                            <span class="message">
                                        Film festivals used to be do-or-die moments for movie makers. They were where...
                                    </span>
                                        </a>
                                    </li>
                                    <li>
                                        <a>
                                            <span class="image">
                                        <img src="/assets/image/profile.JPG" alt="">
                                    </span>
                                            <span>
                                        <span>John Smith</span>
                                            <span class="time">3 mins ago</span>
                                            </span>
                                            <span class="message">
                                        Film festivals used to be do-or-die moments for movie makers. They were where...
                                    </span>
                                        </a>
                                    </li>
                                    <li>
                                        <div class="text-center">
                                            <a href="#">
                                                <strong>See All Alerts</strong>
                                                <i class="fa fa-angle-right"></i>
                                            </a>
                                        </div>
                                    </li>
                                </ul>
		</div>
		<!-- profile -->
      	<div class="dropdown">
	      <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
	        <img src="/assets/image/profile.JPG" alt="">  Hamster
			<span class="fa fa-angle-down"></span>
			</a>
			<ul class="dropdown-menu pull-right">
				<li><a href="#" class="preventDefault" data-toggle="modal" data-target="#userInfoModal"><i class="fa fa-child pull-right"></i>내 정보</a></li>
				<li><a href="#" onclick="location.href='/logout'" class="preventDefault"><i class="fa fa-sign-out pull-right"></i>로그아웃</a>
				</li>
			</ul>
		</div>
      </div>
</div>
</div>

<!-- userInfoModal -->
  <div class="modal fade" id="userInfoModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h3 class="modal-title">내 정보</h3>
        </div>
        <div class="modal-body">
        	<div id="userInfoBox" class="row">
					<div class="media">
						<div class="media-left">
							<img id="profileImg" src="/assets/image/noname.png" />
						</div>
						<div class="media-body">
							<h4>
								${LOGIN_USER.empName}
								<small>${LOGIN_USER.dept.deptName}
									<c:set var="position" value="${LOGIN_USER.position}"></c:set>
									<c:choose>
										<c:when test="${position eq 'Salesman'}">팀원</c:when>
										<c:when test="${position eq 'Manager'}">팀장</c:when>
									</c:choose>
								</small>
							</h4>
							<h5>연락처 : ${LOGIN_USER.phone}</h5>
							<h5>이메일 : ${LOGIN_USER.email}</h5>
							<div class="btn-group pull-right" role="group">
								<button id="btnChangePic" type="button" class="btn btn-default">사진 변경</button>
								<button id="btnChangePwdModal" type="button" class="btn btn-default">비밀번호 변경</button>
							</div>
						</div>
					</div>
				</div><!-- First Row End -->
        </div><!-- modal body end -->
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
  
  <!-- changPwdModal -->
  <div class="modal fade" id="changePwdModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
	    <form id="modifyPwdForm" action="/modifyPwd" method="post" >
	        <div class="modal-header">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h3 class="modal-title">비밀번호 변경</h3>
	        </div>
	        <div class="modal-body">
	<!--         	<p class="pull-right">귀하의 이메일로 인증번호를 전송하였습니다</p> -->
		          <input type="hidden" id="RSAModulus" value="${RSAModulus}" />
				  <input type="hidden" id="RSAExponent" value="${RSAExponent}" />
		          <div class="form-group">
		            <label for="currentPwd" class="control-label">현재 비밀번호</label>
		            <input type="password" class="form-control" id="currentPwd">
		            <input type="hidden" id="securedCurrentPwd" name="currentPwd" value=""/>
		          </div>
		          <div class="form-group">
		            <label for="firstPwd" class="control-label">비밀번호 변경</label>
		            <input type="password" class="form-control" id="firstPwd">
		          </div>
		          <div class="form-group">
		            <label for="secondPwd" class="control-label">비밀번호 확인</label>
		            <input type="password" class="form-control" id="secondPwd">
		            <input type="hidden" id="securedNewPwd" name="newPassword" value=""/>
		          </div>
	        </div><!-- modal body end -->
	        <div class="modal-footer">
	          <button type="submit" class="btn btn-primary">변경</button>
	          <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	        </div>
	     </form>
      </div>
    </div>
  </div>