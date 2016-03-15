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
<script type="text/javascript">
$(document).ready(function() {
    $(document).keydown(function(key) {
        switch(parseInt(key.which,10)) {
   // Left arrow key pressed
   case 37:
    $('img').animate({left: "-=10px"}, 'fast');
    break;
   case 38:
       $('img').animate({top: "-=10px"}, 'fast');
    break;
   // Right Arrow Pressed
   case 39:
    $('img').animate({left: "+=10px"}, 'fast');
    break;
   // Down Arrow Pressed
   case 40:
    $('img').animate({top: "+=10px"}, 'fast');
    break;
  }
 });
});
</script>
</body>
</html>