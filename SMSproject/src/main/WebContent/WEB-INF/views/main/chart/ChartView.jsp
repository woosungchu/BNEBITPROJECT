<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 화면에 맞춘 렌더링 및 확대 / 축소 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap Test</title>
<!-- Bootstrap -->
<link href="/assets/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link href="/assets/css/simple-sidebar2.css" rel="stylesheet">
<link href="/assets/css/woosung.css" rel="stylesheet">

<script type="text/javascript" src="/js/flotr2.min.js"></script>
</head>
<body style="background-color: #fff;">
	<div id="container"></div>
	<!--[if IE]>
    <script type="text/javascript" src="/static/lib/FlashCanvas/bin/flashcanvas.js"></script>
    <![endif]-->
	<script type="text/javascript">
		(function() {

			var container = document.getElementById('container'), start = (new Date)
					.getTime(), data, graph, offset, i;

			// Draw a sine curve at time t
			function animate(t) {

				data = [];
				offset = 2 * Math.PI * (t - start) / 10000;

				// Sample the sine function
				for (i = 0; i < 4 * Math.PI; i += 0.2) {
					data.push([ i, Math.sin(i - offset) ]);
				}

				// Draw Graph
				graph = Flotr.draw(container, [ data ], {
					yaxis : {
						max : 2,
						min : -2
					}
				});

				// Animate
				setTimeout(function() {
					animate((new Date).getTime());
				}, 50);
			}

			animate(start);
		})();
	</script>
	<tiles:insertDefinition name="base.definition">
	</tiles:insertDefinition>
	<div id="wrapper" class="">
		<!-- Page Content -->
		<div id="page-content-wrapper">
			<div class="container-fluid xyz"></div>
		</div>
		<!-- /#page-content-wrapper -->

	</div>
	<!-- /#wrapper -->

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="/assets/js/bootstrap.min.js"></script>
	<script src="/assets/js/sidebar_menu.js"></script>
</body>
</html>