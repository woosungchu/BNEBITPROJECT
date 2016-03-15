<nav class="navbar navbar-inverse navbar-fixed-bottom">
  <div class="container">
     <a href="#menu-toggle" class="visible-xs btn btn-default" id="menu-toggle">First Toggle</a>
     <a href="#menu-toggle-2" class="hidden-xs btn btn-default" id="menu-toggle-2">Second Toggle</a>
  </div>
</nav>
<style>
a {
	margin-top : 7px;
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
