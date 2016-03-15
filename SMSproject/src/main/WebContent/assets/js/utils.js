'use strict';
window.SortModule = (function(SortModule, $, undifined) {
  var formId;
  var initSort = function(targetFormId) {
    sortInit();
    sortClick();
    formId = targetFormId;
  };

  function sortInit() {
    var $sortName = $('#sortName');
    var $sortBy = $('#sortBy');

    var sortName = $sortName.val();
    var sortBy = $sortBy.val();

    var sortNameArr = sortName.length > 0 ? sortName.split(',') : [];
    var sortByArr = sortBy.length > 0 ? sortBy.split(',') : [];


    for (var i = 0; i < sortByArr.length; i++) {
      if (sortByArr[i] == 'asc') {
        $('#' + sortNameArr[i]).text('▲');
      } else if (sortByArr[i] == 'desc'){
        $('#' + sortNameArr[i]).text('▼');
      }
    }
  }

  function sortClick () {
    $('.sortHeader').on('click', function() {
      var dataSortName = $(this).data('sortname');
      var $sortLabel = $('#' + dataSortName);
      var $sortName = $('#sortName');
      var $sortBy = $('#sortBy');

      var sortLabel = $sortLabel.text();
      var sortName = $sortName.val();
      var sortBy = $sortBy.val();
      var newSortBy;

      if (sortLabel == '▲') {
        $sortLabel.text('▼');
        newSortBy = 'desc';
      } else if (sortLabel == '▼') {
        $sortLabel.text('');
        newSortBy = '';
      } else {
        $sortLabel.text('▲');
        newSortBy = 'asc';
      }

      var sortNameArr = sortName.length > 0 ? sortName.split(',') : [];
      console.log(sortName);
      var index = sortNameArr.indexOf(dataSortName);
      var sortByArr = sortBy.length > 0 ? sortBy.split(',') : [];

      if (newSortBy) {
        if (index > -1) {
          sortByArr.splice(index, 1, newSortBy);
        } else {
          console.log('sortNameArr11: ' + sortNameArr);
          sortNameArr.push(dataSortName);
          console.log('sortNameArr2: ' + sortNameArr);
          sortByArr.push(newSortBy);
        }
      } else {
        sortByArr.splice(index, 1);
        sortNameArr.splice(index, 1);
      }
      $sortName.val(sortNameArr.toString());
      console.log($sortName.val());
      $sortBy.val(sortByArr.toString());
      console.log($sortBy.val());
      $('#' + formId).submit();
    });
  }

  return {
    init : initSort
  }
})(window.SortModule || {}, jQuery);