<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>메시지 전송</title>
		<link href='https://fonts.googleapis.com/css?family=Poiret+One' rel='stylesheet' type='text/css'>
		<link rel="stylesheet" type="text/css" media="screen" href="${contextPath}/assets/css/admin-common.css"/>
		<script src="${contextPath}/assets/js/jquery-2.2.0.js" type="text/javascript"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.min.js"></script>
		<script src="${contextPath}/assets/js/admin/map.js" type="text/javascript"></script>
		<script src="${contextPath}/assets/js/jquery.cookie.js"></script>
		<script type="text/javascript">
		var contextPath = '${contextPath}';
		</script>
	</head>
	<body id="body">
		<tiles:insertAttribute name="body"/>
	</body>
</html>