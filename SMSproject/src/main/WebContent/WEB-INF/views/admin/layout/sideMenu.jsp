<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<link href="//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
		<link href="${contextPath}/resources/Sticky-Sidebar-Navigation-Menu-with-jQuery-Vertical-Navigation/css/app.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<div id="contentWrapper">
		  <div id="contentLeft">
		    <ul id="leftNavigation">
		      <li class="active"> <a href="#"><i class="fa fa-coffee leftNavIcon"></i> 보고</a>
		        <ul>
		          <li> <a href="#"><i class="fa fa-angle-right leftNavIcon"></i> 주간계획 목록</a> </li>
		          <li class="active"> <a href="/tiles/dailyReportList"><i class="fa fa-angle-right leftNavIcon"></i> 일일업무 보고 목록</a> </li>
		          <li> <a href="#"><i class="fa fa-angle-right leftNavIcon"></i> 상담일지 목록</a> </li>
		          <li> <a href="/tiles/test"><i class="fa fa-angle-right leftNavIcon"></i> 테스트</a> </li>
		        </ul>
		      </li>
		      <li> <a href="#"><i class="fa fa-flask leftNavIcon"></i> 사용자</a>
		        <ul>
		          <li> <a href="#"><i class="fa fa-angle-right leftNavIcon"></i> 사용자 목록</a> </li>
		        </ul>
		      </li>
		      <li> <a href="#"><i class="fa fa-truck leftNavIcon"></i> 거래처</a>
		        <ul>
		          <li> <a href="#"><i class="fa fa-angle-right leftNavIcon"></i> 거래처 목록</a> </li>
		        </ul>
		      </li>
		      <li> <a href="#"><i class="fa fa-envelope-o leftNavIcon"></i> 메시지</a>
		        <ul>
		          <li> <a href="#"><i class="fa fa-angle-right leftNavIcon"></i> 받은 메시지함</a> </li>
		        </ul>
		      </li>
		    </ul>
		  </div>
		  <div id="contentRight">
		    <h1 id="heading">jQuery Vertical Navigation Demo</h1>
		    <div class="jquery-script-ads">
		    	<script type="text/javascript"><!--
				google_ad_client = "ca-pub-2783044520727903";
				/* jQuery_demo */
				google_ad_slot = "2780937993";
				google_ad_width = 728;
				google_ad_height = 90;
				//-->
				</script>
				<script src="http://pagead2.googlesyndication.com/pagead/show_ads.js" type="text/javascript">
				</script>
			</div>
		  </div>
		</div>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="${contextPath}/resources/Sticky-Sidebar-Navigation-Menu-with-jQuery-Vertical-Navigation/js/jquery.ssd-vertical-navigation.min.js"></script>
		<script src="${contextPath}/resources/Sticky-Sidebar-Navigation-Menu-with-jQuery-Vertical-Navigation/js/app.js"></script>
		<script type="text/javascript">
			  var _gaq = _gaq || [];
			  _gaq.push(['_setAccount', 'UA-36251023-1']);
			  _gaq.push(['_setDomainName', 'jqueryscript.net']);
			  _gaq.push(['_trackPageview']);

			  (function() {
			    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
			    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
			  })();
		</script>
	</body>
</html>