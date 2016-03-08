$("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
     $("#menu-toggle-2").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled-2");
        $('#menu ul').hide();
    });

     function initMenu() {
	      $('#menu ul').hide();
	//      $('#menu').selectable(); //click event 안받아짐
//	      $('#menu ul').children('.current').parent().show();
	      //$('#menu ul:first').show();

	      $('#menu > li > a').click(function() {
	          var checkElement = $(this).next('ul');
	          $('#menu ul').not(checkElement).slideUp('normal');
	          checkElement.slideToggle('normal');
	      });

	      $('#menu li a').click(function() {
	          var liParent = $(this).parent('li');

	          $('#menu li').not(liParent).removeClass('active');
	          liParent.addClass('active');

	      });
      }




    $(document).ready(function() {initMenu();});