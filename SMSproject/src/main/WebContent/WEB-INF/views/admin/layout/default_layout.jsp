<!DOCTYPE html>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<link href='https://fonts.googleapis.com/css?family=Poiret+One' rel='stylesheet' type='text/css'>
		<script src="${contextPath}/assets/js/jquery-2.2.0.js" type="text/javascript"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.min.js"></script>
		<script src="${contextPath}/assets/js/jquery.cookie.js"></script>

		<script type="text/javascript">
		var contextPath = '${contextPath}';
		</script>
		<style type="text/css">
			#logoutBtn {
				background: rgba(0, 0, 255, 0.79);
				color: #fff;
				border: 0;
				padding: 0.5em 1em;
				border-radius : 13px;
			}
			#body {
				background: url('${contextPath}/assets/image/adminBodyBackGround.jpg') no-repeat;
				 background-position: center top;
    			background-size: 100% 100%;
			}
			p#header{
				display: block;
			    -webkit-margin-before: 1em;
			    -webkit-margin-after: 1em;
			    -webkit-margin-start: 0px;
			    -webkit-margin-end: 0px;
			}

			.basicButton {
				padding:6px 12px 6px 12px;
				position:relative;

				background-color:#fcfcfc;
				background:-moz-linear-gradient(left top -90deg, #fff, #ccc);
				background:-webkit-linear-gradient(left top -90deg, #fff, #ccc);
				background:linear-gradient(left top -90deg, #fff, #ccc);

				-moz-box-shadow: 1px 1px 1px #333;
				-webkit-box-shadow: 1px 1px 1px #333;
				box-shadow: 1px 1px 1px #333;

				-moz-border-radius:18px;
				-webkit-border-radius:18px;
				border-radius:18px;

				font-size:11px;
				color:#444;
				text-shadow:1px 1px 0 #fff;
				display:inline-block;
				margin-right:10px;

				-moz-transition:0.25s;
				-webkit-transition:0.25s;
				transition:0.25s;

				text-decoration:none;
			}

			.basicButton:hover{
				text-decoration:none !important;
				box-shadow:0 0 20px #2b99ff;
			}

			#bloggertrix_box_menu{padding:0;margin:0;width:245px;list-style:none outside none}
			#bloggertrix_box_menu li{background:#252525;position:relative;border-bottom:1px solid #110f0e;border-top:1px solid #3d3732;}
			#bloggertrix_box_menu li ul{position:absolute;padding:0;margin:0;left:245px;top:-1px;display:none;width:160px;list-style:none outside none;z-index:9990;background:#00CC33}
			#bloggertrix_box_menu li a{background:url(http://4.bp.blogspot.com/-Z2rx2h9tJd8/UNv6FN_L0II/AAAAAAAAGFQ/ty4e9b5auHQ/s1600/bt-arrow-right-icon.png) no-repeat 5px 10px;display:block;min-height:30px;line-height:30px;margin:0;padding:0 5px 0 25px;text-decoration:none;color:#777;color:#b69786;font-size:14px;border-right:4px solid #35322c;cursor:pointer;transition:all 400ms ease-in-out;-webkit-transition:all 400ms ease-in-out;-moz-transition:all 400ms ease-in-out;-o-transition:all 400ms ease-in-out;-ms-transition:all 400ms ease-in-out}
			#bloggertrix_box_menu li a:hover{border-right-color:#665d54;text-decoration:none;color:#ddd;background:#38332d url(http://4.bp.blogspot.com/-Z2rx2h9tJd8/UNv6FN_L0II/AAAAAAAAGFQ/ty4e9b5auHQ/s1600/bt-arrow-right-icon.png) no-repeat 5px 10px;}
			#bloggertrix_box_menu li:hover ul, #bloggertrix_box_menu li.over ul{display:block}

		</style>
	</head>
	<body id="body" style="margin: 8px;">
		<tiles:insertAttribute name="header"/>
		<table>
			<tr>
				<td id="menuSideBar" height="800px" width="240px" valign="top" style="padding-top: 30px;"><tiles:insertAttribute name="menu"/></td>
				<td height="855px" width="1600px" align="center" valign="top" style="padding-left: 15px; padding-right: 15px;"><tiles:insertAttribute name="body"/></td>
			</tr>
		</table>
	</body>
</html>