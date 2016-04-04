<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-inverse navbar-fixed-bottom">
  <div class="container">
	<div class="input-group">
	  <span class="input-group-addon" id="basic-addon1"><i class="fa fa-bars"></i></span>
	  <input id="footerInput" type="text" class="form-control" placeholder="Search">
	</div>
  </div>
</nav>
<style>
/* adjusting footer */
.navbar-fixed-bottom .container{
	margin-top : 6px;
}
</style>
<script>
$("#menu-toggle").click(function(e) {
    e.preventDefault();
    $("#wrapper").toggleClass("toggled");
});
 $("#menu-toggle-2").click(function(e) {
    e.preventDefault();
    $("#wrapper").toggleClass("toggled-2");
    $('#menu ul').hide();
});
</script>
