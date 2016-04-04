'use strict';
window.AdminPopupModule = (function(AdminPopupModule, $, undifined) {

  var messagePopup;

  var popupMessageForm = function() {
    $('#sendMessage').on('click', function() {
      var popupUrl = contextPath + '/admin/message/popup/messageForm';
      messagePopup = window.open(popupUrl, "_blank", "width=600, height=440, scrollbars=yes");
    });
  };

  var getIdMap = function() {
    var idMap = new Map();
    var cookies = $.cookie();

    for (var cookie in cookies) {
      if (cookie != 'JSESSIONID') {
        idMap.put(cookie, $.cookie(cookie));
      }
    }

    var idArr = idMap.keys();

    return idMap;
  };

  return {
    popupMessage : popupMessageForm,
    getIdMap : getIdMap
  }
})(window.AdminPopupModule || {}, jQuery);