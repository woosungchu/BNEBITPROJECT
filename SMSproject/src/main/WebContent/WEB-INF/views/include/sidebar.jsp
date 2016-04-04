<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link href="/assets/css/simple-sidebar.css" rel="stylesheet">

<div id="sidebar-wrapper">
            <ul class="sidebar-nav nav-pills nav-stacked" id="menu">
                <li>
                    <a href="${contextPath }/"><span class="fa-stack fa-lg pull-left"><i class="fa fa-home fa-stack-1x "></i></span> Home</a>
                </li>
                <li>
                    <a href="#"><span class="fa-stack fa-lg pull-left"><i class="fa fa-edit fa-stack-1x "></i></span>보고</a>
                    <ul class="nav-pills nav-stacked" style="list-style-type: none; display: none;">
                    	<c:choose>
                    		<c:when test="${LOGIN_USER.position eq 'Salesman'}">
		                        <li><a href="${contextPath }/weeklyListEmp?empId=${LOGIN_USER.empId}&rownum=0"><span class="fa-stack fa-lg pull-left"><i class="fa fa-file-o fa-stack-1x "></i></span>주간계획</a></li>
                    		</c:when>
                    		<c:when test="${LOGIN_USER.position eq 'Manager'}">
		                        <li><a href="${contextPath }/weeklyList?deptId=${LOGIN_USER.dept.deptId}&rownum=0"><span class="fa-stack fa-lg pull-left"><i class="fa fa-file-o fa-stack-1x "></i></span>주간계획</a></li>
                    		</c:when>
                    	</c:choose>
                        <li><a href="${contextPath }/dailyReport/selectDailyReportList"><span class="fa-stack fa-lg pull-left"><i class="fa fa-flag fa-stack-1x "></i></span>일일보고</a></li>
                    </ul>
                </li>
                <li>
                    <a href="${contextPath }/client/clientAddForm"><span class="fa-stack fa-lg pull-left"><i class="fa fa-youtube-play fa-stack-1x "></i></span>거래처</a>
                </li>
                <li>
                    <a href="${contextPath }/viewChart"><span class="fa-stack fa-lg pull-left"><i class="fa fa-cloud-download fa-stack-1x "></i></span>통계</a>
                </li>
                <li>
                    <a href="${contextPath }/message/receiveMessageList"> <span class="fa-stack fa-lg pull-left"><i class="fa fa-cart-plus fa-stack-1x "></i></span>메세지함</a>
                </li>
            </ul>
        </div><!-- /#sidebar-wrapper -->