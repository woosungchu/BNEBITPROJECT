<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="row">
	<div class="container-fluid header">
	<!-- logo -->
	<div id="logo_box" class="col-md-2 col-sm-2 col-xs-3">
		<a class="logo" href="#">
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
				<li><a href="#" class="preventDefault" data-toggle="modal" data-target="#myModal">내 정보</a></li>
				<li><a href="#" class="preventDefault"><i class="fa fa-sign-out pull-right"></i>사진 변경</a>
				<li><a href="#" class="preventDefault"><i class="fa fa-sign-out pull-right"></i>비밀번호 변경</a>
				<li><a href="#" onclick="location.href='/logout'" class="preventDefault"><i class="fa fa-sign-out pull-right"></i>로그아웃</a>
				</li>
			</ul>
		</div>
      </div>
</div>
</div>

<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
          <p>Some text in the modal.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>

    </div>
  </div>
