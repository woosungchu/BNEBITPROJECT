<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<style type="text/css">
			/*----- Accordion -----*/
			.accordion, .accordion * {
			    -webkit-box-sizing:border-box;
			    -moz-box-sizing:border-box;
			    box-sizing:border-box;
			}

			.accordion {
			    overflow:hidden;
			    box-shadow:0px 1px 3px rgba(0,0,0,0.25);
			    border-radius:3px;
			    background:#f7f7f7;
			}

			/*----- Section Titles -----*/
			.accordion-section-title {
			    width:100%;
			    padding:15px;
			    display:inline-block;
			    border-bottom:1px solid #1a1a1a;
			    background:#333;
			    transition:all linear 0.15s;
			    /* Type */
			    font-size:1.200em;
			    text-shadow:0px 1px 0px #1a1a1a;
			    color:#fff;
			}

			.accordion-section-title.active, .accordion-section-title:hover {
			    background:#4c4c4c;
			    /* Type */
			    text-decoration:none;
			}

			.accordion-section:last-child .accordion-section-title {
			    border-bottom:none;
			}

			/*----- Section Content -----*/
			.accordion-section-content {
			    padding:15px;
			    display:none;
			    background-color: gray;
			}
		</style>
	</head>
	<body>
		<div class="accordion">
		    <div class="accordion-section">
		        <a class="accordion-section-title" href="#accordion-1">보고</a>
		        <div id="accordion-1" class="accordion-section-content">
		            <p><a href="#">주간계획</a></p>
		            <p><a href="/tiles/dailyReportList">일일업무 보고</a></p>
		            <p><a href="/tiles/test">테스트</a></p>
		            <p><a href="#">상담일지</a></p>
		        </div>
		        <a class="accordion-section-title" href="#accordion-2">사용자</a>
		        <div id="accordion-2" class="accordion-section-content">
		            <p><a href="#">사용자 목록</a></p>
		        </div>
		        <a class="accordion-section-title" href="#accordion-3">거래처</a>
		        <div id="accordion-3" class="accordion-section-content">
		            <p><a href="#">거래처 목록</a></p>
		        </div>
		        <a class="accordion-section-title" href="#accordion-4">메시지함</a>
		        <div id="accordion-4" class="accordion-section-content">
		            <p><a href="#">메시지 보내기</a></p>
		            <p><a href="#">받은 메시지함</a></p>
		        </div>
		    </div>
		</div>
		<script src="${contextPath}/resources/jquery/jquery-2.2.0.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function() {

			    function close_accordion_section() {
			        $('.accordion .accordion-section-title').removeClass('active');
			        $('.accordion .accordion-section-content').slideUp(300).removeClass('open');
			    }

			    $('.accordion-section-title').click(function(e) {
			        var currentAttrValue = $(this).attr('href');

			        if($(e.target).is('.active')) {
			            close_accordion_section();
			        }else {
			            close_accordion_section();

			            // Add active class to section title
			            $(this).addClass('active');
			            // Open up the hidden content panel
			            $('.accordion ' + currentAttrValue).slideDown(300).addClass('open');
			        }

			        e.preventDefault();
			    });

			});
		</script>
	</body>
</html>