'use strict';
window.DatePickerModule = (function(DatePickerModule, $, undefined) {
  var datepicker = $.fn.datepicker.noConflict();
  $.fn.bootstrapDP = datepicker;

  var commonOption = {
  format : 'yyyy-mm-dd',
  language : 'ko', // 화면에 출력될 언어를 한국어로 설정한다.
  pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략한다.
  // 생략한다.
  autoclose : true,
  endDate : 'd'
  };

  var initDateRangePicker = function(startId, endId) {
    initDatePicker(startId);
    initDatePicker(endId);
    dateRangeSet(startId, endId);
  };

  var initDatePicker = function(id) {
    $('#' + id).bootstrapDP(commonOption);
  };

  var dateRangeSet = function(startId, endId) {
    $('#' + startId).on('changeDate', function(selected) {
      var startDate = new Date(selected.date.valueOf());
      startDate.setDate(startDate.getDate(new Date(selected.date.valueOf())));
      $('#' + endId).bootstrapDP('setStartDate', startDate);
    });

    $('#' + endId).on('changeDate', function(selected) {
      var endDate = new Date(selected.date.valueOf());
      endDate.setDate(endDate.getDate(new Date(selected.date.valueOf())));
      $('#' + startId).bootstrapDP('setEndDate', endDate);
    });
  };

  return {
  initDatePicker : initDatePicker,
  initDateRangePicker : initDateRangePicker
  }

})(window.DatePickerModule || {}, jQuery);