<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<p align="left" id="header">
	<img src="${contextPath}/assets/image/logo.png">
	<a href="/logout"><button style="float: right; font-size: 15px;" id="logoutBtn">로그아웃</button></a>
</p>
