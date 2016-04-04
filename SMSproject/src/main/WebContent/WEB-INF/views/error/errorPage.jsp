<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>에러 페이지입니다</title>
</head>
<style>
h2 {
	position : absolute;
	left:35%;
}
img{
	position : absolute;
	top : 100px;
	left : 30px;
}
h5{
	position : absolute;
	top : 40%;
	left: 50%;
}
</style>
<body>
	<h2>${MESSAGE}</h2>
	<h5>방향키를 천천히 하나씩 눌러보세요</h5>
	<img alt="으어" src="/assets/image/noname.png">
	
	<!-- script -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>	
<script type="text/javascript" src="http://jsgetip.appspot.com"></script>
<script type="text/javascript">
var count = 0,
	distance = 500;
$(document).ready(function() {
	$('img').hover(function(){
		switch (count%4) {
		case 0:
			$(this).animate({left : '+='+distance},100);
			break;
		case 1:
			$(this).animate({top : '+='+distance},100);
			break;
		case 2:
			$(this).animate({left : '-='+distance},100);
			break;
		case 3:
			$(this).animate({top : '-='+distance},100);
			break;
		}
		count++;
		if(distance >50){
			distance -= 10;			
		}else{
			location.href= "http://"+ip()+"/";
		}
		
	});
});
$.getJSON("http://jsonip.com?callback=?", function (data) {
	   alert("Your ip: " + data.ip);
	});
</script>
</body>
</html>