<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script type="text/javascript" src="${contextPath}/assets/js/jquery.cookie.js"></script>

<!-- RSA Encryption JavaScript File -->
<script type="text/javascript" src="${contextPath}/assets/js/rsa/jsbn.js"></script>
<script type="text/javascript" src="${contextPath}/assets/js/rsa/rsa.js"></script>
<script type="text/javascript" src="${contextPath}/assets/js/rsa/prng4.js"></script>
<script type="text/javascript" src="${contextPath}/assets/js/rsa/rng.js"></script>

<script src="${contextPath}/assets/js/sidebar_menu.js"></script>
<script src="${contextPath}/assets/js/header.js"></script>

<!-- 웹소켓  -->
<script type="text/javascript"  src="${contextPath }/assets/js/socket/sockjs-1.0.3.js"></script>
<script type="text/javascript"  src="${contextPath }/assets/js/socket/stomp.js"></script>

<script type="text/javascript"  src="${contextPath }/assets/js/tag-it.js"></script>

<script type="text/javascript">
  var contextPath = '${contextPath}';
</script>